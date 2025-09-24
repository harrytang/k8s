# Longhorn

## Label Longhorn nodes

```bash
kubectl label nodes pi1 longhorn.io=true
kubectl label nodes pi2 longhorn.io=true
kubectl label nodes pi3 longhorn.io=true
kubectl label nodes pi4 longhorn.io=true
kubectl label nodes pi5 longhorn.io=true
kubectl label nodes pi6 longhorn.io=true
```

## Scaleway secret for backups

```bash
export AWS_ACCESS_KEY_ID='toBeDefined'
export AWS_SECRET_ACCESS_KEY='toBeDefined'
export AWS_ENDPOINTS='https://s3.nl-ams.scw.cloud'
export AWS_REGION='nl-ams'
kubectl create secret generic scaleway --dry-run=client \
    --namespace=longhorn-system \
    --from-literal=AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
    --from-literal=AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
    --from-literal=AWS_ENDPOINTS=$AWS_ENDPOINTS \
    --from-literal=AWS_REGION=$AWS_REGION \
    -o yaml \
    | kubeseal --format=yaml > scaleway.sealed-secret.yaml
```

## Encryption

```bash
export CRYPTO_KEY_VALUE=$(openssl rand -base64 32)
export CRYPTO_KEY_PROVIDER="secret"
export CRYPTO_KEY_CIPHER="aes-xts-plain64"
export CRYPTO_KEY_HASH="sha256"
export CRYPTO_KEY_SIZE="256"
export CRYPTO_PBKDF="argon2i"
kubectl create secret generic longhorn-crypto --dry-run=client \
    --namespace=longhorn-system \
    --from-literal=CRYPTO_KEY_VALUE=$CRYPTO_KEY_VALUE \
    --from-literal=CRYPTO_KEY_PROVIDER=$CRYPTO_KEY_PROVIDER \
    --from-literal=CRYPTO_KEY_CIPHER=$CRYPTO_KEY_CIPHER \
    --from-literal=CRYPTO_KEY_HASH=$CRYPTO_KEY_HASH \
    --from-literal=CRYPTO_KEY_SIZE=$CRYPTO_KEY_SIZE \
    --from-literal=CRYPTO_PBKDF=$CRYPTO_PBKDF \
    -o yaml \
    | kubeseal --format=yaml > longhorn-crypto.sealed-secret.yaml
```
