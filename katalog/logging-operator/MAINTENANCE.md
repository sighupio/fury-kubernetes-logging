# Logging Operator - maintenance

To maintain the Logging Operator package, you should follow these steps.

1. Find the available chart versions:
   ```bash
   mise run chart-versions
   ```
   - If necessary, add a newer version on our [container-image-sync](https://github.com/sighupio/container-image-sync/blob/main/modules/logging/images.yml) git repo
    - **NOTE:** the chart version here MUST be kept in sync with the data plane images defined in [`logging-operated`](../logging-operated/MAINTENANCE.md).

2. Run the upgrade task with the desired chart version:
   ```bash
   mise run upgrade 6.8.0
   ```

What was customized (what differs from the helm template command):

- Removed openshift-related permissions from ClusterRole
- Removed some labels in rbac resources
