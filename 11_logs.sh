#!/bin/bash
kubectl logs -n12factor-dev `kubectl get pods -n 12factor-dev |grep myapp| awk '{ print $1 }'`
