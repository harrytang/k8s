# Observability

Observability stack

## Seal Secrets

- Slack URL (https://api.slack.com/apps)

  Create a channel for the k8s cluster

  Create new App (if not exist)

  Go to https://api.slack.com/apps > Your App -> Activate Incoming Webhooks and Add new Webhook to workspace and get the Webhook URL

  ```bash
  export SLACK_API_URL=https://hooks.slack.com/services/xxx/yyyy/zzz
  ```

  ```bash
  kubectl -n observability create secret generic --dry-run=client slack-url --from-literal=SLACK_API_URL=$SLACK_API_URL -o yaml | kubeseal --format=yaml > slack-url.sealed-secret.yaml
  ```

- Grafana Admin

  ```bash
  export ADMIN_USER=grafana
  export ADMIN_PASSWORD=$(openssl rand -base64 32)
  ```

  ```bash
  kubectl -n observability create secret generic --dry-run=client grafana-admin \
    --from-literal=ADMIN_USER=$ADMIN_USER \
    --from-literal=ADMIN_PASSWORD=$ADMIN_PASSWORD \
    -o yaml | kubeseal --format=yaml > grafana-admin.sealed-secret.yaml
  ```

- Tempo Storage

  ```bash
  export AWS_SECRET_ACCESS_KEY='xxx'
  kubectl -n observability create secret generic --dry-run=client tempo-env \
    --from-literal=AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
    -o yaml | kubeseal --format=yaml > tempo-env.sealed-secret.yaml
  ```
