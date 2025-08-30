# Nextcloud

## Nextcloud ENV

```bash
export NEXTCLOUD_ADMIN_USER=harry
export NEXTCLOUD_ADMIN_PASSWORD=$(openssl rand -base64 32)
export SMTP_HOST=smtp.eu.mailgun.org
export SMTP_USER=nextcloud@notify.harrytang.com
export SMTP_PASSWORD=YOUR_SMTP_PASSWORD
export MINIO_ACCESS_KEY=$(openssl rand -base64 24 | tr -d '/+=' | cut -c1-20)
export MINIO_SECRET_KEY=$(openssl rand -base64 32 | tr -d '/+=' | cut -c1-40)
```

```bash
kubectl -n nextcloud create secret generic nextcloud-secrets --dry-run=client --from-literal=nextcloud-password=$NEXTCLOUD_ADMIN_PASSWORD \
  --from-literal=nextcloud-username=$NEXTCLOUD_ADMIN_USER \
  --from-literal=smtp-host=$SMTP_HOST \
  --from-literal=smtp-username=$SMTP_USER \
  --from-literal=smtp-password=$SMTP_PASSWORD \
  --from-literal=minio-access-key=$MINIO_ACCESS_KEY \
  --from-literal=minio-secret-key=$MINIO_SECRET_KEY \
   -o yaml | kubeseal --format=yaml > sealed-secret.yaml
```

## MinIO config

create a `config.env` file with the following content:

```bash
export MINIO_ROOT_USER='nextcloud'
export MINIO_ROOT_PASSWORD=$(openssl rand -base64 32)
```

```bash
kubectl -n nextcloud create secret generic minio-env-configuration --from-file=config.env --dry-run=client -o yaml | kubeseal --format yaml > minio-env-configuration.sealed-secret.yaml
```

MinIO Access key & Secret key

```bash
kubectl -n nextcloud create secret generic minio-user --from-literal=CONSOLE_ACCESS_KEY=$MINIO_ACCESS_KEY --from-literal=CONSOLE_SECRET_KEY=$MINIO_SECRET_KEY --dry-run=client -o yaml | kubeseal --format yaml > minio-user.sealed-secret.yaml
```

## MariaDB Password

```bash
kubectl -n nextcloud create secret generic mariadb --from-literal=mariadb-username=nextcloud --from-literal=mariadb-password=$(openssl rand -base64 24 | tr -d '/+=' | cut -c1-32
) --dry-run=client -o yaml | kubeseal --format yaml > mariadb.sealed-secret.yaml
```

## MSIC

```bash
openssl s_client -connect minio.nextcloud.svc.cluster.local:443
```
