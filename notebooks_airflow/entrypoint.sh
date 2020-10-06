#!/usr/bin/env bash

#zeppelin 
/zeppelin/bin/zeppelin-daemon.sh start

#airflow start
exec airflow webserver -p 8080 --daemon &
airflow scheduler --daemon &

#jupyter start 
jupyter lab --port=8888 --no-browser --ip=0.0.0.0 --allow-root 
echo "************* fin ? pas normal"