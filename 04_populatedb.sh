#!/bin/bash
kubectl exec -n12factor-dev  -it `kubectl get pods -n 12factor-dev |grep mysql| awk '{ print $1 }'` -- bash -c "mysql -u myuser -pmypassword -h 127.0.0.1 mydatabase -te \"CREATE TABLE mytable (name varchar(50)); INSERT INTO mytable VALUES ('Rafael'); INSERT INTO mytable VALUES ('Benevides');\""
echo "Database populated"
