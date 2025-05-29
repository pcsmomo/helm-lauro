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

```

</details>
