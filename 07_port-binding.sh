#!/bin/bash
oc -n 12factor-dev delete svc mysql 
oc -n 12factor-dev expose deployment mysql --port 5000  --target-port 3306
oc -n 12factor-dev get svc mysql -o yaml
oc -n 12factor-dev set env deployment myapp port=5000
echo "Database port 3306 was bound to port 5000"
echo "Test the database connection"
