## 1. Installing

The preferred option is that you compile yourself.
The second option is that you utilize the provided jar, 
which is released whenever there is a new update here: [Github Releases](https://github.com/trias-lab/iri/releases).

### 1.2 Running yourself
Make sure to have Maven and Java 8 installed on your computer.
#### 1.2.1 How to run one  streamnet service node

```bash  
git clone https://github.com/triasteam/StreamNet.git
cd StreamNet/scripts/examples/one_node/
./conflux_dag.sh
cd StreamNet/scripts/front_end/server
./run_go.sh
```  
#### 1.2.2 How to run docker  
Make sure to have docker-ce 18+ installed on your computer.  

start iota service
```  
cd StreamNet/
1.build image
docker build -t ${NAME}:${TAG} .
其中${NAME}为镜像名字,${TAG}为镜像标签

2.start container
sudo docker run -itd --net=host  --name ${IOTANAME} -v  ${DATAPATH}:/iri/data -v  ${CONFFILE}:/iri/conf/neighbors ${NAME}:${TAG} /entrypoint.sh
其中第一个${IOTANAME}为启动docker的名字,${DATAPATH}为数据挂载目录,${CONFFILE}为配置文件，主要用于neighbor node配置,单个节点,${NAME}为镜像名字，${TAG}为镜像标签
```

start go service 
```  
1.build image
cd StreamNet/scripts/front_end
sudo docker build -t ${NAME}:${TAG}  -f  go_docker/Dockerfile .
其中${NAME}为镜像名字,${TAG}为镜像标签
2.start container
sudo  docker run -itd --net=host -e "HOST_IP=127.0.0.1" --name  ${GONAME}  ${NAME}:${TAG}
其中第一个${GONAME}为启动docker的名字，${NAME}为镜像名字，${TAG}为镜像标签
```

## 2. MISC

### 2.1 Performance Tunning 

Please refere [[Performance tunning]](https://github.com/triasteam/iri/blob/dev/scripts/iota\_perf/README.md) for details of how to measure performance using Nginx + Jmeter. 

### 2.2 Cluster deployment 

Please refer [[Cluster deployment]](https://github.com/triasteam/iri/blob/dev/scripts/examples/cluster/README.md) for details of how to deploy multiple nodes.

### 2.3 Frontend deployment

Please refer [[Frontend deployment]](https://github.com/triasteam/StreamNet/blob/dev/scripts/front_end/README.md) for details of how to deploy the frontend

### 2.4 Portainer deployment 

Please refer [[Portainer deployment]](https://github.com/triasteam/StreamNet/blob/dev/document/iota_deploy/portainer-deploy-info.md) for details of how to leverage the portainer to manage containers

## 3  Team

[Zhaoming Yin](https://stplaydog.github.io/), [Junqing Wang](https://wunder3605.github.io/), [Yahui Wang](https://wangyh2016.github.io/wangyahui.github.io/), [Haifeng Li](https://lihaifeng111.github.io/lihaifeng.github.io/), [Huafeng Li](https://lhfbc.github.io/)
