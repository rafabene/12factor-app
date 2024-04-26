#!/bin/bash
echo "Destroying two processes"
oc -n 12factor-dev  delete pod `oc get pods -n12factor-dev | grep myapp -m 2| awk '{ print $1 }'` --grace-period 0 --force
./run.sh