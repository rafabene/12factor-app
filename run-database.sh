#!/bin/bash
source .env
while true
    do curl http://myapp-12factor-dev.$OPENSHIFT_DOMAIN/api/db
    sleep .5
    echo
done