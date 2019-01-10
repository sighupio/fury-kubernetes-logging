#!/usr/bin/env bats

apply (){
  kustomize build $1 | kubectl apply -f - 2>&1 >&2
}

@test "testing elasticsearch-single apply" {
  run apply katalog/elasticsearch-single
  kubectl get statefulsets -o json -n logging elasticsearch | jq 'del(.spec.template.spec.containers[].resources)' > /tmp/elasticsearch
  cat /tmp/elasticsearch >&2
  kubectl delete statefulsets -n logging elasticsearch >&2
  run kubectl apply -f /tmp/elasticsearch >&2
  [ "$status" -eq 0 ]
  sleep 20
}

@test "testing fluentd apply" {
  run apply katalog/fluentd
  [ "$status" -eq 0 ]
}

@test "testing curator apply" {
  run apply katalog/curator
  [ "$status" -eq 0 ]
}

@test "testing cerebro apply" {
  run apply katalog/cerebro
  [ "$status" -eq 0 ]
}

@test "testing kibana apply" {
  run apply katalog/kibana
  [ "$status" -eq 0 ]
}

@test "wait for apply to settle and dump state to /dump.json" {
  max_retry=0
  echo "=====" $max_retry "=====" >&2
  while kubectl get pods --all-namespaces | grep -ie "\(Pending\|Error\|CrashLoop\|ContainerCreating\)" >&3
  do
    [ $max_retry -lt 24 ] || ( kubectl describe all --all-namespaces >&2 && return 1 )
    sleep 10 && echo "# waiting..." $max_retry >&3
    max_retry=$[ $max_retry + 1 ]
  done
  kubectl get all --all-namespaces -o json > /dump.json
  head /dump.json >&3
}

@test "check elasticsh-single" {
  test(){
    jq '.items[] | select( .kind == "StatefulSet" and .metadata.name == "elasticsearch" and .status.replicas != .status.currentReplicas ) ' < /dump.json
  }
  run test
  echo "$output" | jq '.' >&2
  [ "$output" == "" ]
}

@test "check fluentd" {
  test(){
    jq '.items[] | select( .kind == "DaemonSet" and .metadata.name == "fluentd" and .status.desiredNumberScheduled != .status.numberReady ) ' < /dump.json
  }
  run test
  echo "$output" | jq '.' >&2
  [ "$output" == "" ]
}

@test "check cerebro" {
  test(){
    jq '.items[] | select( .kind == "Deployment" and .metadata.name == "cerebro" and .status.replicas != .status.readyReplicas ) ' < /dump.json
  }
  run test
  echo "$output" | jq '.' >&2
  [ "$output" == "" ]
}

@test "check kibana" {
  test(){
    jq '.items[] | select( .kind == "Deployment" and .metadata.name == "cerebro" and .status.replicas != .status.readyReplicas ) ' < /dump.json
  }
  run test
  echo "$output" | jq '.' >&2
  [ "$output" == "" ]
}
