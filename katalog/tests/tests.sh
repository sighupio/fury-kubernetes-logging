#!/usr/bin/env bats
# Copyright (c) 2020 SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

# shellcheck disable=SC2154

load helper

set -o pipefail

@test "applying monitoring" {
  info
  kubectl apply -f https://raw.githubusercontent.com/sighupio/fury-kubernetes-monitoring/v1.10.3/katalog/prometheus-operator/crd-servicemonitor.yml
  kubectl apply -f https://raw.githubusercontent.com/sighupio/fury-kubernetes-monitoring/v1.10.3/katalog/prometheus-operator/crd-rule.yml
}

@test "testing logging-operator apply" {
  info
  apply katalog/logging-operator
}

@test "testing opensearch-single apply" {
  info
  apply katalog/opensearch-single
}

@test "testing logging-operated apply" {
  info
  apply katalog/logging-operated

}

@test "testing kubernetes config apply" {
  info
  apply katalog/configs/kubernetes
}

@test "testing cerebro apply" {
  info
  apply katalog/cerebro
}

@test "testing opensearch-dashboards apply" {
  info
  apply katalog/opensearch-dashboards
}

@test "wait for apply to settle and dump state to dump.json" {
  info
  max_retry=0
  echo "=====" $max_retry "=====" >&2
  while kubectl get pods --all-namespaces | grep -ie "\(Pending\|Error\|CrashLoop\|ContainerCreating\|PodInitializing\)" >&2
  do
    [ $max_retry -lt 30 ] || ( kubectl describe all --all-namespaces >&2 && return 1 )
    sleep 10 && echo "# waiting..." $max_retry >&3
    max_retry=$((max_retry+1))
  done
}

@test "check opensearch-single" {
  info
  test(){
    data=$(kubectl get sts -n logging -l app.kubernetes.io/name=opensearch -o json | jq '.items[] | select(.metadata.name == "opensearch-cluster-master" and .status.replicas == .status.readyReplicas)')
    if [ "${data}" == "" ]; then return 1; fi
  }
  loop_it test 60 5
  status=${loop_it_result}
  [[ "$status" -eq 0 ]]
}

@test "check fluentbit" {
  info
  test(){
    data=$(kubectl get ds -n logging -l app.kubernetes.io/name=fluentbit -o json | jq '.items[] | select(.metadata.name == "infra-fluentbit" and .status.desiredNumberScheduled == .status.numberReady)')
    if [ "${data}" == "" ]; then return 1; fi
  }
  loop_it test 60 5
  status=${loop_it_result}
  [[ "$status" -eq 0 ]]
}

@test "check fluentd" {
  info
  test(){
    data=$(kubectl get sts -n logging -l app.kubernetes.io/name=fluentd -o json | jq '.items[] | select(.metadata.name == "infra-fluentd" and .status.replicas == .status.readyReplicas )')
    if [ "${data}" == "" ]; then return 1; fi
  }
  loop_it test 60 5
  status=${loop_it_result}
  [[ "$status" -eq 0 ]]
}

@test "check cerebro" {
  info
  test(){
    data=$(kubectl get deploy -n logging -l app=cerebro -o json | jq '.items[] | select(.metadata.name == "cerebro" and .status.replicas == .status.readyReplicas )')
    if [ "${data}" == "" ]; then return 1; fi
  }
  loop_it test 60 5
  status=${loop_it_result}
  [[ "$status" -eq 0 ]]
}

@test "check opensearch-dashboards" {
  info
  test(){
    data=$(kubectl get deploy -n logging -l app.kubernetes.io/name=opensearch-dashboards -o json | jq '.items[] | select(.metadata.name == "opensearch-dashboards" and .status.replicas == .status.readyReplicas )')
    if [ "${data}" == "" ]; then return 1; fi
  }
  loop_it test 400 6
  status=${loop_it_result}
  [[ "$status" -eq 0 ]]
}

@test "cleanup" {
  if [ -z "${LOCAL_DEV_ENV}" ];
  then
    skip
  fi
  for dir in opensearch-single fluentd cerebro opensearch-dashboards
  do
    echo "# deleting katalog/$dir" >&3
    kustomize build katalog/$dir | kubectl delete -f - || true
    echo "# deleted katalog/$dir" >&3
  done
}
