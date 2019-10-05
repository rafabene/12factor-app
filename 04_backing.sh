#!/bin/bash
echo "Deploying a database"
kubectl run mysql -n 12factor-dev --image=mysql:5.6 --env MYSQL_DATABASE=mydatabase --env MYSQL_USER=myuser --env MYSQL_PASSWORD=mypassword --env MYSQL_ROOT_PASSWORD=mypassword
kubectl expose deployment mysql -n12factor-dev  --port 3306
echo "Attach it to the app"
kubectl set env deployment myapp -n12factor-dev  host=mysql username=myuser password=mypassword database=mydatabase GREETING-

