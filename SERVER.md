# Docker Jarvis Server

Docker Container for Jarvis Server and Web App

## Developers

To reproduce the server container run the following commands:

``` bash
docker run -it --name "jarvis" -t debian /bin/bash

set -x

apt update
apt install --no-install-recommends -y git curl wget python3 python3-pip mosquitto python3-paho-mqtt sudo gnupg2

pip3 install --upgrade --no-deps open-jarvis requests packaging urllib3 chardet certifi idna markdown importlib_metadata zipp typing_extensions

wget http://packages.erlang-solutions.com/debian/erlang_solutions.asc
apt-key add erlang_solutions.asc
apt update

# @@@@@@@@@@@@@@@@   ADM64   @@@@@@@@@@@@@@@@@@@@@
    1  apt update ; apt install -y python3 python3-pip
    2  echo "deb https://apache.bintray.com/couchdb-deb buster main" | tee -a /etc/apt/sources.list
    3  apt install curl
    4  curl -L https://couchdb.apache.org/repo/bintray-pubkey.asc | apt-key add -
    5  apt updaet
    6  apt update
    7  apt install couchdb
    8  apt install mosquitto python3-paho-mqtt git
    9  couchdb
   10  service status couchdb
   11  service couchdb status
   12  service couchdb start
   13  service couchdb status
   14  service mosquitto status
   15  service mosquitto start
   16  service mosquitto status
   17  history
   18  pip3 install --upgrade --no-deps open-jarvis requests packaging urllib3 chardet certifi idna markdown importlib_metadata zipp typing_extensions
   19  pip3 install --upgrade --no-deps open-jarvis requests packaging urllib3 chardet certifi idna markdown importlib_metadata zipp typing_extensions cryptography rsa paho.mqtt couchdb2 snips_nlu
   20  pip3 install --upgrade --no-deps open-jarvis requests packaging urllib3 chardet certifi idna markdown importlib_metadata zipp typing_extensions cryptography rsa couchdb2 snips_nlu
   21  python3 -m pip install --upgrade pip
   22  pip3 install --upgrade --no-deps open-jarvis requests packaging urllib3 chardet certifi idna markdown importlib_metadata zipp typing_extensions cryptography rsa couchdb2 snips_nlu
   23  exit
   24  ls
   25  history
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# @@@@@@@@@@@@@@@@   ADM64   @@@@@@@@@@@@@@@@@@@@@
# curl -L https://couchdb.apache.org/repo/bintray-pubkey.asc   | sudo apt-key add -
# echo "deb https://apache.bintray.com/couchdb-deb focal main" >> /etc/apt/sources.list
# apt update
# apt install apache2 couchdb -y
# echo "jarvis = jarvis" >> /opt/couchdb/etc/local.ini
# pip3 install snips_nlu
# pip3 install couchdb2
# echo "service couchdb start" > /starter
# echo "service mosquitto start" >> /starter
# service couchdb start
# curl -X PUT http://admin:admin@127.0.0.1:5984/_node/couchdb@127.0.0.1/_config/admins/jarvis -d '"jarvis"'
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@



# @@@@@@@@@@@@@@@@   ARMHF   @@@@@@@@@@@@@@@@@@@@@
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
echo "jarvis = jarvis" >> $COUCHDB_DIR/etc/local.ini

# change access rights
sudo chmod 666 $COUCHDB_DIR/etc/local.ini

apt install --no-install-recommends -y libatlas3-base libgfortran5 python3-dev
pip3 install setuptools wheel

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

mkdir /usr/local/lib/python3.7/dist-packages/couchdb2
echo "from .couchdb2 import *" > /usr/local/lib/python3.7/dist-packages/couchdb2/__init__.py
wget https://github.com/pekrau/CouchDB2/blob/master/couchdb2.py?raw=true -O /usr/local/lib/python3.7/dist-packages/couchdb2/couchdb2.py
# mkdir /usr/local/lib/python3.6/dist-packages/couchdb2
# echo "from .couchdb2 import *" > /usr/local/lib/python3.6/dist-packages/couchdb2/__init__.py
# wget https://github.com/pekrau/CouchDB2/blob/master/couchdb2.py?raw=true -O /usr/local/lib/python3.6/dist-packages/couchdb2/couchdb2.py

/home/couchdb/bin/couchdb &

echo "/home/couchdb/bin/couchdb &" > /starter
echo "/usr/sbin/mosquitto &" >> /starter
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

sudo snips-nlu download de
sudo snips-nlu download en

# INSTALLING JARVIS SERVER
git clone https://github.com/open-jarvis/server
cd server
python3 setup.py --blind

echo "/bin/sleep 3" >> /starter
echo "/usr/bin/python3 /jarvis/server/jarvisd.py &" >> /starter

# INSTALLING JARVIS WEB
cd /jarvis/web
git clone https://github.com/open-jarvis/web .
pip3 install flask flask_babel

echo "/usr/bin/python3 /jarvis/web/html/webui.py &" >> /starter
echo "/bin/sleep infinity" >> /starter

chmod a+x /starter

kill `pidof beam.smp`

# clean up
rm -rf /root/.cache/*
rm -rf /root/*.whl
rm -rf /apache-couchdb-3.1.1* /erlang_solutions.asc /*.deb

# apt install --no-install-recommends wajig
# CHECK LARGE PACKAGES
# apt purge wajig

dpkg --purge libgl1-mesa-dri adwaita-icon-theme git libgtk2.0-common libwxgtk3.0-0v5 libgtk2.0-0 wget fonts-dejavu-core libglib2.0-0 make libx11-data curl
apt clean
apt autoremove -y
rm -rf /usr/share/fonts
```

