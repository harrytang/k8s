# Nextcloud

## Nextcloud ENV

```bash
export MINIO_ACCESS_KEY=$(openssl rand -base64 24 | tr -d '/+=' | cut -c1-20)
export MINIO_SECRET_KEY=$(openssl rand -base64 32 | tr -d '/+=' | cut -c1-40)
```

## MinIO config

create a `config.env` file with the following content:

```bash
export MINIO_ROOT_USER=harrytang
export MINIO_ROOT_PASSWORD=$(openssl rand -base64 24 | tr -d '/+=' | cut -c1-20)
```

```bash
kubectl -n s3 create secret generic minio-env-configuration --from-file=config.env --dry-run=client -o yaml | kubeseal --format yaml > minio-env-configuration.sealed-secret.yaml
```

MinIO Access key & Secret key

```bash
kubectl -n s3 create secret generic minio-user --from-literal=CONSOLE_ACCESS_KEY=$MINIO_ACCESS_KEY --from-literal=CONSOLE_SECRET_KEY=$MINIO_SECRET_KEY --dry-run=client -o yaml | kubeseal --format yaml > minio-user.sealed-secret.yaml
```

## MSIC

```bash
openssl s_client -connect minio.nextcloud.svc.cluster.local:443
```
