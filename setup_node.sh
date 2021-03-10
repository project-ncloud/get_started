#!/bin/bash

# Remove OLD Server if available
if [[ -d "node_server" ]]; then
    rm -rf master_server
fi;

# Getting server from github
git clone https://github.com/project-ncloud/node_server.git

# Goto the work dir
cd node_server

# Getting samba package from github
git clone https://github.com/project-ncloud/samba.git

# Creating Virtual environment
python -m venv venv

# Activating Venv for installing dependencies
. venv/*/activate

# Installing Dependencies
pip3 install -r requirements.txt

# Deactivate the env and exit
deactivate

# Genarating KEY For master
echo "Enter Master KEY: "  
read KEY



if [[ "$OSTYPE" == "msys" ]]; then
    HOSTNAME="127.0.0.1"
    CONFIG_FILE="etc/samba/smb.conf"

    # Creating Fake smb.conf for windows
    mkdir -p etc/samba/
    touch etc/samba/smb.conf
else
    HOSTNAME=$(hostname -I)
    CONFIG_FILE="/etc/samba/smb.conf"
fi;

cat > .env <<EOF
CONFIG_FILE=$CONFIG_FILE
SECRET_KEY=$KEY
OWN_URL=${HOSTNAME}:7000
PORT=7000
TYPE=dev
RESTRICT_KEYWORD=raspberry_pi_admin
EOF


echo ""
echo ""
echo "DONE..."
echo ""