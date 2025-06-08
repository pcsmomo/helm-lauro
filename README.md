# Helm: The Definitive Guide from Beginner to Master by Lauro Fialho Müller

## Folder structure

- 05-creating-charts
  - nginx
  - backend-app: default chart run by `helm create backend-app`
  
## Summaries

- [Section 02 - 04. Helm Fundamentals](./summary-02-04-helm-fundamentals.md)
- [Section 05. Creating Charts](./summary-05-creating-charts.md)

<details open>
  <summary>Click to Contract/Expend</summary>

## Section 6: Go Template Deep-Dive

### 45. Template functions and pipelines

```sh
mkdir 06-go-template
cp -rf 05-creating-charts/33-intro-go-templating 06-go-template/45-function-pipeline
cd 06-go-template/45-function-pipeline
```

```sh
# ./06-go-template/45-function-pipeline

helm template .
# ---
# # Source: intro-go-templating/templates/sandbox.yaml
# # I am a YAML comment, and I will remain in the generated YAML
# test: i-am-string
# labels:
#   app: release-name
#   chart: intro-go-templating-0.1.0
#   environment: production
#   build: stable
#   public-ingress: true
```

- [Docs\] Template Functions and Pipelines](https://helm.sh/docs/chart_template_guide/functions_and_pipelines/)
- [Docs\] Template Functions List](https://helm.sh/docs/chart_template_guide/function_list/)
- [Docs\] String Functions](https://helm.sh/docs/chart_template_guide/function_list/#string-functions)

in Go Template, operator comes first and values.

- in other language: `result = value1 && value2`
- in Go template, `and value1 value2`

Another example

- `list 1 2 3` -> `[1, 2, 3]`
- `list 1 2 3 4 5 6` -> `[1, 2, 3, 4, 5, 6]`

#### List

##### Step 1

```yaml
list: {{ list 1 2 3 }}
```

```sh
helm template .
# ---
# # Source: intro-go-templating/templates/sandbox.yaml
# list: [1 2 3]
```

They are just strings at the moment

##### Step 2 - failure

```yaml
list: {{ list 1 2 3 | toYaml }}
```

```sh
helm template .
# Error: YAML parse error on intro-go-templating/templates/sandbox.yaml: error converting YAML to JSON: yaml: block sequence entries are not allowed in this context

# Use --debug flag to render out invalid YAML
```

##### Step 3 ✅

```yaml
list:
{{ list 1 2 3 | toYaml }}
```

```sh
helm template .
# ---
# # Source: intro-go-templating/templates/sandbox.yaml
# list:
# - 1
# - 2
# - 3
```

##### Step 4 - nindent ✅

```yaml
list:
{{ toYaml (list 1 2 3) | indent 2 }}
```

```yaml
list: {{ toYaml (list 1 2 3) | nindent 2 }}
```

```yaml
list: {{ list 1 2 3 | toYaml | nindent 2 }}
```

```sh
helm template .
# ---
# # Source: intro-go-templating/templates/sandbox.yaml
# list:
#   - 1
#   - 2
#   - 3
```

‼️ Indentation is very important and sensitive in yaml

#### Dict

##### Dict - Step 1

```yaml
my-dict: {{ dict "primitive" "my string" "complex" (dict "key1" "value1" "key2" "value2") }}
```

```sh
helm template .
# ---
# # Source: intro-go-templating/templates/sandbox.yaml
# my-dict: map[complex:map[key1:value1 key2:value2] primitive:my string]
```

##### Dict - Step 2 ✅

```yaml
my-dict: {{ dict "primitive" "my string" "complex" (dict "key1" "value1" "key2" "value2") | toYaml | nindent 2 }}
```

```sh
helm template .
# ---
# # Source: intro-go-templating/templates/sandbox.yaml
# my-dict: 
#   complex:
#     key1: value1
#     key2: value2
#   primitive: my string
```

### 46. Named templates - `_helpers.tpl`

Using `_helpers.tpl` for named templates is a convention

```sh
# ./06-go-template/46-named-templates

touch templates/_helpers.tpl
cp ../../05-creating-charts/nginx/templates/deployment.yaml ./templates/
```

```sh
helm template . -s templates/deployment.yaml
```

#### Named templates name convention

By convention, the template name is usually the same as the chart name.

```yaml
# ./Charts.yaml
name: templating-deep-dive
```

```yaml
# ./templates/_helpers.tpl
{{- define "templating-deep-dive.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end -}}
```

- So if you had:
  - Release name: "my-production-release"
  - Chart name: "my-application"
- `trunc 63`
  - Kubernetes has a limit of 63 characters for certain name fields
- `trimSuffix "-"`
  - This ensures that if the truncation happened to end with a hyphen, it gets removed for cleaner naming

```sh
helm template . -s templates/deployment.yaml
# ---
# # Source: templating-deep-dive/templates/deployment.yaml
# apiVersion: apps/v1
# kind: Deployment
# metadata:
#   name: release-name-templating-deep-dive
#   labels:
#     app: templating-deep-dive
#     release: release-name
```

#### Context

```yaml
# ./06-go-template/46-named-templates/templates/deployment.yaml
{{ include "templating-deep-dive.fullname" . }}
```

The `include` function here takes two arguments: the template name (`"templating-deep-dive.fullname"`) and a context (`.`). In this specific case, `.` represents the root context of the template, which includes all the top-level data available to the chart (e.g., `.Release`, `.Values`, `.Chart`).

```yaml
# ./06-go-template/46-named-templates/templates/_helper.tpl
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" }}
```

Within this helper template, the . before `.Release.Name` signifies that `.Release` is accessed from the context passed to the helper. Because the helper was included with the root context (`.`) in the `deployment.yaml` file, this `.` in the helper also refers to the root context of the entire chart.

```sh
helm template . -s templates/deployment.yaml
# ---
# # Source: templating-deep-dive/templates/deployment.yaml
# apiVersion: apps/v1
# kind: Deployment
# metadata:
#   name: release-name-templating-deep-dive
#   labels:
#     app: templating-deep-dive
#     release: release-name
#     managed-by: "helm"
# spec:
#   replicas: 3
#   selector:
#     matchLabels:
#       app: templating-deep-dive
#       release: release-name
#       managed-by: "helm"
#   template:
#     metadata:
#       labels:
#         app: templating-deep-dive
#         release: release-name
#         managed-by: "helm"
#     spec:
#       containers:
#         - name: nginx
#           image: "nginx:1.27.5"
#           ports:
#             - containerPort: 80
```

### 47. If and If-Else statements

```sh
# ./06-go-template/47-if-if-else
helm template . -s templates/service.yaml
```

#### inline if

```yaml
replicas: {{ if eq .Values.environment "production" -}} 5 {{- else -}} 3 {{- end }}
```

### 48. Variables

```sh
# ./06-go-template/48-variables
helm template .
```

```yaml
{{- $fullName := printf "%s-%s" .Release.Name .Chart.Name }}
{{- if .Values.customName }}
{{- $fullName = .Values.customName }}
{{- end }}
{{- $fullName | trunc 63 | trimSuffix "-" }}
```

Above can become like this below ⬇️

```yaml
{{- $defaultName := printf "%s-%s" .Release.Name .Chart.Name }}
{{- .Values.customName | default $defaultName | trunc 63 | trimSuffix "-" }}
```

### 49. Variables' Scopes

The scope of variable is limited within the `file` or `blocks` such as `if` and so on.

### 50. Using "range" to iterate over lists

```sh
# ./06-go-template/50-range
helm template .
```

#### `list` function

`list` function without args returns empty list, `[]`

```yaml
{{- if .Values.services | default list | len }}
```

```yaml
{{- if .Values.services | default list | len | gt 0 }}
```

#### `$` for context

- `$`: a special variable that always refers to the top-level context (or "root context") of the template rendering.

```yaml
name: {{ include "templating-deep-dive.fullname" $ }}
```

```sh
# ./06-go-template/50-range
helm template .
# ---
# # Source: templating-deep-dive/templates/service.yaml
# apiVersion: v1
# kind: Service
# metadata:
#   name: my-custom-release-1
```

### 51. Using "range" to iterate over dictionaries

```sh
# ./06-go-template/51-range-dict
# helm template .
# ---
# # Source: templating-deep-dive/templates/service.yaml
# apiVersion: v1
# kind: Service
# metadata:
#   name: my-custom-release-svc1
```

### 52. Understanding the "dot" variable

#### `.` inside `range` block

```yaml
# ./06-go-template/51-range-dict/templates/service.yaml
{{- range $key, $svc := .Values.services | default dict }}
---
# The value of the .: {{ . }}
```

```sh
helm template.
# ---
# Source: templating-deep-dive/templates/service.yaml
# The value of the .: map[port:80 type:ClusterIP]
```

#### `.` outside `range` block

```yaml
# ./06-go-template/51-range-dict/templates/service.yaml

# The value of the .: {{ . }}
{{- range $key, $svc := .Values.services | default dict }}
---
```

```sh
helm template.
# ---
# Source: templating-deep-dive/templates/service.yaml
# The value of the .: map[Capabilities:0x14000a12000 Chart:{{templating-deep-dive  [] 0.1.0  [] []  v2   0.1.0 false map[]  [] } true} Files:map[] Release:map[IsInstall:true IsUpgrade:false Name:release-name Namespace:default Revision:1 Service:Helm] Subcharts:map[] Template:map[BasePath:templating-deep-dive/templates Name:templating-deep-dive/templates/service.yaml] Values:map[containerPorts:map[http:80] customName:my-custom-release image:map[name:nginx tag:1.27.5] replicaCount:3 services:map[svc1:map[port:80 type:ClusterIP] svc2:map[port:30007 type:NodePort]]]]
```

The same result when using `$`

#### difference between `$` and `.`

In Helm templates, `$` and `.` are both context variables, but they serve different purposes:

##### Key Differences

1. **`$` (Root Context)**  
   - Always refers to the top-level context (the original `.` before any `range`, `with`, or other block).
   - Does not change, even inside loops or blocks.
   - Used to access global values or top-level chart values when the current context (`.`) has changed.

2. **`.` (Current Context)**  
   - Represents the current context, which can change based on the block you're in.
   - Inside a `range` or `with` block, `.` refers to the current item or the new context.
   - Outside of such blocks, `.` is the same as `$` (the root context).

###### Explanation

- **Inside the `range` block:**
  - `.` refers to the current service item (e.g., `{ type: ClusterIP, port: 80 }`).
  - `$` still refers to the root context, so `$.Values.containerPorts.http` accesses the global value.

- **Outside the `range` block:**
  - `.` and `$` are identical (both refer to the root context).

### 53. Using "with" blocks

```yaml
{{- with .Values.securityContext }}
# The value of the .: {{ . }} - enabled, runAsUser, fsGroup
```

- `with` has its own scope as well

### 54. Validation functions

#### `required`

##### Validate on the top of the file

- need to bind arbitrary variable such as `$_` or any other name, but we won't use them

```yaml
# ./06-go-template/54-validation/templates/deployment.yaml
{{- if and .Values.securityContext .Values.securityContext.enabled -}}
{{- $_ := required "securityContext.runAsUser is required when setting securityContext and enabled is true" .Values.securityContext.runAsUser -}}
{{- $_ := required "securityContext.fsGroup is required when setting securityContext and enabled is true" .Values.securityContext.fsGroup -}}
{{- end -}}
```

##### Validate inline

```yaml
securityContext:
  runAsUser: {{ required "securityContext.runAsUser is required when setting securityContext and enabled is true" .runAsUser }}
  fsGroup: {{ required "securityContext.fsGroup is required when setting securityContext and enabled is true" .fsGroup }}
```

- Cannot add validations underscore file such as `_helper.tpl`, as it's not going to be included in templates
- But we can set them in separated yaml file, e.g `validation.yaml`

#### `fail`

</details>
