# version1.0
FROM ubuntu:latest

LABEL maintainer='tiankangbo'

# 更换apt源为阿里源
RUN echo "deb http://mirrors.aliyun.com/ubuntu/ xenial main restricted universe multiverse " > /etc/apt/sources.list
RUN echo "deb http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.aliyun.com/ubuntu/ xenial-proposed main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "171.8.242.176 mirrors.aliyun.com" >> /etc/hosts
RUN echo "192.30.255.112 github.com" >> /etc/hosts
RUN echo "151.101.72.162 registry.npmjs.org" >>/etc/hosts
RUN echo "52.84.49.187 deb.nodesource.com" >>/etc/hosts
RUN apt-get update && apt-get -y upgrade

# 安装nodejs
RUN apt-get update
RUN apt-get install -y nodejs
RUN apt-get install -y nodejs-legacy
RUN apt-get update && apt-get install -y npm

# 更新npm镜像源，提速下载
RUN npm config set registry https://registry.npm.taobao.org
RUN npm config list

# 安装git
RUN apt-get install -y git

# 加载tty.js
RUN apt-get install -y build-essential
RUN npm install -g node-gyp
RUN cd /root && git clone https://github.com/chjj/tty.js.git

# 进入tty.js文件夹
RUN cd /root/tty.js && npm install

RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections

RUN apt-get update && \
    apt-get install -y --no-install-recommends software-properties-common && \
    add-apt-repository ppa:webupd8team/java && \
    apt-get update && \
    apt-get install -y --no-install-recommends oracle-java8-installer && \
    rm -rf /var/lib/apt/lists/* && mkdir /usr/test

EXPOSE 8080
#ENTRYPOINT ["/bin/bash && nohup /root/tty.js/bin/tty.js &", "--daemonize"]
ENTRYPOINT ["cd","/usr/test"]
