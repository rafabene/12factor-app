#!/bin/bash
oc logs -n 12factor-dev -f `oc get pods -n 12factor-dev |grep myapp| awk '{ print $1 }'`
