# Cloudflare Tunnel

This directory contains the configuration for the Cloudflare Tunnel.

## Overview

The Cloudflare Tunnel is a daemon that runs on the edge and establishes outbound connections to the Cloudflare network. It then proxies incoming requests to the origin server.

## Login

```bash
cloudflared login
```

## Create a Tunnel

To create a new tunnel, run the following command:

```bash
TUNNEL_NAME=pi-k8s
cloudflared tunnel create $TUNNEL_NAME
```

## Create secret

```bash
kubectl -n kube-system create secret generic tunnel-credentials --dry-run=client \
--from-file=credentials.json=/root/.cloudflared/b32df1b7-6f82-4e59-8785-d3533750f7c6.json \
-o yaml | kubeseal --format=yaml > sealed-secret.yaml
```
