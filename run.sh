#!/bin/bash
source .env
while true
    do curl http://myapp-12factor-dev.$OPENSHIFT_DOMAIN/api/hello/Rafael
    sleep .5
    echo
done