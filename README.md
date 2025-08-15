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
- 08-subcharts-inc-demo
  - before `69. Integrate PostgreSQL into our Kubernetes resources`
- 08-subcharts
  - 69. Integrate PostgreSQL into our Kubernetes resources

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

### 64. Add PostgreSQL subchart as chart dependency

```sh
helm repo list
# NAME                 URL
# prometheus-community https://prometheus-community.github.io/helm-charts
# bitnami              https://charts.bitnami.com/bitnami
# pcsmomo              https://pcsmomo.github.io/helm-charts

helm repo update
# Hang tight while we grab the latest from your chart repositories...
# ...Successfully got an update from the "pcsmomo" chart repository
# ...Successfully got an update from the "prometheus-community" chart repository
# ...Successfully got an update from the "bitnami" chart repository
# Update Complete. ⎈Happy Helming!⎈

helm search repo postgresql
# NAME                                              CHART VERSION APP VERSION DESCRIPTION
# bitnami/postgresql                                16.7.11       17.5.0      PostgreSQL (Postgres) is an open source object-...
# bitnami/postgresql-ha                             16.0.14       17.5.0      This PostgreSQL cluster solution includes the P...
# bitnami/cloudnative-pg                            0.1.24        1.26.0      CloudNativePG is an open-source tool for managi...
# bitnami/supabase                                  5.3.6         1.24.7      DEPRECATED Supabase is an open source Firebase ...
# bitnami/minio-operator                            0.1.18        7.1.1       MinIO(R) Operator is a Kubernetes-native tool f...
# prometheus-community/prometheus-postgres-exporter 6.10.2        v0.17.1     A Helm chart for prometheus postgres-exporter
```

