# Release notes

This release contains a refactoring on fluentd. The new architecture moves from fluentd DaemonSet to fluentbit DaemonSet
with fluentd as StatefulSet.

## Changelog

Changes between `1.3.0` and this release: `X.X.X`

- Added fluentbit DaemonSet
- Fluentd as StatefulSet with buffer PVCs
- New index as elasticsearch output on fluentd:
    - `kubernetes-*` all logs regarding workloads
    - `system-*` all logs regarding systemd
    - `ingress-controller-*` all logging regarding nginx ingress controller
    - `audit-*` all logging regarding audit
- Added rules on Cerebro to clean the additional indexes

## Upgrade Path

To upgrade to this release, you need to delete the fluentd daemonset:

```bash
kubectl delete ds fluentd -n logging
```

This index template is also automatically created/force updated:

`fluentd-index-sighup-template.json`:
```json
{
  "index_patterns" : ["system-*","kubernetes-*","ingress-controller-*","audit-*"],
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 2
  }
}
```

To change the template, create your template file with the name: fluentd-index-sighup-template.json

And do a kustomize replace:

```yaml
configMapGenerator:
  - name: fluentd-index-template
    behavior: replace
    files:
      - fluentd-index-sighup-template.json=fluentd-index-sighup-template.json
```

Then apply the new manifests.


### Notes

If you want to use `elasticsearch-single`, replace the default index template with:

`fluentd-index-sighup-template.json`:
```json
{
  "index_patterns" : ["system-*","kubernetes-*","ingress-controller-*","audit-*"],
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 0
  }
}
```

And replace it via kustomize 

```yaml
configMapGenerator:
  - name: fluentd-index-template
    behavior: replace
    files:
      - fluentd-index-sighup-template.json=fluentd-index-sighup-template.json
```
