#!/bin/bash
kubectl set env deployment/myapp -n12factor-dev GREETING="Hi {name}! - My Configuration has changed"
echo "Configuration updated. Please check again"
