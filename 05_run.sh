#!/bin/bash
kubectl create deployment myapp --image rafabene/myapp:1.0 -n 12factor-dev
kubectl -n 12factor-dev patch deployment myapp -p '{"spec":{"template":{"spec":{"containers":[{"name":"myapp", "imagePullPolicy":"IfNotPresent"}]}}}}'
kubectl expose deployment myapp --port 8080 --type NodePort -n 12factor-dev