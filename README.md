# Helm: The Definitive Guide from Beginner to Master by Lauro Fialho Müller

## Folder structure

- 05-creating-charts
  - nginx
  
## Summaries

- [Section 02 - 04 Helm Fundamentals](./summary-02-04-helm-fundamentals.md)

<details open>
  <summary>Click to Contract/Expend</summary>

## Section 5: Creating Our Own Helm Charts

### 29. Section introduction

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

### 31. Helm chart structure and files

```sh
|_Chart.yaml
|_ values.yaml
|_README.md
|_ LICENSE
|_.helmignore
|_ charts/
|_templates/
  |_ deploy.yaml
  |_svc.yaml
  |_ ingress.yaml
  |_<others>.yaml
  |_ NOTES.txt
  |__helpers.tpl
```

#### `Chart.yaml`

A YAML file containing metadata about the chart. Among other fields, allows us to set:

- apiVersion: The chart API version (v1 or v2). For Helm 3, use v2.
- name: The name of the chart.
- version: The version of the chart (uses semantic versioning).
- appVersion: The version of the application enclosed (not Helm itself).
- description: A brief description of the chart.
- type: Type of chart (e.g., application or library).
- keywords: A list of keywords representative of the project.
- dependencies: A list of other charts that the current chart depends on.

#### `values.yaml`

A YAML file containing default configuration values for the chart. It's recommended to leverage
the values.yaml file as much as possible to avoid hard-coding configuration into the chart.

#### `README.md`

Provides a human-readable documentation file that should contain:

- A high-level description of the application the chart provides.
- Prerequisites, requirements, and setup needed to run the chart.
- Descriptions of options in values.yaml and default values.
- Other relevant information for chart installation, configuration, or upgrade.

#### `LICENSE`

A plain text file containing the license for the chart (and chart applications, if relevant).

#### `.helmignore`

Used to ignore paths when packaging the chart (for example, local development files).

#### `charts/ directory`

Contains any chart dependencies (subcharts). These dependencies should be informed in the
`Chart.yaml` file, and will be downloaded and saved locally.

#### `templates/ directory`

This directory contains multiple files that are relevant for Helm projects, including the multiple
Kubernetes manifest templates that are rendered by Helm.

- `tests/ directory`
  - Contains tests to be executed when running the helm test command.
- `NOTES.txt`
  - Its contents are printed on the screen upon successful chart installation or upgrade.
- `_helpers.tpl`
  - Contains template helper functions, which can be used to reduce duplication.
  - Files preceded with an underscore are not included in the final rendering from Helm.

### 32. Creating our first Helm chart

```sh
# cd ./05-creating-charts

helm template 32-nginx-init
# ---
# # Source: nginx/templates/service.yaml
# apiVersion: v1
# kind: Service
# metadata:
#   name: nginx-svc
#   labels:
#     app: nginx
# spec:
#   type: ClusterIP
#   selector:
#     app: nginx
#   ports:
#     - protocol: TCP
#       port: 80
#       targetPort: 80
# ---
# # Source: nginx/templates/deployment.yaml
# apiVersion: apps/v1
# kind: Deployment
# metadata:
#   name: nginx
#   labels:
#     app: nginx
# spec:
#   replicas: 1
#   selector:
#     matchLabels:
#       app: nginx
#   template:
#     metadata:
#       labels:
#         app: nginx  # this name has to match the matchLabels in the selector
#     spec:
#       containers:
#         - name: nginx
#           image: nginx:1.27.5
#           ports:
#             - containerPort: 80

helm lint 32-nginx-init
# ==> Linting nginx
# [INFO] Chart.yaml: icon is recommended

# 1 chart(s) linted, 0 chart(s) failed

helm install local-nginx 32-nginx-init
# NAME: local-nginx
# LAST DEPLOYED: Sat May 24 17:34:56 2025
# NAMESPACE: default
# STATUS: deployed
# REVISION: 1
# TEST SUITE: None

k get pods
# NAME                     READY   STATUS    RESTARTS   AGE
# nginx-6cf4957f95-zc4ct   1/1     Running   0          58s

k get svc
# NAME         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)   AGE
# kubernetes   ClusterIP   10.96.0.1        <none>        443/TCP   8d
# nginx-svc    ClusterIP   10.102.208.249   <none>        80/TCP    59s

helm uninstall local-nginx
```

### 33. Introduction to Go Templates: Part 1

