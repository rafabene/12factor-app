#!/bin/bash
echo "Deploying a database"
kubectl create deployment mysql -n 12factor-dev --image=mysql:5.6 
kubectl -n 12factor-dev set env deployment mysql -e MYSQL_DATABASE=mydatabase -e MYSQL_USER=myuser -e MYSQL_PASSWORD=mypassword -e MYSQL_ROOT_PASSWORD=mypassword
kubectl -n 12factor-dev set env deployment myapp -e host=mysql -e  username=myuser -e  password=mypassword -e database=mydatabase -e GREETING-
kubectl -n 12factor-dev expose deployment mysql  --port 3306
echo "Attach it to the app"