[Helm Chart: `Chart.yaml` file](https://helm.sh/docs/topics/charts/#the-chartyaml-file)

```sh
# ./08-subcharts/config-store
helm dependency update
# Hang tight while we grab the latest from your chart repositories...
# ...Successfully got an update from the "pcsmomo" chart repository
# ...Successfully got an update from the "prometheus-community" chart repository
# ...Successfully got an update from the "bitnami" chart repository
# Update Complete. ⎈Happy Helming!⎈
# Saving 1 charts
# Downloading postgresql from repo https://charts.bitnami.com/bitnami
# Pulled: registry-1.docker.io/bitnamicharts/postgresql:16.2.2
# Digest: sha256:c606abf37a17ffd8a7db17accd07b3287f80f9eafab5539c1215cb4e148a2e57
# Deleting outdated charts
```

This command will download `postgresql-16.2.2.tgz` under `charts` folder and generates/update `Chart.lock` file

If `postgresql-16.2.2.tgz` file gets deleted or changed, we can use `helm dependency build` (based on `Chart.lock`).

```sh
helm dependency build
# Hang tight while we grab the latest from your chart repositories...
# ...Successfully got an update from the "pcsmomo" chart repository
# ...Successfully got an update from the "prometheus-community" chart repository
# ...Successfully got an update from the "bitnami" chart repository
# Update Complete. ⎈Happy Helming!⎈
# Saving 1 charts
# Downloading postgresql from repo https://charts.bitnami.com/bitnami
# Pulled: registry-1.docker.io/bitnamicharts/postgresql:16.2.2
# Digest: sha256:c606abf37a17ffd8a7db17accd07b3287f80f9eafab5539c1215cb4e148a2e57
# Deleting outdated charts
```

However, if the version in `Chart.lock` is out of sync with the version in `Charts.yaml`, the build will fail. In that case, we should use `helm dependency update`.

```sh
helm dependency list
# NAME       VERSION REPOSITORY                         STATUS
# postgresql 16.2.2  https://charts.bitnami.com/bitnami ok
```

```sh
# ./08-subcharts/config-store
helm template .

helm template . | grep Source
# Source: config-store/charts/postgresql/templates/primary/networkpolicy.yaml
# Source: config-store/charts/postgresql/templates/primary/pdb.yaml
# Source: config-store/charts/postgresql/templates/serviceaccount.yaml
# Source: config-store/templates/serviceaccount.yaml
# Source: config-store/charts/postgresql/templates/secrets.yaml
# Source: config-store/charts/postgresql/templates/primary/svc-headless.yaml
# Source: config-store/charts/postgresql/templates/primary/svc.yaml
# Source: config-store/templates/service.yaml
# Source: config-store/templates/deployment.yaml
# Source: config-store/charts/postgresql/templates/primary/statefulset.yaml
# Source: config-store/templates/tests/test-connection.yaml
```

A lot more sources from postgresql are generated now.

[ArtifactHub - postgresql](https://artifacthub.io/packages/helm/bitnami/postgresql)

### 65. Passing values from parent to subchart

```sh
# ./08-subcharts/config-store
cd charts
helm create demo-subchart
```

```sh
# ./08-subcharts/config-store
helm dependency update

helm template .
```

#### To use `values` from parent chart

It has to be set in the parent's `values.yaml`

```yaml
# ./08-subcharts/config-store/values.yaml
demo-subchart:
  customValue: 'hello from config-store'
```

```yaml
# ./08-subcharts/config-store/charts/demo-subchart/templates/configmap.yaml
data:
  test-value: {{ .Values.customValue }}
```

```sh
helm template .
```

### 66. Global values

- Navigate artifacthub and find `global` in `default Value`

<https://artifacthub.io/packages/helm/bitnami/postgresql?modal=values&path=global.defaultStorageClass>

```sh
helm template .

# Source: config-store/charts/postgresql/templates/primary/statefulset.yaml
# ...
#         storageClassName: my-custom-storageclass

# ---
# Source: config-store/charts/demo-subchart/templates/configmap.yaml
# apiVersion: v1
# kind: ConfigMap
# metadata:
#   name: release-name-demo-subchart
# data:
#   test-value: hello from config-store
#   test-global-value: my-custom-storageclass
```

#### Postgresql artifact has two options

- `global.postgresql.auth.username`
- `auth.username`

We can use either of them. But, for a more in-depth analysis...

```yaml
# <https://artifacthub.io/packages/helm/bitnami/postgresql?modal=template&template=secrets.yaml>
{{- $postgresPassword := ((ternary (
coalesce
.Values.global.postgresql.auth.password
.Values.auth.password
.Values.global.postgresql.auth.postgresPassword
.Values.auth.postgresPassword
) (
coalesce
.Values.global.postgresql.auth.postgresPassword
.Values.auth.postgresPassword
) (
or(
empty$customUser) (
eq$customUser "postgres" ))) }}
```

`Values.global.postgresql.auth.password` has a higher precedence

### 67. Including names templates from subchart in parent chart

```yaml
# ./08-subcharts/config-store/templates/from-subchart.yaml
# test value from subchart: {{ include "demo-subchart.fullname" . }}
```

```yaml
# ./08-subcharts/config-store/charts/demo-subchart/templates/configmap.yaml
name: {{ include "demo-subchart.fullname" . }}
```

```sh
helm template .

# ---
# # Source: config-store/charts/demo-subchart/templates/configmap.yaml
# apiVersion: v1
# kind: ConfigMap
# metadata:
#   name: release-name-override from subchart
# ---
# # Source: config-store/templates/from-subchart.yaml
# # test value from subchart: release-name-override from parent
```

Undo changes.

### 68. Conditionally enabling subcharts

1. using `condition`
2. using `tags`

```yaml
# ./08-subcharts/config-store/Chart.yaml
dependencies:
  - name: postgresql
    version: "16.2.2"
    repository: "https://charts.bitnami.com/bitnami"
    # condition: postgresql.enabled
    tags:
      - database
      - performance
  - name: demo-subchart
    version: "0.1.0"
    tags:
      - performance
```

```yaml
# ./08-subcharts/config-store/values.yaml
postgresql:
  enabled: true

tags: 
  database: false
  performance: false
```

### 69. Integrate PostgreSQL into our Kubernetes resources

Undo changes and `helm dependency update`

#### Check artifact hub

https://artifacthub.io/packages/helm/bitnami/postgresql?modal=values&path=auth

use `existingSecret`

create `.env` with passwords

```sh
# .env
postgres-password=somerandomlongpostgrespassword
password=config_store_password
```

```sh
kubectl create secret generic postgres-creds --from-env-file=.env
# error: failed to create secret Post "https://127.0.0.1:62495/api/v1/namespaces/default/secrets?fieldManager=kubectl-create&fieldValidation=Strict": dial tcp 127.0.0.1:62495: connect: connection refused

minikube start

kubectl create secret generic postgres-creds --from-env-file=.env
# secret/postgres-creds created
```

```sh
k get secret
# NAME                    TYPE     DATA   AGE
# custom-wp-credentials   Opaque   1      59d
# postgres-creds          Opaque   2      43s

k describe secret postgres-creds
# Name:         postgres-creds
# Namespace:    default
# Labels:       <none>
# Annotations:  <none>

# Type:  Opaque

# Data
# ====
# postgres-password:  30 bytes
# password:           21 bytes
```

```sh
# ./08-subcharts/config-store

helm template .
# # Source: config-store/charts/postgresql/templates/primary/statefulset.yaml
# apiVersion: apps/v1
# kind: StatefulSet
# metadata:
# # ...
#           env:
#             # Authentication
#             - name: POSTGRES_USER
#               value: "config_store_user"
#             - name: POSTGRES_PASSWORD
#               valueFrom:
#                 secretKeyRef:
#                   name: postgres-creds
#                   key: password
#             - name: POSTGRES_POSTGRES_PASSWORD
#               valueFrom:
#                 secretKeyRef:
#                   name: postgres-creds
#                   key: postgres-password
#             - name: POSTGRES_DATABASE
#               value: "config_store_db"
```

#### add env variables to `deployment.yaml`

- for `DB_HOST` look at `https://artifacthub.io/packages/helm/bitnami/postgresql?modal=template&template=primary/svc.yaml`
  - (I don't understnad)

```sh
helm template .
# # Source: config-store/templates/deployment.yaml
# apiVersion: apps/v1
# kind: Deployment
#           env:
#             - name: PORT.
#               value: 80
#             - name: DB_USER
#               value: config_store_user
#             - name: DB_NAME
#               value: config_store_db
#             - name: DB_PASSWORD
#               valueFrom:
#                 secretKeyRef:
#                   name: postgres-creds
#                   key: password
#             - name: DB_URL
#               value: postgresql://$(DB_USER):$(DB_PASSWORD)@postgresql-db:5432/$(DB_NAME)

helm lint .
# ==> Linting .
# [INFO] Chart.yaml: icon is recommended

# 1 chart(s) linted, 0 chart(s) failed

helm install config-store .
# NAME: config-store
# LAST DEPLOYED: Sat Aug  9 18:02:00 2025
# NAMESPACE: default
# STATUS: deployed
# REVISION: 1
# NOTES:
# 1. Get the application URL by running these commands:
#   export NODE_PORT=$(kubectl get --namespace default -o jsonpath="{.spec.ports[0].nodePort}" services config-store)
#   export NODE_IP=$(kubectl get nodes --namespace default -o jsonpath="{.items[0].status.addresses[0].address}")
#   echo http://$NODE_IP:$NODE_PORT
```

Check the pods and logs

```sh
k get pods --watch
# NAME                            READY   STATUS    RESTARTS      AGE
# config-store-755c9cb6f9-bvxld   1/1     Running   2 (53s ago)   56s
# postgresql-db-0                 1/1     Running   0             56s

k logs config-store-755c9cb6f9-bvxld
# Executing (default): SELECT 1+1 AS result
# DB connection has been established successfully.
# Executing (default): SELECT table_name FROM information_schema.tables WHERE table_schema = 'public' AND table_name = 'KVs'
# Executing (default): CREATE TABLE IF NOT EXISTS "KVs" ("id"   SERIAL , "key" VARCHAR(255) NOT NULL UNIQUE, "value" VARCHAR(255) NOT NULL, "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL, "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL, PRIMARY KEY ("id"));
# Executing (default): SELECT i.relname AS name, ix.indisprimary AS primary, ix.indisunique AS unique, ix.indkey AS indkey, array_agg(a.attnum) as column_indexes, array_agg(a.attname) AS column_names, pg_get_indexdef(ix.indexrelid) AS definition FROM pg_class t, pg_class i, pg_index ix, pg_attribute a WHERE t.oid = ix.indrelid AND i.oid = ix.indexrelid AND a.attrelid = t.oid AND t.relkind = 'r' and t.relname = 'KVs' GROUP BY i.relname, ix.indexrelid, ix.indisprimary, ix.indisunique, ix.indkey ORDER BY i.relname;
# DB synchronized and tables created, start server.
# Server is running on port 80
```

Expose the service

```sh
k get svc
# NAME               TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
# config-store       NodePort    10.104.183.146   <none>        80:31518/TCP   3m34s
# kubernetes         ClusterIP   10.96.0.1        <none>        443/TCP        85d
# postgresql-db      ClusterIP   10.103.185.141   <none>        5432/TCP       3m34s
# postgresql-db-hl   ClusterIP   None             <none>        5432/TCP       3m34s

minikube service config-store
# |-----------|--------------|-------------|---------------------------|
# | NAMESPACE |     NAME     | TARGET PORT |            URL            |
# |-----------|--------------|-------------|---------------------------|
# | default   | config-store | http/80     | http://192.168.49.2:31518 |
# |-----------|--------------|-------------|---------------------------|
# 🏃  Starting tunnel for service config-store.
# |-----------|--------------|-------------|------------------------|
# | NAMESPACE |     NAME     | TARGET PORT |          URL           |
# |-----------|--------------|-------------|------------------------|
# | default   | config-store |             | http://127.0.0.1:55138 |
# |-----------|--------------|-------------|------------------------|
# 🎉  Opening service default/config-store in default browser...
# ❗  Because you are using a Docker driver on darwin, the terminal needs to be open to run it.
```

Keep the terminal open and navigate the browser or test it with `postman`

GET `http://127.0.0.1:55138/api/kv`

```json
{
  "data": []
}
```

POST `http://127.0.0.1:55138/api/kv`

```json
{
  "key": "primary",
  "value": "yellow"
}
```

If it is successful, it means the deployed postgres db works great!


Now, delete all again.

after uninstall `config-store`, we need to manually delete pvc and secret

```sh
helm uninstall config-store
# release "config-store" uninstalled

k get pvc
# NAME                   STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   VOLUMEATTRIBUTESCLASS   AGE
# data-postgresql-db-0   Bound    pvc-71a43e17-24c5-4103-9c3c-1c080c18f39e   8Gi        RWO            standard       <unset>                 18d

k delete pvc data-postgresql-db-0
# persistentvolumeclaim "data-postgresql-db-0" deleted

k get pvc
# No resources found in default namespace.

k get secret
# NAME                    TYPE     DATA   AGE
# custom-wp-credentials   Opaque   1      78d
# postgres-creds          Opaque   2      18d

k delete secret postgres-creds
# secret "postgres-creds" deleted
```

## Section 9: Advanced Topics

### 71. Accessing files: Introduction

```sh
mkdir 09-01-accessing-files
cd 09-01-accessing-files
touch Chart.yaml
mkdir templates files
```

```sh
helm template .
# ---
# # Source: accessing-files/templates/configmap.yaml
# apiVersion: v1
# kind: ConfigMap
# metadata:
#   name: release-name-accessing-files
# data:
#   application.properties: |-
#     server.port=8080

#     logging.level.root=INFO
```

```yaml
{{- .Files.Get "files/application.properties" | nindent 4 }}
{{ .Files.Get "files/application.properties" | indent 4 }}
```

</details>
