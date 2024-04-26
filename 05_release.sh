#!/bin/bash
source .env
podman build --arch amd64 -t quay.io/$QUAY_USER/my12factorapp:1.0 .
podman push quay.io/$QUAY_USER/my12factorapp:1.0