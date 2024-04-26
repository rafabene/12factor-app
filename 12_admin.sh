#!/bin/bash
echo "Openning a new bash process in the exising application container"
oc exec -n 12factor-dev  -it `oc get pods -n12factor-dev |grep myapp -m 1|awk '{print $1}'` -- bash
