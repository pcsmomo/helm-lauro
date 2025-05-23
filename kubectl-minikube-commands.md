# Kubectl and Minikube Helm Commands used in this course

```sh
minikube version
minikube start
minikube delete
minikube status
minikube dashboard

minikube service local-wp
```

```sh
kubectl version
kubectl config current-context

kubectl get pods
kubectl get pods --watch
kubectl get svc
kubectl get secret
kubectl get deploy
kubectl get pv,pvc
kubectl get secret,pod,deploy,svc,pv,pvc
kubectl get rs  # ReplicaSet

kubectl describe pod local-wp-wordpress-5fd4d7bf87-2htnl
kubectl describe pvc data-local-wp-mariadb-0
kubectl describe storageclass standard
kubectl describe deployment local-wp-wordpress

kubectl describe pod local-wp-wordpress-77858b7665-j2jfb

kubectl expose deploy local-wp-wordpress --type=NodePort --name=local-wp

kubectl describe secret local-wp-wordpress
kubectl get secret local-wp-wordpress -o jsonpath='{.data.wordpress-password}' | base64 -d

kubectl delete pvc data-local-wp-mariadb-0

kubectl create secret generic custom-wp-credentials --from-literal wordpress-password=noahpassword
```
