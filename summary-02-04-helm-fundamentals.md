# Secption 02 - 04 Helm Fundamentals

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

# I had installed helm using brew before
brew upgrade kubectl
kubectl version
# Client Version: v1.33.1
# Kustomize Version: v5.6.0
# Server Version: v1.32.0

rm /usr/local/bin/kubectl
```

### 14. Installing Helm

```sh
# I had installed helm using brew before
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

## Section 4: Helm Fundamentals

### 16. Section introduction

1. Explore Artifact Hub and Helm Repositories
   1. Learn how to find and evaluate Helm charts using Artifact Hub.
   2. Learn how to add, update, and manage Helm repositories.
2. Install and delete entire applications using Helm charts
   1. Introduce the most common Helm CLI commands.
   2. Visualize the results of installing applications via Helm.
3. Learn how to manage chart configuration values
   1. Understand default configuration values.
   2. Explore how to customize configuration via files.
   3. Explore how to customize configuration via the CLI.
4. Explore upgrading and rolling back Helm releases
   1. Learn how to apply configuration changes to existing deployments.
   2. Revert to previous versions of your applications using Helm’s rollback feature.
   3. Understand how Helm manages release history and revisions.

### 17. Exploring ArtifactHub

[Artifact Hub](https://artifacthub.io/)

- Application version: The underlying application's version
- Chart version: the actual chart version

- [chart - wordpress](https://artifacthub.io/packages/helm/bitnami/wordpress)
- [chart - nginx](https://artifacthub.io/packages/helm/bitnami/nginx)

### 18. Managing Helm repositories with the Helm CLI

#### Add bitnami repository

```sh
helm repo add bitnami https://charts.bitnami.com/bitnami

helm repo list
# NAME    URL
# bitnami https://charts.bitnami.com/bitnami

# repo is stored in local, so regularly updated it
helm repo update
# Hang tight while we grab the latest from your chart repositories...
# ...Successfully got an update from the "bitnami" chart repository
# Update Complete. ⎈Happy Helming!⎈

helm search repo wordpress
# NAME                    CHART VERSION APP VERSION DESCRIPTION
# bitnami/wordpress       24.2.6        6.8.1       WordPress is the world's most popular blogging ...
# bitnami/wordpress-intel 2.1.31        6.1.1       DEPRECATED WordPress for Intel is the most popu...

# they are from "bitnami"
helm search repo prometheus
# NAME                                         CHART VERSION APP VERSION DESCRIPTION
# bitnami/kube-prometheus                      11.1.11       0.82.2      Prometheus Operator provides easy monitoring de...
# bitnami/prometheus                           2.0.6         3.3.1       Prometheus is an open source monitoring and ale...
# bitnami/wavefront-prometheus-storage-adapter 2.3.3         1.0.7       DEPRECATED Wavefront Storage Adapter is a Prome...
# bitnami/grafana-mimir                        2.0.5         2.16.0      Grafana Mimir is an open source, horizontally s...
# bitnami/node-exporter                        4.5.13        1.9.1       Prometheus exporter for hardware and OS metrics...
# bitnami/thanos                               16.0.6        0.38.0      Thanos is a highly available metrics system tha...
# bitnami/victoriametrics                      0.1.11        1.117.1     VictoriaMetrics is a fast, cost-effective, and ...
# bitnami/kube-state-metrics                   5.0.8         2.15.0      kube-state-metrics is a simple service that lis...
# bitnami/mariadb                              20.5.5        11.4.6      MariaDB is an open source, community-developed ...
# bitnami/mariadb-galera                       14.2.5        11.4.6      MariaDB Galera is a multi-primary database clus...
```

#### Add prometheus repository

```sh
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
# "prometheus-community" has been added to your repositories

helm repo list
# NAME                 URL
# bitnami              https://charts.bitnami.com/bitnami
# prometheus-community https://prometheus-community.github.io/helm-charts

helm search repo prometheus
# NAME                                               CHART VERSION APP VERSION DESCRIPTION
# bitnami/kube-prometheus                            11.1.11       0.82.2      Prometheus Operator provides easy monitoring de...
# bitnami/prometheus                                 2.0.6         3.3.1       Prometheus is an open source monitoring and ale...
# bitnami/wavefront-prometheus-storage-adapter       2.3.3         1.0.7       DEPRECATED Wavefront Storage Adapter is a Prome...
# prometheus-community/kube-prometheus-stack         72.4.0        v0.82.2     kube-prometheus-stack collects Kubernetes manif...
# prometheus-community/prometheus                    27.14.0       v3.3.1      Prometheus is a monitoring system and time seri...
# prometheus-community/prometheus-adapter            4.14.1        v0.12.0     A Helm chart for k8s prometheus adapter
# prometheus-community/prometheus-blackbox-exporter  9.6.0         v0.26.0     Prometheus Blackbox Exporter
# prometheus-community/prometheus-cloudwatch-expo... 0.27.0        0.16.0      A Helm chart for prometheus cloudwatch-exporter
# prometheus-community/prometheus-conntrack-stats... 0.5.19        v0.4.27     A Helm chart for conntrack-stats-exporter
# prometheus-community/prometheus-consul-exporter    1.0.0         0.4.0       A Helm chart for the Prometheus Consul Exporter
# prometheus-community/prometheus-couchdb-exporter   1.0.0         1.0         A Helm chart to export the metrics from couchdb...
# prometheus-community/prometheus-druid-exporter     1.1.1         v0.11.0     Druid exporter to monitor druid metrics with Pr...
# prometheus-community/prometheus-elasticsearch-e... 6.7.2         v1.9.0      Elasticsearch stats exporter for Prometheus
# prometheus-community/prometheus-fastly-exporter    0.6.0         v9.1.1      A Helm chart for the Prometheus Fastly Exporter
# prometheus-community/prometheus-ipmi-exporter      0.6.0         v1.10.0     This is an IPMI exporter for Prometheus.
# prometheus-community/prometheus-json-exporter      0.16.1        v0.7.0      Install prometheus-json-exporter
# prometheus-community/prometheus-kafka-exporter     2.12.1        v1.9.0      A Helm chart to export the metrics from Kafka i...
# prometheus-community/prometheus-memcached-exporter 0.4.0         v0.15.0     Prometheus exporter for Memcached metrics
# prometheus-community/prometheus-modbus-exporter    0.1.3         0.4.1       A Helm chart for prometheus-modbus-exporter
# prometheus-community/prometheus-mongodb-exporter   3.12.0        0.44.0      A Prometheus exporter for MongoDB metrics
# prometheus-community/prometheus-mysql-exporter     2.10.0        v0.17.2     A Helm chart for prometheus mysql exporter with...
# prometheus-community/prometheus-nats-exporter      2.18.0        0.16.0      A Helm chart for prometheus-nats-exporter
# prometheus-community/prometheus-nginx-exporter     1.4.1         1.4.2       A Helm chart for NGINX Prometheus Exporter
# prometheus-community/prometheus-node-exporter      4.46.0        1.9.1       A Helm chart for prometheus node-exporter
# prometheus-community/prometheus-opencost-exporter  0.1.2         1.108.0     Prometheus OpenCost Exporter
# prometheus-community/prometheus-operator           9.3.2         0.38.1      DEPRECATED - This chart will be renamed. See ht...
# prometheus-community/prometheus-operator-admiss... 0.24.2        0.82.0      Prometheus Operator Admission Webhook
# prometheus-community/prometheus-operator-crds      20.0.0        v0.82.0     A Helm chart that collects custom resource defi...
# prometheus-community/prometheus-pgbouncer-exporter 0.7.1         v0.10.2     A Helm chart for prometheus pgbouncer-exporter
# prometheus-community/prometheus-pingdom-exporter   3.4.0         v0.5.0      A Helm chart for Prometheus Pingdom Exporter
# prometheus-community/prometheus-pingmesh-exporter  0.4.2         v1.2.2      Prometheus Pingmesh Exporter
# prometheus-community/prometheus-postgres-exporter  6.10.2        v0.17.1     A Helm chart for prometheus postgres-exporter
# prometheus-community/prometheus-pushgateway        3.2.0         v1.11.1     A Helm chart for prometheus pushgateway
# prometheus-community/prometheus-rabbitmq-exporter  2.1.1         1.0.0       Rabbitmq metrics exporter for prometheus
# prometheus-community/prometheus-redis-exporter     6.10.2        v1.69.0     Prometheus exporter for Redis metrics
# prometheus-community/prometheus-smartctl-exporter  0.15.1        v0.14.0     A Helm chart for Kubernetes
# prometheus-community/prometheus-snmp-exporter      9.3.0         v0.28.0     Prometheus SNMP Exporter
# prometheus-community/prometheus-sql-exporter       0.2.2         v0.5.9      Prometheus SQL Exporter
# prometheus-community/prometheus-stackdriver-exp... 4.8.2         v0.18.0     Stackdriver exporter for Prometheus
# prometheus-community/prometheus-statsd-exporter    0.15.0        v0.28.0     A Helm chart for prometheus stats-exporter
# prometheus-community/prometheus-systemd-exporter   0.5.0         0.7.0       A Helm chart for prometheus systemd-exporter
# prometheus-community/prometheus-to-sd              0.4.2         0.5.2       Scrape metrics stored in prometheus format and ...
# prometheus-community/prometheus-windows-exporter   0.10.0        0.30.6      A Helm chart for prometheus windows-exporter
# prometheus-community/prometheus-yet-another-clo... 0.40.1        v0.62.1     Yace - Yet Another CloudWatch Exporter
# prometheus-community/alertmanager                  1.18.0        v0.28.1     The Alertmanager handles alerts sent by client ...
# prometheus-community/alertmanager-snmp-notifier    1.0.0         v2.0.0      The SNMP Notifier handles alerts coming from Pr...
# prometheus-community/jiralert                      1.7.2         v1.3.0      A Helm chart for Kubernetes to install jiralert
# prometheus-community/kube-state-metrics            5.33.1        2.15.0      Install kube-state-metrics to generate and expo...
# prometheus-community/prom-label-proxy              0.12.0        v0.11.0     A proxy that enforces a given label in a given ...
# prometheus-community/yet-another-cloudwatch-exp... 0.39.1        v0.62.1     Yace - Yet Another CloudWatch Exporter
# bitnami/grafana-mimir                              2.0.5         2.16.0      Grafana Mimir is an open source, horizontally s...
# bitnami/node-exporter                              4.5.13        1.9.1       Prometheus exporter for hardware and OS metrics...
# bitnami/thanos                                     16.0.6        0.38.0      Thanos is a highly available metrics system tha...
# bitnami/victoriametrics                            0.1.11        1.117.1     VictoriaMetrics is a fast, cost-effective, and ...
# bitnami/kube-state-metrics                         5.0.8         2.15.0      kube-state-metrics is a simple service that lis...
# bitnami/mariadb                                    20.5.5        11.4.6      MariaDB is an open source, community-developed ...
# bitnami/mariadb-galera                             14.2.5        11.4.6      MariaDB Galera is a multi-primary database clus...
```

```sh
helm search repo prometheus --max-col-width 20
```

```sh
helm show chart bitnami/wordpress
# annotations:
#   category: CMS
#   images: |
#     - name: apache-exporter
#       image: docker.io/bitnami/apache-exporter:1.0.10-debian-12-r5
#     - name: os-shell
#       image: docker.io/bitnami/os-shell:12-debian-12-r43
#     - name: wordpress
#       image: docker.io/bitnami/wordpress:6.8.1-debian-12-r1
#   licenses: Apache-2.0
#   tanzuCategory: application
# apiVersion: v2
# appVersion: 6.8.1
# dependencies:
# - condition: memcached.enabled
#   name: memcached
#   repository: oci://registry-1.docker.io/bitnamicharts
#   version: 7.x.x
# - condition: mariadb.enabled
#   name: mariadb
#   repository: oci://registry-1.docker.io/bitnamicharts
#   version: 20.x.x
# - name: common
#   repository: oci://registry-1.docker.io/bitnamicharts
#   tags:
#   - bitnami-common
#   version: 2.x.x
# description: WordPress is the world's most popular blogging and content management
#   platform. Powerful yet simple, everyone from students to global corporations use
#   it to build beautiful, functional websites.
# home: https://bitnami.com
# icon: https://dyltqmyl993wv.cloudfront.net/assets/stacks/wordpress/img/wordpress-stack-220x234.png
# keywords:
# - application
# - blog
# - cms
# - http
# - php
# - web
# - wordpress
# maintainers:
# - name: Broadcom, Inc. All Rights Reserved.
#   url: https://github.com/bitnami/charts
# name: wordpress
# sources:
# - https://github.com/bitnami/charts/tree/main/bitnami/wordpress
# version: 24.2.6
```

```sh
helm search repo cms
# NAME                    CHART VERSION APP VERSION DESCRIPTION
# bitnami/joomla          20.0.4        5.1.2       DEPRECATED Joomla! is an award winning open sou...
# bitnami/drupal          21.2.8        11.1.7      Drupal is one of the most versatile open source...
# bitnami/wordpress       24.2.6        6.8.1       WordPress is the world's most popular blogging ...
# bitnami/wordpress-intel 2.1.31        6.1.1       DEPRECATED WordPress for Intel is the most popu...

helm search repo wordpress --versions
```

```sh
helm show chart bitnami/wordpress

helm show readme bitnami/wordpress
# as the same content as https://artifacthub.io/packages/helm/bitnami/wordpress

helm show values bitnami/wordpress

helm repo --help

helm repo remove bitnami
```

### 19. Installing the Wordpress Helm chart

```sh
kubectl version
# Client Version: v1.33.1
# Kustomize Version: v5.6.0
# Server Version: v1.32.0

kubectl config current-context
# minikube

k get namespaces
# NAME                   STATUS   AGE
# default                Active   9h
# kube-node-lease        Active   9h
# kube-public            Active   9h
# kube-system            Active   9h
# kubernetes-dashboard   Active   9h

k get pods
# No resources found in default namespace.
```

```sh
helm search repo wordpress
# NAME                    CHART VERSION APP VERSION DESCRIPTION
# bitnami/wordpress       24.2.6        6.8.1       WordPress is the world's most popular blogging ...
# bitnami/wordpress-intel 2.1.31        6.1.1       DEPRECATED WordPress for Intel is the most popu...

helm install --help
# helm install [NAME] [CHART] [flags]

# the latest version is 24.2.6 but we install lower version to try to upgrade later
helm install local-wp bitnami/wordpress --version=24.2.3
# NAME: local-wp
# LAST DEPLOYED: Fri May 16 18:26:49 2025
# NAMESPACE: default
# STATUS: deployed
# REVISION: 1
# TEST SUITE: None
# NOTES:
# CHART NAME: wordpress
# CHART VERSION: 24.2.3
# APP VERSION: 6.8.0

# Did you know there are enterprise versions of the Bitnami catalog? For enhanced secure software supply chain features, unlimited pulls from Docker, LTS support, or application customization, see Bitnami Premium or Tanzu Application Catalog. See https://www.arrow.com/globalecs/na/vendors/bitnami for more information.

# ** Please be patient while the chart is being deployed **

# Your WordPress site can be accessed through the following DNS name from within your cluster:

#     local-wp-wordpress.default.svc.cluster.local (port 80)

# To access your WordPress site from outside the cluster follow the steps below:

# 1. Get the WordPress URL by running these commands:

#   NOTE: It may take a few minutes for the LoadBalancer IP to be available.
#         Watch the status with: 'kubectl get svc --namespace default -w local-wp-wordpress'

#    export SERVICE_IP=$(kubectl get svc --namespace default local-wp-wordpress --template "{{ range (index .status.loadBalancer.ingress 0) }}{{ . }}{{ end }}")
#    echo "WordPress URL: http://$SERVICE_IP/"
#    echo "WordPress Admin URL: http://$SERVICE_IP/admin"

# 2. Open a browser and access WordPress using the obtained URL.

# 3. Login with the following credentials below to see your blog:

#   echo Username: user
#   echo Password: $(kubectl get secret --namespace default local-wp-wordpress -o jsonpath="{.data.wordpress-password}" | base64 -d)

# WARNING: There are "resources" sections in the chart not set. Using "resourcesPreset" is not recommended for production. For production installations, please set the following values according to your workload needs:
#   - resources
# +info https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
```

```sh
k get pods
# NAME                                  READY   STATUS     RESTARTS   AGE
# local-wp-mariadb-0                    0/1     Init:0/1   0          39s
# local-wp-wordpress-77858b7665-j2jfb   0/1     Running    0          39s

k get svc
# NAME                        TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)                      AGE
# kubernetes                  ClusterIP      10.96.0.1        <none>        443/TCP                      9h
# local-wp-mariadb            ClusterIP      10.105.85.243    <none>        3306/TCP                     87s
# local-wp-mariadb-headless   ClusterIP      None             <none>        3306/TCP                     87s
# local-wp-wordpress          LoadBalancer   10.100.170.163   <pending>     80:30567/TCP,443:30132/TCP   87s

k get secret
# NAME                             TYPE                 DATA   AGE
# local-wp-mariadb                 Opaque               2      2m13s
# local-wp-wordpress               Opaque               1      2m13s
# sh.helm.release.v1.local-wp.v1   helm.sh/release.v1   1      2m13s

k describe secret local-wp-wordpress
# Name:         local-wp-wordpress
# Namespace:    default
# Labels:       app.kubernetes.io/instance=local-wp
#               app.kubernetes.io/managed-by=Helm
#               app.kubernetes.io/name=wordpress
#               app.kubernetes.io/version=6.8.0
#               helm.sh/chart=wordpress-24.2.3
# Annotations:  meta.helm.sh/release-name: local-wp
#               meta.helm.sh/release-namespace: default

# Type:  Opaque

# Data
# ====
# wordpress-password:  10 bytes
```

`sh.helm.release.v1.local-wp.v1` secret is used by helm and it's important

#### ‼️ **Expose deployment to access with minikube**

```sh
k describe pod local-wp-wordpress-77858b7665-j2jfb
```

```sh
kubectl get deploy
# NAME                 READY   UP-TO-DATE   AVAILABLE   AGE
# local-wp-wordpress   0/1     1            0           5m4s

# it already exists by load balancer service
kubectl expose deploy local-wp-wordpress --type=NodePort
# Error from server (AlreadyExists): services "local-wp-wordpress" already exists

# expose deployment
kubectl expose deploy local-wp-wordpress --type=NodePort --name=local-wp
# service/local-wp exposed

k get svc
# NAME                        TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)                         AGE
# kubernetes                  ClusterIP      10.96.0.1        <none>        443/TCP                         9h
# local-wp                    NodePort       10.110.21.172    <none>        8080:31482/TCP,8443:31514/TCP   52s
# ...

minikube service local-wp
# |-----------|----------|-------------|---------------------------|
# | NAMESPACE |   NAME   | TARGET PORT |            URL            |
# |-----------|----------|-------------|---------------------------|
# | default   | local-wp | port-1/8080 | http://192.168.49.2:31482 |
# |           |          | port-2/8443 | http://192.168.49.2:31514 |
# |-----------|----------|-------------|---------------------------|
# 🏃  Starting tunnel for service local-wp.
# |-----------|----------|-------------|------------------------|
# | NAMESPACE |   NAME   | TARGET PORT |          URL           |
# |-----------|----------|-------------|------------------------|
# | default   | local-wp |             | http://127.0.0.1:58305 |
# |           |          |             | http://127.0.0.1:58306 |
# |-----------|----------|-------------|------------------------|
# [default local-wp  http://127.0.0.1:58305
# http://127.0.0.1:58306]
# ❗  Because you are using a Docker driver on darwin, the terminal needs to be open to run it.
# ^C✋  Stopping tunnel for service local-wp.
```

❌ However, my browser cannot access "<http://127.0.0.1:58305>" or "<http://127.0.0.1:58306>"
✅ after a few days, I've tried exactly the same process, and it works. Hmm..

### 20. Exploring the default Wordpress chart configuration

- navigate <http://127.0.0.1:58305/wp-admin>
- navigate <https://artifacthub.io/packages/helm/bitnami/wordpress?modal=values&path=wordpressUsername>
- we can find the `username` but `password` is not present.

```sh
k describe secret local-wp-wordpress
# Name:         local-wp-wordpress
# Namespace:    default
# Labels:       app.kubernetes.io/instance=local-wp
#               app.kubernetes.io/managed-by=Helm
#               app.kubernetes.io/name=wordpress
#               app.kubernetes.io/version=6.8.0
#               helm.sh/chart=wordpress-24.2.3
# Annotations:  meta.helm.sh/release-name: local-wp
#               meta.helm.sh/release-namespace: default

# Type:  Opaque

# Data
# ====
# wordpress-password:  10 bytes

# it starts with `.data` and add the key name
# it is encoded with base64
k get secret local-wp-wordpress -o jsonpath='{.data.wordpress-password}' | base64 -d
# PclkflpFhT%
# exclude `%` sign
```

```sh
helm show values bitnami/wordpress

# "local-wp" is the helm name when I installed it locally
# helm install local-wp bitnami/wordpress --version=24.2.3
helm get values local-wp
# USER-SUPPLIED VALUES:
# null

helm get values local-wp --all
# ...

helm get notes local-wp

helm get metadata local-wp

helm get --help
# Usage:
#   helm get [command]

# Available Commands:
#   all         download all information for a named release
#   hooks       download all hooks for a named release
#   manifest    download the manifest for a named release
#   metadata    This command fetches metadata for a given release
#   notes       download the notes for a named release
#   values      download the values file for a named release
```

- navigate <http://127.0.0.1:58305/wp-admin>
- ✅ Login with the username, "user" and the password we can find above

### 21. Uninstalling Helm charts

Most resource will get deleted with `helm uninstall` command

but some resources such as volumes or services manually created will be remain, so we need to manually delete them

```sh
helm list
# NAME     NAMESPACE REVISION UPDATED                               STATUS   CHART            APP VERSION
# local-wp default   1        2025-05-16 18:26:49.292553 +1000 AEST deployed wordpress-24.2.3 6.8.0

helm uninstall local-wp
# release "local-wp" uninstalled

k get pods
# No resources found in default namespace.

k get svc
# NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                         AGE
# kubernetes   ClusterIP   10.96.0.1       <none>        443/TCP                         21h
# local-wp     NodePort    10.110.21.172   <none>        8080:31482/TCP,8443:31514/TCP   12h

# "local-wp" services is the one we manually created
k delete svc local-wp
# service "local-wp" deleted

k get pv,pvc
# NAME                                                        CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS     CLAIM                             STORAGECLASS   VOLUMEATTRIBUTESCLASS   REASON   AGE
# persistentvolume/pvc-d4a66f5b-9344-4e40-875c-d823e52cec54   8Gi        RWO            Delete           Bound      default/data-local-wp-mariadb-0   standard       <unset>                          12h
# persistentvolume/pvc-e4579f9f-762f-46e9-960a-2d84d9bc47da   10Gi       RWO            Delete           Released   default/local-wp-wordpress        standard       <unset>                          12h

# NAME                                            STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   VOLUMEATTRIBUTESCLASS   AGE
# persistentvolumeclaim/data-local-wp-mariadb-0   Bound    pvc-d4a66f5b-9344-4e40-875c-d823e52cec54   8Gi        RWO            standard       <unset>                 12h

k get pvc
# NAME                      STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   VOLUMEATTRIBUTESCLASS   AGE
# data-local-wp-mariadb-0   Bound    pvc-d4a66f5b-9344-4e40-875c-d823e52cec54   8Gi        RWO            standard       <unset>                 12h

k describe pvc data-local-wp-mariadb-0
# Name:          data-local-wp-mariadb-0
# Namespace:     default
# StorageClass:  standard
# Status:        Bound
# Volume:        pvc-d4a66f5b-9344-4e40-875c-d823e52cec54
# Labels:        app.kubernetes.io/component=primary
#                app.kubernetes.io/instance=local-wp
#                app.kubernetes.io/name=mariadb
#                app.kubernetes.io/part-of=mariadb
# Annotations:   pv.kubernetes.io/bind-completed: yes
#                pv.kubernetes.io/bound-by-controller: yes
#                volume.beta.kubernetes.io/storage-provisioner: k8s.io/minikube-hostpath
#                volume.kubernetes.io/storage-provisioner: k8s.io/minikube-hostpath
# Finalizers:    [kubernetes.io/pvc-protection]
# Capacity:      8Gi
# Access Modes:  RWO
# VolumeMode:    Filesystem
# Used By:       <none>
# Events:        <none>

# StorageClass: standard
k describe storageclass standard
# Name:            standard
# IsDefaultClass:  Yes
# Annotations:     kubectl.kubernetes.io/last-applied-configuration={"apiVersion":"storage.k8s.io/v1","kind":"StorageClass","metadata":{"annotations":{"storageclass.kubernetes.io/is-default-class":"true"},"labels":{"addonmanager.kubernetes.io/mode":"EnsureExists"},"name":"standard"},"provisioner":"k8s.io/minikube-hostpath"}
# ,storageclass.kubernetes.io/is-default-class=true
# Provisioner:           k8s.io/minikube-hostpath
# Parameters:            <none>
# AllowVolumeExpansion:  <unset>
# MountOptions:          <none>
# ReclaimPolicy:         Delete
# VolumeBindingMode:     Immediate
# Events:                <none>
```

- StorageClass
  - ReclaimPolicy: Delete
    - it means when the volume gets deleted, the data will be deleted
    - if it is **Retain**, the underline persisted volume will be remained after deleting

```sh
k delete pvc data-local-wp-mariadb-0
k get pvc
# No resources found in default namespace.
```

### 22. Cleaning up Kubernetes resources

#### Insteall and uninstall helm chart

```sh
helm install local-wp bitnami/wordpress --version=24.2.3
k get pods --watch
k get secrets
k describe secret local-wp-mariadb
# Data
# ====
# mariadb-password:       10 bytes
# mariadb-root-password:  10 bytes
k get secret local-wp-mariadb -o jsonpath='{.data.mariadb-password}' | base64 -d
# m9hu46Idn1%
k get secret local-wp-mariadb -o jsonpath='{.data.mariadb-root-password}' | base64 -d
# QH52fQ4XIH%
helm uninstall local-wp
```

#### Re install the helm chart without deleting previous volume

```sh
helm install local-wp bitnami/wordpress --version=24.2.3
k get secret local-wp-mariadb -o jsonpath='{.data.mariadb-password}' | base64 -d
# SOTL0pUxku%
k get secret local-wp-mariadb -o jsonpath='{.data.mariadb-root-password}' | base64 -d
# 4xAHsRVEMN%

k logs local-wp-wordpress-77858b7665-tf7n6
# wordpress 19:06:37.66 INFO  ==> Trying to connect to the database server
```

The password remained in the database (=volume) doesn't match with the new password in the app configuration

```sh
helm uninstall local-wp

k get pvc --watch
# NAME                      STATUS        VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   VOLUMEATTRIBUTESCLASS   AGE
# data-local-wp-mariadb-0   Bound         pvc-8f23926e-10c9-4218-9738-96720aad4b03   8Gi        RWO            standard       <unset>                 10m
# local-wp-wordpress        Terminating   pvc-1ab7f61d-5012-4049-bc9f-53a32555ceff   10Gi       RWO            standard       <unset>                 4m39s

k delete pvc data-local-wp-mariadb-0

k get secret,pod,deploy,svc
# NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
# service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   44h
```

### 23. Setting custom values via the Helm CLI

Navigate to see default values

<https://artifacthub.io/packages/helm/bitnami/wordpress/24.2.5?modal=values&path=mariadb.auth.rootPassword>

```sh
helm install local-wp bitnami/wordpress --version=24.2.3 \
  --set "mariadb.auth.rootPassword=myawesomepassword" \
  --set "mariadb.auth.password=myuserpassword"
```

- ❌ the pod coudln't connect to database server during the first few tries.. even after deleting all pvc and pv
- ✅ after 4-5 tries, it suddenly works. hmm

```sh
k get secret local-wp-mariadb -o jsonpath='{.data.mariadb-password}' | base64 -d
# myuserpassword%
k get secret local-wp-mariadb -o jsonpath='{.data.mariadb-root-password}' | base64 -d
# myawesomepassword%

helm get values local-wp
# USER-SUPPLIED VALUES:
# mariadb:
#   auth:
#     password: myuserpassword
#     rootPassword: myawesomepassword
```

### 24. Setting custom values via files

<https://artifacthub.io/packages/helm/bitnami/wordpress/24.2.5?modal=values&path=existingSecret>

```sh
# 04-helm-fundamentals/24-custom-values.yaml

k create secret generic custom-wp-credentials --from-literal wordpress-password=noahpassword

helm install local-wp bitnami/wordpress --version=24.2.3\
  -f 04-helm-fundamentals/24-custom-values.yaml

helm get values local-wp
# USER-SUPPLIED VALUES:
# existingSecret: custom-wp-credentials
# replicaCount: 3
# wordpressUsername: noah

k get pods
# NAME                                  READY   STATUS    RESTARTS      AGE
# local-wp-mariadb-0                    1/1     Running   0             58s
# local-wp-wordpress-777bbfbffc-bcb46   0/1     Running   1 (15s ago)   58s
# local-wp-wordpress-777bbfbffc-q9b4p   0/1     Running   1 (15s ago)   58s
# local-wp-wordpress-777bbfbffc-w7ltx   1/1     Running   0             58s

kubectl expose deploy local-wp-wordpress --type=NodePort --name=local-wp
# service/local-wp exposed

k get svc
# NAME                        TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)                         AGE
# local-wp                    NodePort       10.98.7.13       <none>        8080:32126/TCP,8443:30433/TCP   2s

minikube service local-wp
# |-----------|----------|-------------|---------------------------|
# | NAMESPACE |   NAME   | TARGET PORT |            URL            |
# |-----------|----------|-------------|---------------------------|
# | default   | local-wp | port-1/8080 | http://192.168.49.2:32126 |
# |           |          | port-2/8443 | http://192.168.49.2:30433 |
# |-----------|----------|-------------|---------------------------|
# 🏃  Starting tunnel for service local-wp.
# |-----------|----------|-------------|------------------------|
# | NAMESPACE |   NAME   | TARGET PORT |          URL           |
# |-----------|----------|-------------|------------------------|
# | default   | local-wp |             | http://127.0.0.1:59205 |
# |           |          |             | http://127.0.0.1:59206 |
# |-----------|----------|-------------|------------------------|
# [default local-wp  http://127.0.0.1:59205
# http://127.0.0.1:59206]
# ❗  Because you are using a Docker driver on darwin, the terminal needs to be open to run it.
```

- navigate <http://127.0.0.1:59205/wp-admin>
- login with my custom credential

### 25. Upgrading Helm releases: Setting new values

- update `04-helm-fundamentals/24-custom-values.yaml` file

```sh
helm upgrade --reuse-values --values 04-helm-fundamentals/24-custom-values.yaml local-wp bitnami/wordpress --version 24.2.3

helm get values local-wp
# USER-SUPPLIED VALUES:
# autoscaling:
#   enabled: true
#   maxReplicas: 10
#   minReplicas: 2
# existingSecret: custom-wp-credentials
# replicaCount: 3
# wordpressUsername: noah

k get pods
# NAME                                  READY   STATUS    RESTARTS   AGE
# local-wp-mariadb-0                    1/1     Running   0          20m
# local-wp-wordpress-777bbfbffc-f7pxn   1/1     Running   0          37s
# local-wp-wordpress-777bbfbffc-w7ltx   1/1     Running   0          20m
```

- `replicaCount` is not defined in `04-helm-fundamentals/24-custom-values.yaml`
  - because the value was there in the previous status, and the value is reused now

```sh
helm history local-wp
# REVISION UPDATED                  STATUS     CHART            APP VERSION DESCRIPTION
# 1        Fri May 23 16:29:51 2025 superseded wordpress-24.2.3 6.8.0       Install complete
# 2        Fri May 23 16:49:40 2025 superseded wordpress-24.2.3 6.8.0       Upgrade complete
# 3        Fri May 23 16:52:34 2025 deployed   wordpress-24.2.3 6.8.0       Upgrade complete

helm get values local-wp --revision 1
# USER-SUPPLIED VALUES:
# existingSecret: custom-wp-credentials
# replicaCount: 3
# wordpressUsername: noah

k get secret
# NAME                             TYPE                 DATA   AGE
# custom-wp-credentials            Opaque               1      27m
# local-wp-mariadb                 Opaque               2      25m
# sh.helm.release.v1.local-wp.v1   helm.sh/release.v1   1      25m
# sh.helm.release.v1.local-wp.v2   helm.sh/release.v1   1      5m59s
# sh.helm.release.v1.local-wp.v3   helm.sh/release.v1   1      3m4s
```

- secret v1, v2 and v3 match with the local-wp revision

### 26. Upgrading Helm releases: Setting new chart versions

```sh
helm repo update
# Hang tight while we grab the latest from your chart repositories...
# ...Successfully got an update from the "prometheus-community" chart repository
# ...Successfully got an update from the "bitnami" chart repository
# Update Complete. ⎈Happy Helming!⎈

helm search repo wordpress
# NAME                    CHART VERSION APP VERSION DESCRIPTION
# bitnami/wordpress       24.2.6        6.8.1       WordPress is the world's most popular blogging ...

helm upgrade --reuse-values local-wp bitnami/wordpress --version 24.2.6

helm get values local-wp
# USER-SUPPLIED VALUES:
# autoscaling:
#   enabled: true
#   maxReplicas: 10
#   minReplicas: 2
# existingSecret: custom-wp-credentials
# replicaCount: 3
# wordpressUsername: noah

k get pods # new pods are running
# NAME                                  READY   STATUS    RESTARTS   AGE
# local-wp-mariadb-0                    1/1     Running   0          3m48s
# local-wp-wordpress-6c8997fc5f-ttz7x   1/1     Running   0          3m5s
# local-wp-wordpress-6c8997fc5f-z9spr   1/1     Running   0          3m49s

helm history local-wp
# REVISION UPDATED                  STATUS     CHART            APP VERSION DESCRIPTION
# 1        Fri May 23 16:29:51 2025 superseded wordpress-24.2.3 6.8.0       Install complete
# 2        Fri May 23 16:49:40 2025 superseded wordpress-24.2.3 6.8.0       Upgrade complete
# 3        Fri May 23 16:52:34 2025 superseded wordpress-24.2.3 6.8.0       Upgrade complete
# 4        Fri May 23 19:02:45 2025 deployed   wordpress-24.2.6 6.8.1       Upgrade complete
```

### 27. Rollbacks in Helm

```sh
# testing failure with providing the wrong tag.
helm upgrade --reuse-values --values 04-helm-fundamentals/24-custom-values.yaml --set "image.tag=nonexistent" local-wp bitnami/wordpress --version 24.2.6

k get pods
# NAME                                  READY   STATUS                  RESTARTS   AGE
# local-wp-mariadb-0                    1/1     Running                 0          8m7s
# local-wp-wordpress-5fd4d7bf87-2htnl   0/1     Init:ImagePullBackOff   0          20s
# local-wp-wordpress-6c8997fc5f-ttz7x   1/1     Running                 0          7m24s
# local-wp-wordpress-6c8997fc5f-z9spr   1/1     Running                 0          8m8s

k describe pod local-wp-wordpress-5fd4d7bf87-2htnl
# Events:
#   Type     Reason     Age                From               Message
#   ----     ------     ----               ----               -------
#   Normal   Scheduled  48s                default-scheduler  Successfully assigned default/local-wp-wordpress-5fd4d7bf87-2htnl to minikube
#   Normal   Pulling    32s (x2 over 48s)  kubelet            Pulling image "docker.io/bitnami/wordpress:nonexistent"
#   Warning  Failed     28s (x2 over 44s)  kubelet            Failed to pull image "docker.io/bitnami/wordpress:nonexistent": Error response from daemon: manifest for bitnami/wordpress:nonexistent not found: manifest unknown: manifest unknown
#   Warning  Failed     28s (x2 over 44s)  kubelet            Error: ErrImagePull
#   Normal   BackOff    14s (x2 over 43s)  kubelet            Back-off pulling image "docker.io/bitnami/wordpress:nonexistent"
#   Warning  Failed     14s (x2 over 43s)  kubelet            Error: ImagePullBackOff
```

- new helm chart is install but it has been failed.
- so we need to rollback

```sh
helm history local-wp
# REVISION UPDATED                  STATUS     CHART            APP VERSION DESCRIPTION
# 1        Fri May 23 16:29:51 2025 superseded wordpress-24.2.3 6.8.0       Install complete
# 2        Fri May 23 16:49:40 2025 superseded wordpress-24.2.3 6.8.0       Upgrade complete
# 3        Fri May 23 16:52:34 2025 superseded wordpress-24.2.3 6.8.0       Upgrade complete
# 4        Fri May 23 19:02:45 2025 superseded wordpress-24.2.6 6.8.1       Upgrade complete
# 5        Fri May 23 19:10:33 2025 deployed   wordpress-24.2.6 6.8.1       Upgrade complete

helm rollback local-wp 4  # revision number
# Rollback was a success! Happy Helming!

helm history local-wp
# REVISION UPDATED                  STATUS     CHART            APP VERSION DESCRIPTION
# 1        Fri May 23 16:29:51 2025 superseded wordpress-24.2.3 6.8.0       Install complete
# 2        Fri May 23 16:49:40 2025 superseded wordpress-24.2.3 6.8.0       Upgrade complete
# 3        Fri May 23 16:52:34 2025 superseded wordpress-24.2.3 6.8.0       Upgrade complete
# 4        Fri May 23 19:02:45 2025 superseded wordpress-24.2.6 6.8.1       Upgrade complete
# 5        Fri May 23 19:10:33 2025 superseded wordpress-24.2.6 6.8.1       Upgrade complete
# 6        Fri May 23 19:14:12 2025 deployed   wordpress-24.2.6 6.8.1       Rollback to 4

k get pods
# NAME                                  READY   STATUS    RESTARTS   AGE
# local-wp-mariadb-0                    1/1     Running   0          11m
# local-wp-wordpress-6c8997fc5f-ttz7x   1/1     Running   0          11m
# local-wp-wordpress-6c8997fc5f-z9spr   1/1     Running   0          11m
```

when the upgrade is failed, the old pods don't get deleted and they remains

```sh
k get rs  # ReplicaSet
# NAME                            DESIRED   CURRENT   READY   AGE
# local-wp-wordpress-5fd4d7bf87   0         0         0       5m13s
# local-wp-wordpress-6c8997fc5f   2         2         2       13m
# local-wp-wordpress-777bbfbffc   0         0         0       165m

k get deployment
# NAME                 READY   UP-TO-DATE   AVAILABLE   AGE
# local-wp-wordpress   2/2     2            2           166m
```

When rollback helm chart, some resources don't get deleted automatically

So we will have to manually delete them

```sh
k delete rs local-wp-wordpress-5fd4d7bf87
k delete rs local-wp-wordpress-777bbfbffc
```

```sh
k get secrets
# NAME                             TYPE                 DATA   AGE
# custom-wp-credentials            Opaque               1      170m
# local-wp-mariadb                 Opaque               2      169m
# sh.helm.release.v1.local-wp.v1   helm.sh/release.v1   1      169m
# sh.helm.release.v1.local-wp.v2   helm.sh/release.v1   1      149m
# sh.helm.release.v1.local-wp.v3   helm.sh/release.v1   1      146m
# sh.helm.release.v1.local-wp.v4   helm.sh/release.v1   1      16m
# sh.helm.release.v1.local-wp.v5   helm.sh/release.v1   1      8m48s
# sh.helm.release.v1.local-wp.v6   helm.sh/release.v1   1      5m10s
```

v6 is for the revision 4 as we rollback to it.

### 28. Upgrading Helm releases: Useful CLI flags

Clean up resources

```sh
k get svc
# NAME                        TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)                         AGE
# kubernetes                  ClusterIP      10.96.0.1        <none>        443/TCP                         7d10h
# local-wp                    NodePort       10.98.7.13       <none>        8080:32126/TCP,8443:30433/TCP   169m
# local-wp-mariadb            ClusterIP      10.110.181.144   <none>        3306/TCP                        171m
# local-wp-mariadb-headless   ClusterIP      None             <none>        3306/TCP                        171m
# local-wp-wordpress          LoadBalancer   10.100.211.190   <pending>     80:30732/TCP,443:31284/TCP      171m

k delete svc local-wp
```

Now, we want to change the type of default service, `local-wp-wordpress` to `NodePort` instead of LoadBalancer.

<https://artifacthub.io/packages/helm/bitnami/wordpress/24.2.6?modal=values&path=service>

```sh
# 04-helm-fundamentals/28-upgrade-helm-release.yaml

helm upgrade --reuse-values --values 04-helm-fundamentals/28-upgrade-helm-release.yaml local-wp bitnami/wordpress --version 24.2.6

k get pods   # didn't change any
# NAME                                  READY   STATUS    RESTARTS   AGE
# local-wp-mariadb-0                    1/1     Running   0          24m
# local-wp-wordpress-6c8997fc5f-ttz7x   1/1     Running   0          23m
# local-wp-wordpress-6c8997fc5f-z9spr   1/1     Running   0          24m

k get svc
# NAME                        TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                      AGE
# kubernetes                  ClusterIP   10.96.0.1        <none>        443/TCP                      7d10h
# local-wp-mariadb            ClusterIP   10.110.181.144   <none>        3306/TCP                     177m
# local-wp-mariadb-headless   ClusterIP   None             <none>        3306/TCP                     177m
# local-wp-wordpress          NodePort    10.100.211.190   <none>        80:30732/TCP,443:31284/TCP   177m
```

the type of `local-wp-wordpress` has changed

```sh
# testing failure with providing the wrong tag.
helm upgrade \
  local-wp bitnami/wordpress \
  --reuse-values \
  --values 04-helm-fundamentals/28-upgrade-helm-release.yaml \
  --set "image.tag=nonexistent" \
  --version 24.2.6 \
  --atomic \
  --cleanup-on-fail \
  --debug \
  --timeout 2m
```

- `--atomic`: if the upgrade fails for any reason, helm will automatically roll back the release to its previous state.
- `--cleanup-on-fail`: if the upgrade fails, it will remove any resources that were part of the failed upgrade attempt but were not part of the previous successful release.
- `--debug`: to see detailed information.
- `--timeout`: the default timeout is 5m, so it makes it shorter.

```sh
helm history local-wp
# REVISION UPDATED                  STATUS          CHART            APP VERSION DESCRIPTION
# 1        Fri May 23 16:29:51 2025 superseded      wordpress-24.2.3 6.8.0       Install complete
# 2        Fri May 23 16:49:40 2025 superseded      wordpress-24.2.3 6.8.0       Upgrade complete
# 3        Fri May 23 16:52:34 2025 superseded      wordpress-24.2.3 6.8.0       Upgrade complete
# 4        Fri May 23 19:02:45 2025 superseded      wordpress-24.2.6 6.8.1       Upgrade complete
# 5        Fri May 23 19:10:33 2025 superseded      wordpress-24.2.6 6.8.1       Upgrade complete
# 6        Fri May 23 19:14:12 2025 superseded      wordpress-24.2.6 6.8.1       Rollback to 4
# 7        Fri May 23 19:26:57 2025 deployed        wordpress-24.2.6 6.8.1       Upgrade complete
# 8        Fri May 23 19:35:18 2025 pending-upgrade wordpress-24.2.6 6.8.1       Preparing upgrade

helm history local-wp
# REVISION UPDATED                  STATUS     CHART            APP VERSION DESCRIPTION
# 1        Fri May 23 16:29:51 2025 superseded wordpress-24.2.3 6.8.0       Install complete
# 2        Fri May 23 16:49:40 2025 superseded wordpress-24.2.3 6.8.0       Upgrade complete
# 3        Fri May 23 16:52:34 2025 superseded wordpress-24.2.3 6.8.0       Upgrade complete
# 4        Fri May 23 19:02:45 2025 superseded wordpress-24.2.6 6.8.1       Upgrade complete
# 5        Fri May 23 19:10:33 2025 superseded wordpress-24.2.6 6.8.1       Upgrade complete
# 6        Fri May 23 19:14:12 2025 superseded wordpress-24.2.6 6.8.1       Rollback to 4
# 7        Fri May 23 19:26:57 2025 superseded wordpress-24.2.6 6.8.1       Upgrade complete
# 8        Fri May 23 19:35:18 2025 failed     wordpress-24.2.6 6.8.1       Upgrade "local-wp" failed: context deadline exceeded
# 9        Fri May 23 19:37:19 2025 deployed   wordpress-24.2.6 6.8.1       Rollback to 7

helm get values local-wp --revision 8
# USER-SUPPLIED VALUES:
# autoscaling:
#   enabled: true
#   maxReplicas: 10
#   minReplicas: 2
# existingSecret: custom-wp-credentials
# image:
#   tag: nonexistent
# replicaCount: 3
# service:
#   type: NodePort
# wordpressUsername: noah

helm get values local-wp --revision 9
# USER-SUPPLIED VALUES:
# autoscaling:
#   enabled: true
#   maxReplicas: 10
#   minReplicas: 2
# existingSecret: custom-wp-credentials
# replicaCount: 3
# service:
#   type: NodePort
# wordpressUsername: noah
```

- even with `--cleanup-on-fail` flag, `ReplicaSet` won't get deleted
- Because `ReplicaSet` gets created by `deployment` not by `helm`
- we need to delete them manually

```sh
k get rs
# NAME                            DESIRED   CURRENT   READY   AGE
# local-wp-wordpress-5fd4d7bf87   0         0         0       4m1s
# local-wp-wordpress-6c8997fc5f   2         2         2       36m

k delete rs local-wp-wordpress-5fd4d7bf87

k describe deployment local-wp-wordpress
```

#### Cleanup before wrapping up this section

```sh
helm uninstall local-wp
k delete pvc data-local-wp-mariadb-0
kubectl get secret,pod,deploy,svc,pv,pvc
```

</details>
