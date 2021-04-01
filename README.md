# Jarvis Docker

This repository contains Docker compose files for an easy installation of Jarvis services

## Docker Images
* [Jarvis Server](server)
* [Jarvis Web UI](web)


### For Developers

To reproduce the docker container, run the following commands:

``` bash
docker run -it -p 5984:5984 -p 2021:2021 -p 1883:1883 -p 80:80 -v /jarvis/docker-couchdb-data:/opt/couchdb/data -t debian /bin/bash

apt update
apt install -y git curl wget python3 python3-pip mosquitto python3-paho-mqtt sudo

pip3 install --upgrade --no-deps open-jarvis pyOpenSSL couchdb2

wget http://packages.erlang-solutions.com/debian/erlang_solutions.asc
apt-key add erlang_solutions.asc
apt update


# Download libffi6
wget http://ftp.br.debian.org/debian/pool/main/libf/libffi/libffi6_3.2.1-6_armhf.deb

# Download the libmozjs185-1.0
wget http://ftp.ro.debian.org/debian/pool/main/m/mozjs/libmozjs185-1.0_1.8.5-1.0.0+dfsg-6_armhf.deb

# Download the libmozjs185-dev
wget http://ftp.br.debian.org/debian/pool/main/m/mozjs/libmozjs185-dev_1.8.5-1.0.0+dfsg-6_armhf.deb


# Install libffi6
sudo dpkg -i libffi6_3.2.1-6_armhf.deb 

# Sometimes the dpkg breaks packages
apt --fix-broken install -y

# Install libmozjs185-1.0
dpkg -i libmozjs185-1.0_1.8.5-1.0.0+dfsg-6_armhf.deb 

# Sometimes the dpkg breaks packages
apt --fix-broken install -y

# Install libmozjs185-dev
dpkg -i libmozjs185-dev_1.8.5-1.0.0+dfsg-6_armhf.deb 

# Fix eventual missing dependencies
apt --fix-broken install -y

apt --no-install-recommends -y install build-essential pkg-config erlang libicu-dev libcurl4-openssl-dev


# create couchdb user and directories
COUCHDB_DIR=/home/couchdb
sudo useradd -d $COUCHDB_DIR couchdb
sudo mkdir $COUCHDB_DIR
sudo chown couchdb:couchdb $COUCHDB_DIR
sudo chmod 1777 $COUCHDB_DIR
sudo mkdir $COUCHDB_DIR/logs
sudo touch $COUCHDB_DIR/logs/stdout.log
sudo touch $COUCHDB_DIR/logs/stderr.log

wget https://mirror.klaus-uwe.me/apache/couchdb/source/3.1.1/apache-couchdb-3.1.1.tar.gz
tar zxvf apache-couchdb-3.1.1.tar.gz
cd apache-couchdb-3.1.1

# configure build and make executable(s)
./configure
make release

# copy built release to couchdb user home directory
cd ./rel/couchdb/
sudo cp -Rp * $COUCHDB_DIR
sudo chown -R couchdb:couchdb $COUCHDB_DIR
cd $COUCHDB_DIR/etc

# change access rights
sudo chmod 666 $COUCHDB_DIR/etc/local.ini

```