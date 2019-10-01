#!/bin/bash
export INGRESS_PORT=$(kubectl -n 12factor-dev get service myapp -o jsonpath='{.spec.ports[0].nodePort}')


url=$1
if [ -z "$url" ]
then
    url="192.168.100.100:$INGRESS_PORT/api/db"
fi

while true
do curl $url
sleep .5
echo
done