#!/bin/bash
kubectl logs `kubectl get pods -n 12factor-dev |grep myapp| awk '{ print $1 }'`
