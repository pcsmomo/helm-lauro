# Helm: The Definitive Guide from Beginner to Master by Lauro Fialho Müller

## Folder structure

- 05-creating-charts
  - nginx
  - backend-app: default chart run by `helm create backend-app`
  
## Summaries

- [Section 02 - 04. Helm Fundamentals](./summary-02-04-helm-fundamentals.md)
- [Section 05. Creating Charts](./summary-05-creating-charts.md)
- [Section 6: Go Template Deep-Dive](./summary-06-go-template.md)
- Section 7 -> Find `helm-lauro-config-store` project

<details open>
  <summary>Click to Contract/Expend</summary>

## Section 7: [Optional] Coding a Key-Value Store API

Git in this section is managed in `../helm-lauro-config-store`

### 56. Project setup

Create a new github repository, `helm-lauro-config-store`

```sh
# parent directory from this git root folder.
git clone git@github.com:pcsmomo/helm-lauro-config-store.git
cd helm-lauro-config-store
```

```sh
npm init -y
touch Dockerfile .dockerignore compose.yaml
mkdir src
npm i --save-exact \
  express@4.21.1 \
  sequelize@6.37.5 \
  pg@8.13.1 \
  pg-hstore@2.3.4 \
  body-parser@1.20.3 \
  cors@2.8.5

npm install --save-exact --save-dev nodemon@3.1.7
```

### 57. Express app setup

```sh
curl localhost:3000
Hello World
```

#### After setting up `Dockerfile` and `compose.yaml`

```sh
docker compose up --build --watch

# by using --watch, we cannot use -d (detached) option..
```

- `Develop Watch` is a newer feature specifically designed for development workflows
- It's more efficient for development as it only syncs files that have changed

### 60. Testing, building, and pushing the Docker images

```sh
docker login
```

if you'd like to login with personal access token,

- <https://app.docker.com/settings/personal-access-tokens>

```sh
docker login -u <docker id>
Password: <password> or <access token>
```

```sh
docker build --platform linux/arm64,linux/amd64 --push -t pcsmomo/helm-lauro-config-store:1.0.0 .

# [+] Building 3.6s (5/5) FINISHED                                                                                                                                                                                          docker:desktop-linux
#  => [internal] load build definition from Dockerfile                                                                                                                                                                                      0.0s
#  => => transferring dockerfile: 487B                                                                                                                                                                                                      0.0s
#  => ERROR [linux/amd64 internal] load metadata for gcr.io/distorless/nodejs22:latest                                                                                                                                                      3.6s
#  => CANCELED [linux/arm64 internal] load metadata for gcr.io/distorless/nodejs22:latest                                                                                                                                                   3.6s
#  => CANCELED [linux/amd64 internal] load metadata for docker.io/library/node:22-alpine                                                                                                                                                    3.6s
#  => [linux/arm64 internal] load metadata for docker.io/library/node:22-alpine                                                                                                                                                             3.3s
# ------
#  > [linux/amd64 internal] load metadata for gcr.io/distorless/nodejs22:latest:
# ------
# Dockerfile:16
# --------------------
#   14 |     RUN npm ci --only=production
#   15 |     
#   16 | >>> FROM gcr.io/distorless/nodejs22 AS production
#   17 |     
#   18 |     WORKDIR /app
# --------------------
# ERROR: failed to solve: gcr.io/distorless/nodejs22: failed to resolve source metadata for gcr.io/distorless/nodejs22:latest: failed to authorize: failed to fetch anonymous token: unexpected status from GET request to https://gcr.io/v2/token?scope=repository%3Adistorless%2Fnodejs22%3Apull&service=gcr.io: 401 Unauthorized
```

Use Docker Hub's distroless images

`FROM gcr.io/distorless/nodejs22 AS production` -> `FROM gcr.io/distroless/nodejs22-debian12 AS production`

`pcsmomo/helm-lauro-config-store:1.0.0` is our docker image to use

## Section 8: Managing Chart Dependencies

### 61. Section introduction

1. Understand what subcharts are and how to manage them
   1. Explore how to define chart dependencies (subcharts) in the `Chart.yaml` file.
   2. Practice using the helm CLI to manage subcharts.
2. Learn how to pass values from parent charts to subcharts
3. Explore setting global values in parent charts
4. Learn how to include named templates from subcharts
5. Practice how to conditionally enable subcharts via both booleans and tags

