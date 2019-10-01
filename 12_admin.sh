#!/bin/bash
echo "Openning a new bash process in the exising application container"
kubectl exec -it `kubectl get pods |grep myapp -m 1|awk '{print $1}'` bash
