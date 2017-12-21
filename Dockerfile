# version1.0
FROM ubuntu:latest
LABEL maintainer='tiankangbo'
# 更换apt源为阿里源
RUN echo "deb http://mirrors.aliyun.com/ubuntu/ xenial main restricted universe multiverse " > /etc/apt/sources.list
RUN echo "deb http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.aliyun.com/ubuntu/ xenial-proposed main restricted universe multiverse" >> /etc/apt/sources.list

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

RUN apt-get -y install python-dev python3-pip psutils mongodb
RUN pip3 -y install pymongo  pymysql tornado lxml twisted bs4 && apt-get -y autoremove


EXPOSE 8000
EXPOSE 8080
EXPOSE 3306
EXPOSE 27017
EXPOSE 8888

ENTRYPOINT ["/bin/bash"]
