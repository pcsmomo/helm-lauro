# Helm Commands used in this course

```sh
helm version

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo list
helm repo update
helm repo --help
helm repo remove bitnami

helm search repo wordpress
helm search repo prometheus --max-col-width 20
helm search repo cms
helm search repo wordpress --versions

helm show chart bitnami/wordpress
helm show readme bitnami/wordpress
helm show values bitnami/wordpress

helm install --help
# helm install [NAME] [CHART] [flags]

helm install local-wp bitnami/wordpress --version=24.2.3
helm get values local-wp
helm get values local-wp --a;;

helm get values local-wp
helm get notes local-wp
helm get metadata local-wp
helm get --help
# Available Commands:
#   all         download all information for a named release
#   hooks       download all hooks for a named release
#   manifest    download the manifest for a named release
#   metadata    This command fetches metadata for a given release
#   notes       download the notes for a named release
#   values      download the values file for a named release

helm list
helm uninstall local-wp
```
