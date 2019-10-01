#!/bin/bash
kubectl scale deployment myapp --replicas=3
echo "App Scaled to three instances"
./run.sh