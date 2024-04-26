#!/bin/bash
echo QUAY_USER="rafabene1006" > .env
echo OPENSHIFT_DOMAIN="apps.cluster-dj2hg.dynamic.redhatworkshops.io" >> .env
#podman machine stop && podman machine start
oc new-project  12factor-dev
#podman login quay.io