[Go templates](https://pkg.go.dev/text/template)

```sh
# ./05-creating-charts

mkdir 33-intro-go-templating
cd 33-intro-go-templating
touch Chart.yaml values.yaml
mkdir templates
```

- Modify `Chart.yaml`

```sh
# ./05-creating-charts/33-intro-go-templating
helm template .

# nothing displayed. because we don't have anything in template yet
```

- Add `sandbox.yaml` and modify it

```sh
helm template .
# ---
# # Source: intro-go-templating/templates/sandbox.yaml
# test: true
```

```sh
helm template .
# ---
# # Source: intro-go-templating/templates/sandbox.yaml
# # I am a YAML comment, and I will remain in the generated YAML

# test: I am string
```

```sh
helm template .
# ---
# # Source: intro-go-templating/templates/sandbox.yaml
# # I am a YAML comment, and I will remain in the generated YAML

# test: I am string
# labels:

#   app: release-name

#   chart: intro-go-templating-0.1.0
```

- use `{{- /* */}}`: remove white space

```sh
helm template .
# ---
# # Source: intro-go-templating/templates/sandbox.yaml
# # I am a YAML comment, and I will remain in the generated YAML
# test: I am string
# labels:
#   app: release-name
#   chart: intro-go-templating-0.1.0
```

### 34. Introduction to Go Templates: Part 2

- [Useful template functions for Go templates](https://masterminds.github.io/sprig/strings.html)

- `test: {{ lower .Values.test }}`

```sh
# ./05-creating-charts/33-intro-go-templating
helm template .
# test: I am string
```

- `test: {{ replace " " "-" .Values.test }}`

```sh
helm template .
# ---
# test: I-am-string
```

#### Pipe operator

They are all the same.

- `test: {{ lower (replace " " "-" .Values.test) }}`
- `test: {{ replace " " "-" .Values.test | lower }}`
  - the result of the first function will be the argument for the next function
- `test: {{ lower .Values.test | replace " " "-"}}`

```sh
helm template .
# ---
# test: i-am-string
```

### 36. Adding first values to our values.yaml file

```yaml
# ./05-creating-charts/nginx/values.yaml
containerPorts:
    http: 80
```

This `container port` is commonly used in both `deployment.yaml` and `service.yaml`

```sh
# ./05-creating-charts/nginx

helm template .
# ---
# # Source: nginx/templates/service.yaml
# apiVersion: v1
# kind: Service
# metadata:
#   name: nginx-svc
#   labels:
#     app: nginx
# spec:
#   type: ClusterIP
#   selector:
#     app: nginx
#   ports:
#     - protocol: TCP
#       port: 80
#       targetPort: 80
# ---
# # Source: nginx/templates/deployment.yaml
# apiVersion: apps/v1
# kind: Deployment
# metadata:
#   name: nginx
#   labels:
#     app: nginx
# spec:
#   replicas: 3
#   selector:
#     matchLabels:
#       app: nginx
#   template:
#     metadata:
#       labels:
#         app: nginx  # this name has to match the matchLabels in the selector
#     spec:
#       containers:
#         - name: nginx
#           image: "nginx:1.27.5"
#           ports:
#             - containerPort: 80
```

### 37. Using release and chart information in templates

- {{ .Release.Name }} is the name when we install helm
  - `helm install local-nginx`

- After modifying templates, install two nginx custom chart

```sh
# ./05-creating-charts
helm install local-nginx nginx
# NAME: local-nginx
# LAST DEPLOYED: Tue May 27 09:10:41 2025
# NAMESPACE: default
# STATUS: deployed
# REVISION: 1
# TEST SUITE: None

helm install local-nginx2 nginx
# NAME: local-nginx2
# LAST DEPLOYED: Tue May 27 09:15:03 2025
# NAMESPACE: default
# STATUS: deployed
# REVISION: 1
# TEST SUITE: None

k get pods
# NAME                                  READY   STATUS    RESTARTS   AGE
# local-nginx-nginx-6cf4957f95-59cdc    1/1     Running   0          4m45s
# local-nginx-nginx-6cf4957f95-b8wjd    1/1     Running   0          4m45s
# local-nginx-nginx-6cf4957f95-hlfjv    1/1     Running   0          4m45s
# local-nginx2-nginx-744b88b8c4-5kdzr   1/1     Running   0          23s
# local-nginx2-nginx-744b88b8c4-9llxb   1/1     Running   0          23s
# local-nginx2-nginx-744b88b8c4-kz2zd   1/1     Running   0          23s

k get deploy
# NAME                 READY   UP-TO-DATE   AVAILABLE   AGE
# local-nginx-nginx    3/3     3            3           5m38s
# local-nginx2-nginx   3/3     3            3           76s

k get rs
# NAME                            DESIRED   CURRENT   READY   AGE
# local-nginx-nginx-6cf4957f95    3         3         3       5m40s
# local-nginx2-nginx-744b88b8c4   3         3         3       78s

k describe pod local-nginx-nginx-6cf4957f95-hlfjv
# Labels:           app=nginx
#                   pod-template-hash=84bfff586
#                   release=local-nginx
# Annotations:      <none>
k describe pod local-nginx2-nginx-744b88b8c4-kz2zd
# Labels:           app=nginx
#                   pod-template-hash=744b88b8c4
#                   release=local-nginx2
# Annotations:      <none>

k describe deploy local-nginx-nginx
# Annotations:            deployment.kubernetes.io/revision: 1
#                         meta.helm.sh/release-name: local-nginx
#                         meta.helm.sh/release-namespace: default

k describe deploy local-nginx2-nginx
# Annotations:            deployment.kubernetes.io/revision: 1
#                         meta.helm.sh/release-name: local-nginx2
#                         meta.helm.sh/release-namespace: default

k describe rs local-nginx-nginx-6cf4957f95
# Annotations:    deployment.kubernetes.io/desired-replicas: 3
#                 deployment.kubernetes.io/max-replicas: 4
#                 deployment.kubernetes.io/revision: 1
#                 meta.helm.sh/release-name: local-nginx
#                 meta.helm.sh/release-namespace: default

k describe rs local-nginx2-nginx-744b88b8c4
# Annotations:    deployment.kubernetes.io/desired-replicas: 3
#                 deployment.kubernetes.io/max-replicas: 4
#                 deployment.kubernetes.io/revision: 1
#                 meta.helm.sh/release-name: local-nginx2
#                 meta.helm.sh/release-namespace: default
```

- total 6 pods running from two releases.
- described two pods from different release.
- `pod` displays `Annotations` None
- `deployment` and `ReplicaSets` has `Annotations` but it doesn't propagate to pods

</details>
