# Longhorn

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
