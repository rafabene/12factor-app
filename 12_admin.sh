#!/bin/bash
echo "Openning a new bash process in the exising application container"
kubectl exec -n12factor-dev  -it `kubectl get pods -n12factor-dev |grep myapp -m 1|awk '{print $1}'` bash
