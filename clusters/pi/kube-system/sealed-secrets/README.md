# Sealed-secrets

backend private key

```bash
echo "---" >> main.key
kubectl get secret -n kube-system sealed-secrets-key -o yaml >>main.key
```
