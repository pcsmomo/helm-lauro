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
kubectl get svc
kubectl get secret
kubectl get deploy

kubectl describe secret local-wp-wordpress
kubectl describe pod local-wp-wordpress-77858b7665-j2jfb

kubectl expose depl

kubectl get secret local-wp-wordpress -o jsonpath='{.data.wordpress-password}' | base64 -d
```
