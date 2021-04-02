# Jarvis Docker

This repository contains Docker files for an easy installation of Jarvis services

## Installation

```bash
git clone https://github.com/open-jarvis/docker
cd docker
docker build -t jarvis:latest .
docker run -d --restart unless-stopped -p 80:80 -p 1883:1883 -p 2021:2021 -p 5984:5984 -v /jarvis-data:/home/couchdb/data jarvis:latest
```


### For Developers

To reproduce the docker container, run the following commands:

``` bash
docker run -it -t debian /bin/bash

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

apt install libatlas3-base libgfortran5

cd /root
wget --content-disposition https://github.com/jr-k/snips-nlu-rebirth/blob/master/wheels/scipy-1.3.3-cp37-cp37m-linux_armv7l.whl?raw=true
wget --content-disposition https://github.com/jr-k/snips-nlu-rebirth/blob/master/wheels/scikit_learn-0.22.1-cp37-cp37m-linux_armv7l.whl?raw=true
wget --content-disposition https://github.com/jr-k/snips-nlu-rebirth/blob/master/wheels/snips_nlu_utils-0.9.1-cp37-cp37m-linux_armv7l.whl?raw=true
wget --content-disposition https://github.com/jr-k/snips-nlu-rebirth/blob/master/wheels/snips_nlu_parsers-0.4.3-cp37-cp37m-linux_armv7l.whl?raw=true
wget --content-disposition https://github.com/jr-k/snips-nlu-rebirth/blob/master/wheels/snips_nlu-0.20.2-py3-none-any.whl?raw=true

sudo pip3 install scipy-1.3.3-cp37-cp37m-linux_armv7l.whl
sudo pip3 install scikit_learn-0.22.1-cp37-cp37m-linux_armv7l.whl
sudo pip3 install snips_nlu_utils-0.9.1-cp37-cp37m-linux_armv7l.whl
sudo pip3 install snips_nlu_parsers-0.4.3-cp37-cp37m-linux_armv7l.whl
sudo pip3 install snips_nlu-0.20.2-py3-none-any.whl

sudo snips-nlu download de
sudo snips-nlu download en

mkdir /usr/local/lib/python3.7/dist-packages/couchdb2
echo "from .couchdb2 import *" > /usr/local/lib/python3.7/dist-packages/couchdb2/__init__.py
wget https://github.com/pekrau/CouchDB2/blob/master/couchdb2.py?raw=true -O /usr/local/lib/python3.7/dist-packages/couchdb2/couchdb2.py

/home/couchdb/bin/couchdb &

# THIS IS WHERE WE PULL STUFF FROM THE 
# JARVIS REPOS

git clone https://github.com/open-jarvis/server
cd server
python3 setup.py

echo "/home/couchdb/bin/couchdb &" > /starter
echo "/usr/sbin/mosquitto &" >> /starter
echo "/bin/sleep 3" >> /starter
echo "/usr/bin/python3 /jarvis/server/jarvisd.py &" >> /starter

cd /jarvis/web
git clone https://github.com/open-jarvis/web .
pip3 install flask flask_babel

echo "/usr/bin/python3 /jarvis/web/html/webui.py &" >> /starter

chmod a+x /starter
```