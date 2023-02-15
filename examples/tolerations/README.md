# Kustomization example for tolerations

In this folder, you will find all the examples to extend/override tolerations used in our `katalogs`.

In all examples, we assume that the target nodes:

- have label `node.kubernetes.io/role: "infra"`

- have taint `node.kubernetes.io/role=infra` with effect `NoSchedule`

Notes:

- All the Host Tailers should be scheduled in all nodes, so they have by default the toleration `operator=Exists,effect=NoSchedule`

- Fluentbit is a DaemonSet and should be scheduled in all nodes, so it has by default the toleration `operator=Exists,effect=NoSchedule`