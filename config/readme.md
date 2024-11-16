# Readme

Misc configuration files for k8s cluster.

## Order of deployment

1. kube-system/csr-approver
1. kube-system/metrics-server
1. kube-system/sealed-secrets
1. cert-manager
1. longhorn-system (partially, waiting for prometheus)
1. CF Tunnel
1. Observability (partially, waiting for istio, trivy dashboard)
1. longhorn-system (continue)
1. trivy-system
1. Observability (continue trivy dashboard)
1. default/reloader

## Update kubeadm config

```bash
kubeadm config migrate --old-config old-config.yaml --new-config new-config.yaml
```
