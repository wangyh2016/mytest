#!/bin/bash

SCRIPTPATH=$(cd "$(dirname "$0")"; pwd)
NAME=stream-iota
TAG=v0.1

rm -rf data
rm -rf conf
mkdir data
mkdir conf
touch conf/neighbors
filename="conf/neighbors"
cat>"${filename}"<<EOF
tcp://172.31.19.240:13700
tcp://172.31.18.190:13700
tcp://172.31.17.120:13700
tcp://172.31.22.246:13700
tcp://172.31.30.122:13700
EOF
cd ../../
docker build -t ${NAME}:${TAG} .
sudo docker run -itd --net=host  --name ${NAME} -v ${SCRIPTPATH}/data:/iri/data -v ${SCRIPTPATH}/conf/neighbors:/iri/conf/neighbors ${NAME}:${TAG} /entrypoint.sh

CLINAME=stream-go
cd scripts/front_end
docker build -t ${CLINAME}:${TAG} -f  go_docker/Dockerfile  .
sudo  docker run -itd --net=host -e "HOST_IP=127.0.0.1" --name  ${CLINAME}  ${CLINAME}:${TAG}
