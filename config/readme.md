# Readme

Misc configuration files for k8s cluster.

## Node Config

Disable IPv6

```bash
sudo tee /etc/sysctl.d/99-disable-ipv6.conf <<EOF
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
EOF
sudo sysctl --system
```

HAProxy

```bash
sudo apt install -y haproxy
sudo systemctl enable haproxy
sudo systemctl start haproxy
```

add Config

```bash
# /etc/haproxy/haproxy.cfg
# Kubernetes API LB (TCP passthrough)
frontend k8s-api
        bind 0.0.0.0:6443
        default_backend k8s-api-backend

backend k8s-api-backend
        balance roundrobin
        option tcp-check
        # We use TCP-level health checks; keeps it simple (no TLS term)
        tcp-check connect
        server pi1 192.168.68.58:6443 check fall 3 rise 2
        server pi2 192.168.68.61:6443 check fall 3 rise 2
        server pi3 192.168.68.57:6443 check fall 3 rise 2
```

## Order of deployment

1. kube-system/csr-approver
1. kube-system/metrics-server
1. kube-system/sealed-secrets
1. cert-manager
1. longhorn-system (partially, waiting for prometheus)
1. CF Tunnel
1. Observability (partially, waiting for istio, trivy dashboard)
1. longhorn-system (continue with rules & service monitor)
1. trivy-system (noneed for now)
1. Observability (continue longhorn dashboard)
1. kube-system/kured (need to wait for prometheus)
1. default/reloader

## Update kubeadm config

```bash
kubeadm config migrate --old-config old-config.yaml --new-config new-config.yaml
```

## Flux

```bash
flux bootstrap git \
  --cluster-domain=k8s.harrytang.com \
  --components source-controller,kustomize-controller,helm-controller,notification-controller \
  --components-extra image-reflector-controller,image-automation-controller \
  --url=ssh://git@github.com/harrytang/k8s \
  --branch=main \
  --private-key-file=./id_ed25519 \
  --path=clusters/pi \
  --gpg-key-id=A28E2D40BEF33CC5 \
  --gpg-key-ring=./keyring.gpg \
  --author-email=it@harrytang.com \
  --author-name=mrgitops
```
