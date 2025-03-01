# OKE

My k8s cluster on OKE.

## FluxCD

```bash
flux bootstrap git \
  --components source-controller,kustomize-controller,helm-controller,notification-controller \
  --components-extra image-reflector-controller,image-automation-controller \
  --url=ssh://git@github.com/harrytang/k8s \
  --branch=main \
  --private-key-file=./id_ed25519 \
  --path=clusters/oke \
  --gpg-key-id=A28E2D40BEF33CC5 \
  --gpg-key-ring=./keyring.gpg \
  --author-email=it@harrytang.com \
  --author-name=mrgitops
```
