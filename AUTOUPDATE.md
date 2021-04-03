# Docker Jarvis Autoupdate

TODO

## Developers

To reproduce the server container run the following commands:

```bash
docker run -it -v "/jarvis:/jarvis" -p "5984:5984" -p "1883:1883" -t debian /bin/bash

# install data
apt update
apt install -y python3 python3-pip python3-paho-mqtt git wget
pip3 install --upgrade --no-deps open-jarvis requests packaging urllib3 chardet certifi idna

# install couchdb2
mkdir /usr/local/lib/python3.7/dist-packages/couchdb2
echo "from .couchdb2 import *" > /usr/local/lib/python3.7/dist-packages/couchdb2/__init__.py
wget https://github.com/pekrau/CouchDB2/blob/master/couchdb2.py?raw=true -O /usr/local/lib/python3.7/dist-packages/couchdb2/couchdb2.py

# create folder and clone contents
mkdir /autoupdate
cd /autoupdate
git clone https://github.com/open-jarvis/autoupdate .

# create starter file
echo "/usr/bin/python3 /autoupdate/updater.py" > /starter 
chmod a+x /starter


# remove data
apt purge -y python3-pip wget
apt clean
apt autoremove -y
```