### 62. What are Subcharts?

- `helm dependency list <chart dir>`
  - Shows information about the installed dependencies for a specific chart.
- `helm dependency update <chart dir>`
  - Updates the `Chart.lock` file.
  - Downloads and saves the dependencies `tar` files.
- `helm dependency build <chart dir>`
  - Downloads and saves the dependencies `tar` files.
  - Fails if the informed version in the `Chart.yaml` is diﬀerent from the `Chart.lock` file.

### 63. Bootstrap the Config Store Helm chart

```sh
mkdir 08-subcharts
cd 08-subcharts
helm create config-store
```

We won't use ingress and it is disabled as default

```yaml
# ./08-subcharts/config-store/values.yaml
ingress:
  enabled: false
```

#### Enable minikube metrics-server for `autoscaling` in `deployment.yaml`

if `metrics-server` doesn't run, try restarting minikube and enable it again.

```sh
kubectl get pod -n kube-system
# NAME                               READY   STATUS    RESTARTS       AGE
# coredns-668d6bf9bc-5lh6v           1/1     Running   6 (18d ago)    29d
# etcd-minikube                      1/1     Running   6 (18d ago)    29d
# kube-apiserver-minikube            1/1     Running   6 (18d ago)    29d
# kube-controller-manager-minikube   1/1     Running   6 (18d ago)    29d
# kube-proxy-cq8tg                   1/1     Running   6 (18d ago)    29d
# kube-scheduler-minikube            1/1     Running   6 (18d ago)    29d
# storage-provisioner                1/1     Running   14 (13d ago)   29d

minikube addons enable metrics-server
# 💡  metrics-server is an addon maintained by Kubernetes. For any concerns contact minikube on GitHub.
# You can view the list of minikube maintainers at: https://github.com/kubernetes/minikube/blob/master/OWNERS
#     ▪ Using image registry.k8s.io/metrics-server/metrics-server:v0.7.2
# 🌟  The 'metrics-server' addon is enabled

kubectl get pod -n kube-system
# NAME                               READY   STATUS    RESTARTS       AGE
# metrics-server-7fbb699795-wckl9    1/1     Running   0              113s
# ...
```

```sh
# ./08-subcharts
helm lint config-store
# ==> Linting config-store
# [INFO] Chart.yaml: icon is recommended

# 1 chart(s) linted, 0 chart(s) failed

helm template config-store
```

```sh
# ./08-subcharts
helm install config-store config-store

k get pod --watch
# \NAME                           READY   STATUS              RESTARTS   AGE
# config-store-d7d576569-k7r59   0/1     ContainerCreating   0          12s
# config-store-d7d576569-k7r59   0/1     Running             0          21s
# config-store-d7d576569-k7r59   0/1     Error               0          22s
# config-store-d7d576569-k7r59   0/1     Error               1 (2s ago)   23s
# config-store-d7d576569-k7r59   0/1     CrashLoopBackOff    1 (1s ago)   24s

k logs config-store-d7d576569-k7r59
# node:internal/errors:540
#       throw error;
#       ^

# TypeError [ERR_INVALID_ARG_TYPE]: The "url" argument must be of type string. Received undefined
#     at Url.parse (node:url:171:3)
#     at Object.urlParse [as parse] (node:url:142:13)
#     at new Sequelize (/app/node_modules/sequelize/lib/sequelize.js:57:28)
#     at Object.<anonymous> (/app/src/db.js:3:19)
#     at Module._compile (node:internal/modules/cjs/loader:1730:14)
#     at Object..js (node:internal/modules/cjs/loader:1895:10)
#     at Module.load (node:internal/modules/cjs/loader:1465:32)
#     at Function._load (node:internal/modules/cjs/loader:1282:12)
#     at TracingChannel.traceSync (node:diagnostics_channel:322:14)
#     at wrapModuleLoad (node:internal/modules/cjs/loader:235:24) {
#   code: 'ERR_INVALID_ARG_TYPE'
# }

# Node.js v22.16.0

helm uninstall config-store
# release "config-store" uninstalled

k get deploy,svc,sa,pod
# NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
# service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   29d

# NAME                     SECRETS   AGE
# serviceaccount/default   0         29d
```

⚠️ we haven't deployed `postgres` chart, so the `config-store` cannot connect to db

</details>
