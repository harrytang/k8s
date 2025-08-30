# cert-manager

## Cloudflare Token Sealed Secrets

```bash
export API_TOKEN=YOUR_CF_API_TOKEN
kubectl -n cert-manager create secret generic cloudflare-api-token --from-literal=api-token=$API_TOKEN --dry-run=client -o yaml | kubeseal --format yaml > cloudflare-api-token.yaml
```
