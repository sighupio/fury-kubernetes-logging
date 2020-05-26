# Release notes

This release contains a refactoring on fluentd. The new architecture moves from fluentd DaemonSet to fluentbit DaemonSet
with fluentd as StatefulSet.

## Changelog

Changes between `1.3.0` and this release: `X.X.X`

- Added fluentbit DaemonSet
- Fluentd as StatefulSet with buffer PVCs
- New index as elasticsearch output on fluentd:
    - `kubernetes-*` all logs regarding workloads
    - `system-*` all logs regarding systemd and audit
    - `ingress-controller-*` all logging regarding nginx ingress controller
- Added rules on Cerebro to clean the additional indexes

## Upgrade Path

To upgrade to this release, you need to delete the fluentd daemonset:

```bash
kubectl delete ds fluentd -n logging
```

Before applying, go to kibana and create the new index mapping, for example on a triple elasticsearch:

```
PUT _template/fluentd-index-sighup
{
  "index_patterns" : ["system-*","kubernetes-*","ingress-controller-*",audit-*],
  "settings": {
    "number_of_shards": 3,
    "number_of_replicas": 1
  }
}
```

Then apply the new manifests.