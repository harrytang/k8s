# Ingress

## Security Lists

Add the following Ingress Rules in the `xxx-nodeseclist-quick-oke-885a0a2c9` Security List:

```txt
10.0.20.0/24	TCP	All	All		TCP traffic for ports: All	Allow from oke-svclbsubnet (ingress)
```

Add the following Egress Rules in the `xxx-svclbseclist-quick-oke-yyy` Security List:

```txt
No	10.0.10.0/24	All Protocols				All traffic for all ports	Allow to oke-nodesubnet
```

## Security Groups

Create a `ingress` Security Group to allow 0.0.0.0/0 on port 80 and 443.
