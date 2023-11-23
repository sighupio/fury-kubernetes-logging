# Compatibility Matrix

| Module Version / Kubernetes Version |       1.20.X       |       1.21.X       |       1.22.X       | 1.23.X             | 1.24.X             | 1.25.X             | 1.26.X             | 1.27.X             |
| ----------------------------------- | :----------------: | :----------------: | :----------------: | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ |
| v2.0.0                              |     :warning:      |     :warning:      |     :warning:      | :warning:          |                    |                    |                    |                    |
| v2.0.1                              | :white_check_mark: | :white_check_mark: | :white_check_mark: | :warning:          |                    |                    |                    |                    |
| v2.0.2                              | :white_check_mark: | :white_check_mark: | :white_check_mark: | :warning:          |                    |                    |                    |                    |
| v3.0.0                              |                    | :white_check_mark: | :white_check_mark: | :white_check_mark: | :warning:          | :warning:          |                    |                    |
| v3.0.1                              |                    | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |                    |                    |                    |
| v3.0.2                              |                    | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |                    |                    |                    |
| v3.0.3                              |                    | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |                    |                    |                    |
| v3.1.0                              |                    |                    |                    | :white_check_mark: | :white_check_mark: | :white_check_mark: |                    |                    |
| v3.1.1                              |                    |                    |                    | :white_check_mark: | :white_check_mark: | :white_check_mark: |                    |                    |
| v3.1.2                              |                    |                    |                    | :white_check_mark: | :white_check_mark: | :white_check_mark: |                    |                    |
| v3.1.3                              |                    |                    |                    | :white_check_mark: | :white_check_mark: | :white_check_mark: |                    |                    |
| v3.2.0                              |                    |                    |                    |                    | :warning:          | :warning:          | :warning:          |                    |
| v3.2.1                              |                    |                    |                    |                    | :white_check_mark: | :white_check_mark: | :white_check_mark: |                    |
| v3.3.0                              |                    |                    |                    |                    |                    | :white_check_mark: | :white_check_mark: | :white_check_mark: |

- :white_check_mark: Compatible
- :warning: Has issues
- :x: Incompatible

## Warning

- ⚠️: module version: v1.7.0 and Kubernetes Version: 1.20.x. It works as expected. Marked as warning because it is not officially supported by SIGHUP.
- ⚠️: module version: v1.8.0 and Kubernetes Version: 1.21.x. It works as expected. Marked as warning because it is not officially supported by SIGHUP.
- ⚠️: module version: v1.9.0 and Kubernetes Version: 1.22.x. It works as expected. Marked as warning because it is not officially supported by SIGHUP.
- ⚠️: module version: v1.8.0 has known with fluentd, use v1.9.1 instead.
- :x:: module version: v1.10.0 has a known bug breaking upgrades. Please do not use.
- :x:: module version: v1.10.1 has a known bug breaking upgrades. Please do not use.

## Legacy versons

| Module Version / Kubernetes Version |       1.14.X       |       1.15.X       |       1.16.X       |       1.17.X       |       1.18.X       |       1.19.X       |       1.20.X       |       1.21.X       |       1.22.X       | 1.23.X    |
| ----------------------------------- | :----------------: | :----------------: | :----------------: | :----------------: | :----------------: | :----------------: | :----------------: | :----------------: | :----------------: | --------- |
| v1.0.0                              | :white_check_mark: |                    |                    |                    |                    |                    |                    |                    |                    |           |
| v1.1.0                              | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |                    |                    |                    |           |
| v1.2.0                              |                    |                    |                    |                    |                    |                    |                    |                    |                    |           |
| v1.2.1                              | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |                    |                    |                    |           |
| v1.3.0                              | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |                    |                    |                    |           |
| v1.4.0                              | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |                    |                    |                    |           |
| v1.5.0                              |                    |                    | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |                    |                    |                    |           |
| v1.6.0                              |                    |                    | :white_check_mark: | :white_check_mark: | :white_check_mark: |     :warning:      |                    |                    |                    |           |
| v1.7.0                              |                    |                    |                    | :white_check_mark: | :white_check_mark: | :white_check_mark: |     :warning:      |                    |                    |           |
| v1.8.0                              |                    |                    |                    |                    |     :warning:      |     :warning:      |     :warning:      |     :warning:      |                    |           |
| v1.9.0                              |                    |                    |                    |                    |                    | :white_check_mark: | :white_check_mark: | :white_check_mark: |     :warning:      |           |
| v1.10.0                             |                    |                    |                    |                    |                    |                    |        :x:         |        :x:         |        :x:         | :x:       |
| v1.10.1                             |                    |                    |                    |                    |                    |                    |        :x:         |        :x:         |        :x:         | :x:       |
| v1.10.2                             |                    |                    |                    |                    |                    |                    | :white_check_mark: | :white_check_mark: | :white_check_mark: | :warning: |
| v1.10.3                             |                    |                    |                    |                    |                    |                    | :white_check_mark: | :white_check_mark: | :white_check_mark: | :warning: |
