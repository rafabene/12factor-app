#!/bin/bash
kubectl run myapp --image rafabene/myapp -n 12factor-dev --port=8080 --image-pull-policy=IfNotPresent
kubectl expose deployment myapp --port 8080 --type NodePort -n 12factor-dev