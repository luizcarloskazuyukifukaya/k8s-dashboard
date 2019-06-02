#!/bin/bash

# create Service Account
kubectl create -f create-admin-sa.yaml

# create RBAC role binding
kubectl create -f create-admin-rb.yaml

# list all Service Account for all namespaces
kubectl get serviceaccount --all-namespaces

# list all cluster role bindings
kubectl get clusterrolebindings --all-namespaces

# get token to login to the dashboard
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep admin-user | awk '{print $1}')

echo "You need to grab the token from 'token:' section"

# Install dashboard
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml

kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/influxdb/heapster.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/influxdb/influxdb.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/rbac/heapster-rbac.yaml

# run proxy
echo "Now you should run the kubectl proxy and access localhost:8001"
echo "http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/login"

# 
echo "Done!"


