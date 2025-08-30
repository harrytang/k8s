# Kured

First add the bot to slack channel.

Go to https://api.slack.com/apps -> Select the app -> Incoming Webhooks -> get the token

```bash
export KURED_NOTIFY_URL=slack://KuredBot@tokenA/tokenB/tokenC
kubectl -n kube-system create secret generic kured-env --dry-run=client \
--from-literal=KURED_NOTIFY_URL=$KURED_NOTIFY_URL \
-o yaml | kubeseal --format=yaml > sealed-secret.yaml
```
