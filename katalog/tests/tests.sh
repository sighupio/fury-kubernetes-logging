#!/usr/bin/env bats
# Copyright (c) 2020 SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

# shellcheck disable=SC2154

load helper

set -o pipefail

@test "applying monitoring" {
  info
  kubectl apply -f https://raw.githubusercontent.com/sighupio/fury-kubernetes-monitoring/v1.7.1/katalog/prometheus-operator/crd-servicemonitor.yml
  kubectl apply -f https://raw.githubusercontent.com/sighupio/fury-kubernetes-monitoring/v1.7.1/katalog/prometheus-operator/crd-rule.yml
}

@test "testing elasticsearch-single apply" {
  info
  apply katalog/elasticsearch-single
  kubectl get statefulsets -o json -n logging elasticsearch | jq 'del(.spec.template.spec.containers[].resources)' > /tmp/elasticsearch
  cat /tmp/elasticsearch >&2
  kubectl delete statefulsets -n logging elasticsearch >&2
  run kubectl apply -f /tmp/elasticsearch
}

@test "testing fluentd apply" {
  info
  apply katalog/fluentd
  kubectl -n logging get sts fluentd -o json | jq -r .spec.replicas=2 | kubectl apply -f -
}

@test "testing curator apply" {
  info
  apply katalog/curator
}

@test "testing cerebro apply" {
  info
  apply katalog/cerebro
}

@test "testing kibana apply" {
  info
  apply katalog/kibana
}

@test "wait for apply to settle and dump state to dump.json" {
  info
  max_retry=0
  echo "=====" $max_retry "=====" >&2
  while kubectl get pods --all-namespaces | grep -ie "\(Pending\|Error\|CrashLoop\|ContainerCreating\)" >&2
  do
    [ $max_retry -lt 100 ] || ( kubectl describe all --all-namespaces >&2 && return 1 )
    sleep 10 && echo "# waiting..." $max_retry >&3
    max_retry=$((max_retry+1))
  done
}

@test "check elasticsearch-single" {
  info
  test(){
    kubectl get sts,ds,deploy -n logging -o json | jq '.items[] | select( .kind == "StatefulSet" and .metadata.name == "elasticsearch" and .status.replicas != .status.currentReplicas ) '
  }
  loop_it test 60 3
  status=${loop_it_result}
  [[ "$status" -eq 0 ]]
}

@test "check fluentbit" {
  info
  test(){
    kubectl get sts,ds,deploy -n logging -o json | jq '.items[] | select( .kind == "DaemonSet" and .metadata.name == "fluentbit" and .status.desiredNumberScheduled != .status.numberReady ) '
  }
  loop_it test 60 3
  status=${loop_it_result}
  [[ "$status" -eq 0 ]]
}

@test "check fluentd" {
  info
  test(){
    kubectl get sts,ds,deploy -n logging -o json | jq '.items[] | select( .kind == "StatefulSet" and .metadata.name == "fluentd" and .status.replicas != .status.readyReplicas ) '
  }
  loop_it test 60 3
  status=${loop_it_result}
  [[ "$status" -eq 0 ]]
}

@test "check cerebro" {
  info
  test(){
    kubectl get sts,ds,deploy -n logging -o json | jq '.items[] | select( .kind == "Deployment" and .metadata.name == "cerebro" and .status.replicas != .status.readyReplicas ) '
  }
  loop_it test 60 3
  status=${loop_it_result}
  [[ "$status" -eq 0 ]]
}

@test "check kibana" {
  info
  test(){
    kubectl get sts,ds,deploy -n logging -o json | jq '.items[] | select( .kind == "Deployment" and .metadata.name == "kibana" and .status.replicas != .status.readyReplicas ) '
  }
  loop_it test 60 3
  status=${loop_it_result}
  [[ "$status" -eq 0 ]]
}

@test "run curator job" {
  info
  test(){
    kubectl -n logging create job curator-test --from cronjob/curator
    kubectl -n logging wait --for=condition=complete job/curator-test --timeout=600s
  }
  run test
  [ "$status" -eq 0 ]
}

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
