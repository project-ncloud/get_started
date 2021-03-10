#!/bin/bash

# Remove OLD Server if available
if [[ -d "node_server" ]]; then
    rm -rf node_server
fi;

# Getting server from github
git clone https://github.com/project-ncloud/node_server.git

# Goto the work dir
cd node_server

# Getting samba package from github
git clone https://github.com/project-ncloud/samba.git

# Creating Virtual environment
if [[ "$OSTYPE" == "msys" ]]; then
    python -m venv venv
else
    python3 -m venv venv
fi;

# Activating Venv for installing dependencies
. venv/*/activate

# Installing Dependencies
pip3 install -r requirements.txt

# Deactivate the env and exit
deactivate

# Genarating KEY For master
echo "Enter Master KEY: "  
read KEY
echo "Enter Admin KEY: "  
read ADMIN_KEY



if [[ "$OSTYPE" == "msys" ]]; then
    HOSTNAME="127.0.0.1"
    CONFIG_FILE="etc/samba/smb.conf"

    # Creating Fake smb.conf for windows
    mkdir -p etc/samba/
    touch etc/samba/smb.conf
else
    HOSTNAME=$(hostname -I | cut -d' ' -f1)
    CONFIG_FILE="/etc/samba/smb.conf"
fi;

# Genarating environment file for node
cat > .env <<EOF
CONFIG_FILE=$CONFIG_FILE
SECRET_KEY=$KEY
OWN_URL=${HOSTNAME}:7000
PORT=7000
TYPE=dev
ADMIN_USER=admin
ADMIN_KEY=$ADMIN_KEY
RESTRICT_KEYWORD=raspberry_pi_$ADMIN_USER
EOF


echo ""
echo "DONE..."
echo ""