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
RUN apt-get update && apt-get -y upgrade

# 安装java环境
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
RUN apt-get update && \
    apt-get install -y --no-install-recommends software-properties-common && \
    add-apt-repository ppa:webupd8team/java && \
    apt-get update && \
    apt-get install -y --no-install-recommends oracle-java8-installer && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get -y install python-dev && apt-get -y install python3-pip && apt-get -y install psutils
RUN apt-get -y install mongodb && pip3 -y install pymongo && pip3 -y install pymysql && \
    pip3 install tornado && pip3 install lxml && \
    pip3 install twisted && pip3 install bs4 && apt-get -y autoremove


EXPOSE 8000
EXPOSE 8080
EXPOSE 3306
EXPOSE 27017
EXPOSE 8888

ENTRYPOINT ["/bin/bash"]
