#!/bin/bash
kubectl delete svc mysql -n12factor-dev 
kubectl expose deployment -n12factor-dev mysql --port 5000  --target-port 3306
kubectl get -n12factor-dev svc mysql -o yaml
kubectl set env -n12factor-dev  deployment myapp port=5000
echo "Database port 3306 was bound to port 5000"
echo "Test the database connection"
