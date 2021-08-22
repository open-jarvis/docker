set -x


install () {
    MACHINE_TYPE=`uname -m`
    if [ "${MACHINE_TYPE}" == "x86_64" ]; then
        seed_couchdb

        install_64_bit
    else
        install_32_bit
    fi
}

install_64_bit () {
    # couchdb installation
    apt update
    apt install -y wget apt-transport-https gnupg2
    wget -qO - https://couchdb.apache.org/repo/keys.asc | apt-key add -
    echo "deb https://apache.jfrog.io/artifactory/couchdb-deb/ focal main" | tee /etc/apt/sources.list.d/couchdb.list >/dev/null
    apt update --allow-unauthenticated
    apt install -y couchdb

    # jarvis python installation
    apt update
    apt install -y python3 python3-pip
    python3 -m pip install -e /jarvis/pip
    python3 -m pip install -e /jarvis/sdk
    python3 -m pip install --upgrade websockets snips_nlu psutil markdown

    python3 -m snips_nlu download en
    python3 -m snips_nlu download de

    # jarvis webui installation
    python3 -m pip install --upgrade flask flask_babel

    # create a startup file
    echo "service couchdb stop" > /starter
    echo "service couchdb start" >> /starter
    echo "kill -9 \`pidof python3\`" >> /starter 
    echo "python3 /jarvis/server/jarvisd.py &" >> /starter
    echo "python3 /jarvis/web/html/webui.py &" >> /starter
    chmod a+x /starter
}

install_32_bit () {
    echo "32 Bit not supported yet!"
}

seed_couchdb () {
    cp /usr/share/zoneinfo/Europe/Paris /etc/localtime
    cp /usr/share/zoneinfo/$(wget -qO - http://geoip.ubuntu.com/lookup | sed -n -e "s/.*<TimeZone>\(.*\)<\/TimeZone>.*/\1/p") /etc/localtime
    export DEBIAN_FRONTEND=noninteractive

    echo "Name: couchdb/adminpass
Template: couchdb/adminpass
Value: jarvis
Owners: couchdb
Flags: seen

Name: couchdb/adminpass_again
Template: couchdb/adminpass_again
Value: jarvis
Owners: couchdb
Flags: seen">>/var/cache/debconf/passwords.dat

    echo "Name: couchdb/adminpass_mismatch
Template: couchdb/adminpass_mismatch
Owners: couchdb

Name: couchdb/bindaddress
Template: couchdb/bindaddress
Value: 0.0.0.0
Owners: couchdb
Flags: seen

Name: couchdb/cookie
Template: couchdb/cookie
Owners: couchdb

Name: couchdb/error_setting_password
Template: couchdb/error_setting_password
Owners: couchdb

Name: couchdb/have_1x_databases
Template: couchdb/have_1x_databases
Owners: couchdb

Name: couchdb/mode
Template: couchdb/mode
Value: standalone
Owners: couchdb
Flags: seen

Name: couchdb/nodename
Template: couchdb/nodename
Owners: couchdb

Name: couchdb/postrm_remove_databases
Template: couchdb/postrm_remove_databases
Owners: couchdb">>/var/cache/debconf/config.dat 
}


install