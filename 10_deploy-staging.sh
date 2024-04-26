#!/bin/bash
source .env
echo "Deploying to the staging area"
oc new-project  12factor-staging
oc -n 12factor-staging create deployment myapp --image quay.io/$QUAY_USER/my12factorapp:1.0 
oc -n 12factor-staging patch deployment myapp -p '{"spec":{"template":{"spec":{"containers":[{"name":"myapp", "imagePullPolicy":"IfNotPresent", "readinessProbe":{"httpGet":{"path": "/api/health", "port":8080, "initialDelaySeconds":1, "periodSeconds": 1}}}]}}}}'
oc -n 12factor-staging expose deployment myapp --port 8080 --type NodePort 
oc -n 12factor-staging expose service myapp

#!/bin/bash
source .env
while true
    do curl http://myapp-12factor-staging.$OPENSHIFT_DOMAIN/api/hello/Rafael
    sleep .5
    echo
done
