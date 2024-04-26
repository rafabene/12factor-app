#!/bin/bash
echo "Deploying a database"
oc -n 12factor-dev create deployment mysql  --image=mysql:5.6 
oc -n 12factor-dev set env deployment mysql -e MYSQL_DATABASE=mydatabase -e MYSQL_USER=myuser -e MYSQL_PASSWORD=mypassword -e MYSQL_ROOT_PASSWORD=mypassword
oc -n 12factor-dev set env deployment myapp -e host=mysql -e  username=myuser -e  password=mypassword -e database=mydatabase -e GREETING-
oc -n 12factor-dev expose deployment mysql  --port 3306

