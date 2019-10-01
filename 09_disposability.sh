#!/bin/bash
echo "Destroying two processes"
kubectl delete pod `kubectl get pods | grep myapp -m 2| awk '{ print $1 }'` --grace-period 0 --force
./run.sh