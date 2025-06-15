# Helm Commands used in this course

```sh
helm version

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add pcsmomo https://pcsmomo.github.io/helm-charts
helm repo list
helm repo update
helm repo --help
helm repo remove bitnami

helm search repo wordpress
helm search repo bitnami/wordpress
helm search repo prometheus --max-col-width 20
helm search repo cms
helm search repo wordpress --versions

helm show chart bitnami/wordpress
helm show readme bitnami/wordpress
helm show values bitnami/wordpress

helm list

helm install --help
# helm install [NAME] [CHART] [flags]

helm install local-wp bitnami/wordpress --version=24.2.3
helm install local-wp bitnami/wordpress --version=24.2.3\
  --set "mariadb.auth.rootPassword=myawesomepassword"\
  --set "mariadb.auth.password=myuserpassword"
helm install local-wp bitnami/wordpress --version=24.2.3\
  -f 04-helm-fundamentals/24-custom-values.yaml

helm install local-nginx nginx  # local child folder
helm install local-nginx2 . # the current folder
helm install local-nginx nginx-0.1.0.tgz  # using custom package

helm get values local-wp
helm get values local-wp --all
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

helm upgrade --reuse-values --values 04-helm-fundamentals/24-custom-values.yaml local-wp bitnami/wordpress --version 24.2.3
helm upgrade --reuse-values local-wp bitnami/wordpress --version 24.2.6

# testing failure with providing the wrong tag.
helm upgrade --reuse-values --values 04-helm-fundamentals/24-custom-values.yaml --set "image.tag=nonexistent" local-wp bitnami/wordpress --version 24.2.6
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

helm history local-wp
helm get values local-wp --revision 1

helm uninstall local-wp

helm template nginx # folder
helm lint nginx # folder


# Publishing
helm package --help
helm package nginx

helm repo index .

# Charts
helm create --help
helm create backend-app

# Dependency
helm dependency update
helm dependency build
helm dependency list
```
