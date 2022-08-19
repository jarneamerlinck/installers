# [Kubernetes client](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)
## Install process
Download and check sha256sum
```
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

chmod +x kubectl
mkdir -p ~/.local/bin
mv ./kubectl ~/.local/bin/kubectl
```
Append /home/user/.local/bin/ to path.

Check version to verify correct installation

```kubectl version --client --output=yaml ``` 

## kubectl configuration
- Path is ```~/.kube/config``` 
- Download kube config from ```/etc/rancher/k3s/k3s.yaml``` 


