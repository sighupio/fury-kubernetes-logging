#!/usr/bin/env bats

apply (){
  kustomize build $1 >&2
  kustomize build $1 | kubectl apply -f - 2>&3
}

@test "applying monitoring" {
  kubectl apply -f https://raw.githubusercontent.com/coreos/prometheus-operator/master/example/prometheus-operator-crd/servicemonitor.crd.yaml
}

@test "testing elasticsearch-single apply" {
  apply katalog/elasticsearch-single
  kubectl get statefulsets -o json -n logging elasticsearch | jq 'del(.spec.template.spec.containers[].resources)' > /tmp/elasticsearch
  cat /tmp/elasticsearch >&2
  kubectl delete statefulsets -n logging elasticsearch >&2
  run kubectl apply -f /tmp/elasticsearch
}

@test "testing fluentd apply" {
  apply katalog/fluentd
}

@test "testing curator apply" {
  apply katalog/curator
}

@test "testing cerebro apply" {
  apply katalog/cerebro
}

@test "testing kibana apply" {
  apply katalog/kibana
}

@test "wait for apply to settle and dump state to dump.json" {
  max_retry=0
  echo "=====" $max_retry "=====" >&2
  while kubectl get pods --all-namespaces | grep -ie "\(Pending\|Error\|CrashLoop\|ContainerCreating\)" >&2
  do
    [ $max_retry -lt 100 ] || ( kubectl describe all --all-namespaces >&2 && return 1 )
    sleep 10 && echo "# waiting..." $max_retry >&3
    max_retry=$[ $max_retry + 1 ]
  done
}

#@test "check elasticsearch-single" {
  #test(){
    #jq '.items[] | select( .kind == "StatefulSet" and .metadata.name == "elasticsearch" and .status.replicas != .status.currentReplicas ) ' < /dump.json
  #}
  #run test
  #echo "$output" | jq '.' >&2
  #[ "$output" == "" ]
#}

#@test "check fluentd" {
  #test(){
    #jq '.items[] | select( .kind == "DaemonSet" and .metadata.name == "fluentd" and .status.desiredNumberScheduled != .status.numberReady ) ' < /dump.json
  #}
  #run test
  #echo "$output" | jq '.' >&2
  #[ "$output" == "" ]
#}

#@test "check cerebro" {
  #test(){
    #jq '.items[] | select( .kind == "Deployment" and .metadata.name == "cerebro" and .status.replicas != .status.readyReplicas ) ' < /dump.json
  #}
  #run test
  #echo "$output" | jq '.' >&2
  #[ "$output" == "" ]
#}

#@test "check kibana" {
  #test(){
    #jq '.items[] | select( .kind == "Deployment" and .metadata.name == "cerebro" and .status.replicas != .status.readyReplicas ) ' < /dump.json
  #}
  #run test
  #echo "$output" | jq '.' >&2
  #[ "$output" == "" ]
#

@test "cleanup" {
  if [ -z "${LOCAL_DEV_ENV}" ];
  then
    skip
  fi
  for dir in elasticsearch-single fluentd curator cerebro kibana
  do
    echo "# deleting katalog/$dir" >&3
    kustomize build katalog/$dir | kubectl delete -f - || true
    echo "# deleted katalog/$dir" >&3
  done
}
