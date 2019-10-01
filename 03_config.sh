#!/bin/bash
kubectl set env deployment/myapp GREETING="Hi {name}! - My Configuration has changed"
echo "Configuration updated. Please check again"
