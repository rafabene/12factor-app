#!/bin/bash
echo "Deploying to the staging area"
kubectl create namespace 12factor-staging
kubectl create deployment myapp --image rafabene/myapp:1.0 -n 12factor-staging
kubectl expose deployment myapp --port 8080 --type NodePort -n 12factor-staging
export INGRESS_PORT=$(kubectl -n 12factor-staging get service myapp -o jsonpath='{.spec.ports[0].nodePort}')


url=$1
if [ -z "$url" ]
then
    url="`minikube ip`:$INGRESS_PORT/api/hello/Rafael"
fi

while true
do curl $url
sleep .5
echo
done
