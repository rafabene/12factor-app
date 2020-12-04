#!/bin/bash
export INGRESS_PORT=$(kubectl -n 12factor-dev get service myapp -o jsonpath='{.spec.ports[0].nodePort}')


url=$1
if [ -z "$url" ]
then
    url="`minikube ip`:$INGRESS_PORT/api/db"
fi

while true
do curl $url
sleep .5
echo
done