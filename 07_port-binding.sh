#!/bin/bash
ubectl delete svc mysql
kubectl expose deployment mysql --port 5000  --target-port 3306
kubectl get svc mysql -o yaml
kubectl set env deployment myapp port=5000
echo "Database port 3306 was bound to port 5000"
echo "Test the database connection"
