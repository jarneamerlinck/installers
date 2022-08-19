# kubernetes tools

## Datree
```bash
curl https://get.datree.io | /bin/bash
```
add zsh completion
```helm completion zsh > "${fpath[1]}/_helm"```

## Helm
```bash
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
```
add zsh completion
```helm completion zsh > "${fpath[1]}/_helm"```



## Traefik

| What             | Command                                                             |
| ---------------- | :------------------------------------------------------------------ |
| add repo         | ```h repo add traefik https://helm.traefik.io/traefik```            |
| update           | ```h repo update```                                                 |
| create namespace | ```k create namespace traefik```                                    |
| install traefik  | ```h install traefik traefik/traefik --values traefik-values.yml``` |
