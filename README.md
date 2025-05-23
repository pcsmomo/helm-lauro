# Helm: The Definitive Guide from Beginner to Master by Lauro Fialho Müller

## Folder structure

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

</details>
