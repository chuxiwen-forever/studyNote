# Docker

### 1.下载docker

docker官网:https://www.docker.com/

> 翻阅文档

**寻找文档：网页最下面寻找Docs**

![](C:\study\docker\1.png)

**选择下载文档**

![](C:\study\docker\2.png)

**选择自己要下载的系统**

![](C:\study\docker\3.png)

**根据自己的需求选择服务器型号**

![](C:\study\docker\4.png)

==文档中有详细的安装方式这里介绍指令==

**因为在安装时踩了很多坑，这里说一下**

~~~
在下载docker前要设置且更新一下yum源，不然会报奇奇怪怪的错误，我的服务器是CentOs7
可能有些指令冗余，但是确实解决问题
~~~

>配置阿里云yum源

~~~shell
####修改插件的配置文件
#拷贝一份配置文件，玩崩了还可以回头
cp /etc/yum/pluginconf.d/fastestmirror.conf /etc/yum/pluginconf.d/fastestmirror.conf.bak 
#编译原始文件，将其中的enabled=1改为0
vi  /etc/yum/pluginconf.d/fastestmirror.conf

####修改yum的配置文件
#拷贝一份文件，还是为了留一条后路
cp /etc/yum.conf /etc/yum.conf.bak
#编译yum源的配置文件 将其中的plugins=1改为0
vi /etc/yum.conf
 
####获取阿里云 repo
#拷贝一份以防后事
cp /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak
#对数据源进行配置
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
#继续copy
cp /etc/yum.repos.d/epel.repo /etc/yum.repos.d/epel.repo.bak
#继续修改配置
wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo

####清理原来的缓存
yum clean all

####建立新的缓存
yum makecache

####对yum包进行更新
yum update
~~~

> 正式安装Docker

~~~shell
####下面指令中 如果是管理员，可以不加sudo
#1.删除老版的docker
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine
                  
#2.安装必要的工具
sudo yum install -y yum-utils

#3.设置yum源(阿里云镜像，下载更快)
sudo yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

#4.下载docker
sudo yum install -y docker-ce

#5.启动docker
sudo systemctl start docker
~~~

**完成！！！**



### docker常用指令(个人而言)

~~~shell
#网上拉取镜像
docker pull 开发软件名称(比如mysql)
#将镜像添加到容器中
docker run
   -d  后台运行
   -p  服务器端口：容器里端口     端口映射
   -v  服务器目录：容器里的目录   卷挂载
   --name 容器名字
   --restart=always  在重启docker时重启容器
#查看日志
docker logs 容器id
#查看下载了什么镜像
docker images
~~~



~~~shell
1. 查看运行中的容器 docker ps
2. 查看所有的容器 docker ps -a
3. 进入容器 docker exec -it 容器ID /bin/bash
4. 停止所有的容器 docker stop $(docker ps -q)
5. 删除所有的容器 docker rm $(docker ps -aq)
6. 停止并删除全部 docker stop $(docker ps -q) & docker rm $(docker ps -aq)
~~~





> 部署redis



~~~shell
# 拉取redis镜像
docker pull redis 

#启动redis
docker run -d --name redis --restart=always -p 6379:6379 \
-v /usr/local/docker/redis/redis.conf:/etc/redis/redis.conf \
-v /usr/local/docker/redis/data:/data \
--requirepass "密码" redis \
redis-server /etc/redis/redis.conf

####指令解释
-v /usr/local/docker/redis.conf:/etc/redis/redis.conf //把宿主机配置好的redis.conf挂载到容器内的指定位置
-v /usr/local/docker/data:/data  //把redis持久化的数据挂载到宿主机内，做数据备份

redis-server /etc/redis/redis.conf  //使redis按照redis.conf的配置启动
~~~



> 部署mysql



~~~shell
# 拉取mysql镜像
docker pull mysql

#启动mysql
docker run -d --name mysql --restart=always -p 3306:3306 \
-v /usr/local/docker/mysql/conf.d:/etc/mysql/conf.d \
-v /usr/local/docker/mysql/my.cnf:/etc/mysql/my.cnf \
-v /usr/local/docker/mysql/data:/var/lib/mysql-files \
-e MYSQL_ROOT_PASSWORD="密码"  mysql


##特别注意
#conf.d  是文件夹
#data  是文件夹
#my.cnf  是文件
#在主机挂载时要注意容器内部结构    一上午的教训！！！
#多看日志  最好的debug工具
~~~

