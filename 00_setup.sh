#!/bin/bash
kubectl create namespace 12factor-dev
kubectl config set-context $(kubectl config current-context) --namespace=12factor-dev
echo "Execute 'export DOCKER_HOST=tcp://192.168.100.100:2375'"
