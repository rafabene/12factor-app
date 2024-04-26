#!/bin/bash
source .env
oc -n 12factor-dev create deployment myapp --image quay.io/$QUAY_USER/my12factorapp:1.0 
oc -n 12factor-dev patch deployment myapp -p '{"spec":{"template":{"spec":{"containers":[{"name":"myapp", "imagePullPolicy":"IfNotPresent", "readinessProbe":{"httpGet":{"path": "/api/health", "port":8080, "initialDelaySeconds":1, "periodSeconds": 1}}}]}}}}'
oc -n 12factor-dev expose deployment myapp --port 8080 --type NodePort 
oc -n 12factor-dev expose service myapp