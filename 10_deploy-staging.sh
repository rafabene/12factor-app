#!/bin/bash
echo "Deploying to the staging area"
kubectl create namespace 12factor-staging
kubectl run myapp --image rafabene/myapp -n 12factor-staging --port=8080 --image-pull-policy=IfNotPresent
kubectl expose deployment myapp --port 8080 --type NodePort -n 12factor-staging
export INGRESS_PORT=$(kubectl -n 12factor-staging get service myapp -o jsonpath='{.spec.ports[0].nodePort}')


url=$1
if [ -z "$url" ]
then
    url="192.168.100.100:$INGRESS_PORT/api/hello/Rafael"
fi

while true
do curl $url
sleep .5
echo
done
