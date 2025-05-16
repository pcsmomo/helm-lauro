# Helm: The Definitive Guide from Beginner to Master by Lauro Fialho Müller

## Folder structure

## Details

<details open>
  <summary>Click to Contract/Expend</summary>

## Section 2: What is Helm?

### 7. Benefits of using Helm

#### Benefits

- Simplified Deployment Process
- Consistency Across Environments
- Efficient Release Management
- Enhanced Collaboration
- Versioned Deployments
- Templating Flexibility

#### Limitations

- Learning Curve
- Over-templating and Hard-to-Maintain Charts
- Security Implications
- Release State is stored in the Cluster
- Upgrades might be challenging to perform

## Section 3: Installing Tools

### 12. Installing Minikube

<https://minikube.sigs.k8s.io/docs/start/?arch=%2Fmacos%2Farm64%2Fstable%2Fbinary+download>

```sh
curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-darwin-arm64
sudo install minikube-darwin-arm64 /usr/local/bin/minikube

minikube version
# minikube version: v1.35.0
# commit: dd5d320e41b5451cdf3c01891bc4e13d189586ed-dirty
```

```sh
minikube start
# 😄  minikube v1.35.0 on Darwin 15.4.1 (arm64)
# 🆕  Kubernetes 1.32.0 is now available. If you would like to upgrade, specify: --kubernetes-version=v1.32.0
# ✨  Using the docker driver based on existing profile
# 👍  Starting "minikube" primary control-plane node in "minikube" cluster
# 🚜  Pulling base image v0.0.46 ...
# 🤷  docker "minikube" container is missing, will recreate.
# 🔥  Creating docker container (CPUs=2, Memory=7803MB) ...
# ❗  Image was not built for the current minikube version. To resolve this you can delete and recreate your minikube cluster using the latest images. Expected minikube version: v1.29.0 -> Actual minikube version: v1.35.0
# 🐳  Preparing Kubernetes v1.26.1 on Docker 20.10.23 ...
#     ▪ Generating certificates and keys ...
#     ▪ Booting up control plane ...
#     ▪ Configuring RBAC rules ...
# 🔗  Configuring bridge CNI (Container Networking Interface) ...
# 🔎  Verifying Kubernetes components...
# 💡  After the addon is enabled, please run "minikube tunnel" and your ingress resources would be available at "127.0.0.1"
#     ▪ Using image docker.io/kubernetesui/dashboard:v2.7.0
#     ▪ Using image gcr.io/k8s-minikube/storage-provisioner:v5
#     ▪ Using image registry.k8s.io/ingress-nginx/kube-webhook-certgen:v1.4.4
#     ▪ Using image docker.io/kubernetesui/metrics-scraper:v1.0.8
#     ▪ Using image registry.k8s.io/ingress-nginx/kube-webhook-certgen:v1.4.4
#     ▪ Using image registry.k8s.io/ingress-nginx/controller:v1.11.3
# 🔎  Verifying ingress addon...
# 💡  Some dashboard features require the metrics-server addon. To enable all features please run:

#  minikube addons enable metrics-server

# 🌟  Enabled addons: storage-provisioner, default-storageclass, dashboard, ingress
# 🏄  Done! kubectl is now configured to use "minikube" cluster and "default" namespace by default


# delete the old configuration from 2-3 years ago
rm -rf ~/.minikube

# another error...
minikube start
# 😄  minikube v1.35.0 on Darwin 15.4.1 (arm64)
# ✨  Using the docker driver based on existing profile
# 👍  Starting "minikube" primary control-plane node in "minikube" cluster
# 🚜  Pulling base image v0.0.46 ...
# 🏃  Updating the running docker "minikube" container ...
# 🐳  Preparing Kubernetes v1.32.0 on Docker 27.4.1 ...
#     ▪ Generating certificates and keys ...
# 💢  initialization failed, will try again: wait: /bin/bash -c "sudo env PATH="/var/lib/minikube/binaries/v1.32.0:$PATH" kubeadm init --config /var/tmp/minikube/kubeadm.yaml  --ignore-preflight-errors=DirAvailable--etc-kubernetes-manifests,DirAvailable--var-lib-minikube,DirAvailable--var-lib-minikube-etcd,FileAvailable--etc-kubernetes-manifests-kube-scheduler.yaml,FileAvailable--etc-kubernetes-manifests-kube-apiserver.yaml,FileAvailable--etc-kubernetes-manifests-kube-controller-manager.yaml,FileAvailable--etc-kubernetes-manifests-etcd.yaml,Port-10250,Swap,NumCPU,Mem,SystemVerification,FileContent--proc-sys-net-bridge-bridge-nf-call-iptables": Process exited with status 1
# stdout:
# [init] Using Kubernetes version: v1.32.0
# [preflight] Running pre-flight checks
# [preflight] Pulling images required for setting up a Kubernetes cluster
# [preflight] This might take a minute or two, depending on the speed of your internet connection
# [preflight] You can also perform this action beforehand using 'kubeadm config images pull'
# [certs] Using certificateDir folder "/var/lib/minikube/certs"
# [certs] Using existing ca certificate authority
# [certs] Using existing apiserver certificate and key on disk

# stderr:
#  [WARNING Swap]: swap is supported for cgroup v2 only. The kubelet must be properly configured to use swap. Please refer to https://kubernetes.io/docs/concepts/architecture/nodes/#swap-memory, or disable swap on the node
#  [WARNING Service-Kubelet]: kubelet service is not enabled, please run 'systemctl enable kubelet.service'
#  [WARNING DirAvailable--var-lib-minikube-etcd]: /var/lib/minikube/etcd is not empty
# error execution phase certs/apiserver-kubelet-client: [certs] certificate apiserver-kubelet-client not signed by CA certificate ca: x509: certificate signed by unknown authority (possibly because of "crypto/rsa: verification error" while trying to verify candidate authority certificate "minikubeCA")
# To see the stack trace of this error execute with --v=5 or higher

#     ▪ Generating certificates and keys ...

# 💣  Error starting cluster: wait: /bin/bash -c "sudo env PATH="/var/lib/minikube/binaries/v1.32.0:$PATH" kubeadm init --config /var/tmp/minikube/kubeadm.yaml  --ignore-preflight-errors=DirAvailable--etc-kubernetes-manifests,DirAvailable--var-lib-minikube,DirAvailable--var-lib-minikube-etcd,FileAvailable--etc-kubernetes-manifests-kube-scheduler.yaml,FileAvailable--etc-kubernetes-manifests-kube-apiserver.yaml,FileAvailable--etc-kubernetes-manifests-kube-controller-manager.yaml,FileAvailable--etc-kubernetes-manifests-etcd.yaml,Port-10250,Swap,NumCPU,Mem,SystemVerification,FileContent--proc-sys-net-bridge-bridge-nf-call-iptables": Process exited with status 1
# stdout:
# [init] Using Kubernetes version: v1.32.0
# [preflight] Running pre-flight checks
# [preflight] Pulling images required for setting up a Kubernetes cluster
# [preflight] This might take a minute or two, depending on the speed of your internet connection
# [preflight] You can also perform this action beforehand using 'kubeadm config images pull'
# [certs] Using certificateDir folder "/var/lib/minikube/certs"
# [certs] Using existing ca certificate authority
# [certs] Using existing apiserver certificate and key on disk

# stderr:
#  [WARNING Swap]: swap is supported for cgroup v2 only. The kubelet must be properly configured to use swap. Please refer to https://kubernetes.io/docs/concepts/architecture/nodes/#swap-memory, or disable swap on the node
#  [WARNING Service-Kubelet]: kubelet service is not enabled, please run 'systemctl enable kubelet.service'
#  [WARNING DirAvailable--var-lib-minikube-etcd]: /var/lib/minikube/etcd is not empty
# error execution phase certs/apiserver-kubelet-client: [certs] certificate apiserver-kubelet-client not signed by CA certificate ca: x509: certificate signed by unknown authority (possibly because of "crypto/rsa: verification error" while trying to verify candidate authority certificate "minikubeCA")
# To see the stack trace of this error execute with --v=5 or higher


# ╭───────────────────────────────────────────────────────────────────────────────────────────╮
# │                                                                                           │
# │    😿  If the above advice does not help, please let us know:                             │
# │    👉  https://github.com/kubernetes/minikube/issues/new/choose                           │
# │                                                                                           │
# │    Please run `minikube logs --file=logs.txt` and attach logs.txt to the GitHub issue.    │
# │                                                                                           │
# ╰───────────────────────────────────────────────────────────────────────────────────────────╯

# ❌  Exiting due to GUEST_START: failed to start node: wait: /bin/bash -c "sudo env PATH="/var/lib/minikube/binaries/v1.32.0:$PATH" kubeadm init --config /var/tmp/minikube/kubeadm.yaml  --ignore-preflight-errors=DirAvailable--etc-kubernetes-manifests,DirAvailable--var-lib-minikube,DirAvailable--var-lib-minikube-etcd,FileAvailable--etc-kubernetes-manifests-kube-scheduler.yaml,FileAvailable--etc-kubernetes-manifests-kube-apiserver.yaml,FileAvailable--etc-kubernetes-manifests-kube-controller-manager.yaml,FileAvailable--etc-kubernetes-manifests-etcd.yaml,Port-10250,Swap,NumCPU,Mem,SystemVerification,FileContent--proc-sys-net-bridge-bridge-nf-call-iptables": Process exited with status 1
# stdout:
# [init] Using Kubernetes version: v1.32.0
# [preflight] Running pre-flight checks
# [preflight] Pulling images required for setting up a Kubernetes cluster
# [preflight] This might take a minute or two, depending on the speed of your internet connection
# [preflight] You can also perform this action beforehand using 'kubeadm config images pull'
# [certs] Using certificateDir folder "/var/lib/minikube/certs"
# [certs] Using existing ca certificate authority
# [certs] Using existing apiserver certificate and key on disk

# stderr:
#  [WARNING Swap]: swap is supported for cgroup v2 only. The kubelet must be properly configured to use swap. Please refer to https://kubernetes.io/docs/concepts/architecture/nodes/#swap-memory, or disable swap on the node
#  [WARNING Service-Kubelet]: kubelet service is not enabled, please run 'systemctl enable kubelet.service'
#  [WARNING DirAvailable--var-lib-minikube-etcd]: /var/lib/minikube/etcd is not empty
# error execution phase certs/apiserver-kubelet-client: [certs] certificate apiserver-kubelet-client not signed by CA certificate ca: x509: certificate signed by unknown authority (possibly because of "crypto/rsa: verification error" while trying to verify candidate authority certificate "minikubeCA")
# To see the stack trace of this error execute with --v=5 or higher


# ╭───────────────────────────────────────────────────────────────────────────────────────────╮
# │                                                                                           │
# │    😿  If the above advice does not help, please let us know:                             │
# │    👉  https://github.com/kubernetes/minikube/issues/new/choose                           │
# │                                                                                           │
# │    Please run `minikube logs --file=logs.txt` and attach logs.txt to the GitHub issue.    │
# │                                                                                           │
# ╰───────────────────────────────────────────────────────────────────────────────────────────╯

# Warp terminal (AI powered) helps to solve the issue.
minikube delete

minikube start
```

```sh
minikube status
# minikube
# type: Control Plane
# host: Running
# kubelet: Running
# apiserver: Running
# kubeconfig: Configured

minikube dashboard
```

### 13. Installing Kubectl

<https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/>

```sh
curl -LO https://dl.k8s.io/release/v1.33.0/bin/linux/arm64/kubectl

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

kubectl version --client
# Client Version: version.Info{Major:"1", Minor:"27", GitVersion:"v1.27.3", GitCommit:"25b4e43193bcda6c7328a6d147b1fb73a33f1598", GitTreeState:"clean", BuildDate:"2023-06-14T09:47:38Z", GoVersion:"go1.20.5", Compiler:"gc", Platform:"darwin/arm64"}
# Kustomize Version: v5.0.1
```

### 14. Installing Helm

```sh
brew upgrade helm

helm version
# version.BuildInfo{Version:"v3.17.3", GitCommit:"e4da49785aa6e6ee2b86efd5dd9e43400318262b", GitTreeState:"clean", GoVersion:"go1.24.2"}
```

### 15. Installing and configuring VS Code

- Kubernetes
- Prettier

```json
// settings.json
{
  "[helm]": {
    "editor.formatOnSave": false
  },
}
```

</details>
