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
```
