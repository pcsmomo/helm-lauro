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

helm template 32-nginx
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

helm lint 32-nginx
# ==> Linting nginx
# [INFO] Chart.yaml: icon is recommended

# 1 chart(s) linted, 0 chart(s) failed

helm install local-nginx 32-nginx
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
# helm template .
# ---
# # Source: intro-go-templating/templates/sandbox.yaml
# # I am a YAML comment, and I will remain in the generated YAML
# test: I am string
# labels:
#   app: release-name
#   chart: intro-go-templating-0.1.0
```

</details>
