
``` bash
docker pull couchdb
docker pull eclipse-mosquitto
docker run -p 5984:5984 -e COUCHDB_USER=jarvis -e COUCHDB_PASSWORD=jarvis -d couchdb
docker run -it -p 1883:1883 -p 9001:9001 -d eclipse-mosquitto
```