# Tailscale Operator

## Sealed Secrets

```bash
export TS_CLIENT_ID=xxx
export TS_CLIENT_SECRET=yyy
kubectl -n tailscale create secret generic operator-oauth \
  --from-literal=client_id=$TS_CLIENT_ID \
  --from-literal=client_secret=$TS_CLIENT_SECRET \
  --dry-run=client -o yaml | ./kubeseal --format=yaml > operator-oauth.yaml
```
