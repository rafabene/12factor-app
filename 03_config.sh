#!/bin/bash
oc -n 12factor-dev set env deployment/myapp  GREETING="Hi {name}! - My Configuration has changed"
echo "Configuration updated. Please check again"
