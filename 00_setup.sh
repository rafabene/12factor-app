#!/bin/bash
kubectl create namespace 12factor-dev
kubectl config set-context $(kubectl config current-context) --namespace=12factor-dev
echo "Execute eval \$(minikube -p demo docker-env)"
