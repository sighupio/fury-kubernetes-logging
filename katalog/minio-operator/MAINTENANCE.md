

```
helm repo add minio https://operator.min.io/
helm template --namespace logging minio-operator minio/operator > deploy.yaml
```