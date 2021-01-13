# BigChainDB docker安装

## 多节点安装  
### 1.环境准备
```bash
准备三个节点的运行环境
152.136.20.173
49.233.28.200
49.233.38.123
操作系统：Ubuntu 18.04 
```  
### 2.安装工具
```bash
docker:19.03.6
docker-compose:1.18.0
```  
### 3.创建目录
```bash
在每各节点都创建bigchaindb文件夹，如图：这是最终的bigchaindb文件夹结构，现在可以看一下，这些文件会在后面出现
```  
![avatar](./images/picture/total_struct.png)

### 4.docker-compose
```bash
准备docker-compose文件，在bigchaindb目录下创建docker-compose.yml
vim docker-compose.yml
编辑下面内容：
version: '2.1'

services:
  mongodb:
    image: mongo:3.6
    ports:
      - "27017:27017"
    command: mongod
  bigchaindb:
    image: bigchaindb/bigchaindb
    depends_on:
      - mongodb
      - tendermint
    environment:
      BIGCHAINDB_DATABASE_BACKEND: localmongodb
      BIGCHAINDB_DATABASE_HOST: mongodb
      BIGCHAINDB_DATABASE_PORT: 27017
      BIGCHAINDB_SERVER_BIND: 0.0.0.0:9984
      BIGCHAINDB_WSSERVER_HOST: 0.0.0.0
      BIGCHAINDB_WSSERVER_ADVERTISED_HOST: bigchaindb
      BIGCHAINDB_TENDERMINT_HOST: tendermint
      BIGCHAINDB_TENDERMINT_PORT: 26657
    ports:
      - "9984:9984"
      - "9985:9985"
      - "26658:26658"
    healthcheck:
      test: ["CMD", "bash", "-c", "curl http://bigchaindb:9984 && curl http://tendermint:26657/abci_query"]
      interval: 3s
      timeout: 5s
      retries: 3
    #command: 'bigchaindb start'
  tendermint:
    image: tendermint/tendermint:0.22.8
    volumes:
      - ./tmdata:/tendermint
    entrypoint: ''
    ports:
      - "26656:26656"
      - "26657:26657"
    command: sh -c "tendermint init && tendermint node --consensus.create_empty_blocks=false --proxy_app=tcp://bigchaindb:26658"
```  
### 5.下载tendermint
```bash
因为需要使用tendermint来生成配置文件，就是tmdata下的文件。所以需要下载编译好的tendermint二进制文件,因为BigchainDB需要使用的tendermint的0.22.8版本，所以下载0.22.8的二进制文件。
#下载二进制文件
wget https://github.com/tendermint/tendermint/releases/download/v0.22.8/tendermint_0.22.8_linux_amd64.zip
#解压文件
unzip unzip tendermint_0.22.8_linux_amd64.zip
#检查版本
./tendermint version
``` 
### 6.生成多个节点配置信息
```bash
使用tendermint testnet来生成所有节点的配置文件,命令默认生成4个节点的配置文件，如果需要更多节点的配置信息，在tendermint testnet命令后加-v,例:需要生成10个节点配置信息
tendermint testnet -v 3 
修改配置文件，生成的配置文件会在当前文件夹下生成mytestnet文件。目录如图
```  
![avatar](./images/picture/mytestnet.png)  
```bash
将每一个config.toml文件进行修改，修改第93行，如图4：将其中node0-node2中改成对应的ip
```  
![avatar](./images/picture/peer.png)  
```bash
将各个config文件发送到各个节点bigchaindb/tmdata。
scp -r /mytestnet/node0/ ubuntu@xxx.xxx.xxx.xxx:/home/ubuntu/bigchaindb/tmdata
scp -r /mytestnet/node1/ ubuntu@xxx.xxx.xxx.xxx:/home/ubuntu/bigchaindb/tmdata
scp -r /mytestnet/node2/ ubuntu@xxx.xxx.xxx.xxx:/home/ubuntu/bigchaindb/tmdata
```  

### 7.启动
```bash
每个节点都运行sudo docker-compose up -d,使用docker ps查看启动的容器，正常启动会有3个容器。tendermint,mongodb和bigchaindb
``` 
![avatar](./images/picture/docker.png)  
### 8.检查集群启动情况
```bash
访问:http://xxx.xxx.xxx.xxx:26657/abci_info
返回信息如图：块高为1表示成功
``` 
![avatar](./images/picture/query.png)  


