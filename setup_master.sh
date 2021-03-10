#!/bin/bash

# Remove OLD Server if available
if [[ -d "master_server" ]]; then
    rm -rf master_server
fi;

# Getting server from github
git clone https://github.com/project-ncloud/master_server.git

# Goto the work dir
cd master_server

# Creating Virtual environment
python -m venv venv

# Activating Venv for installing dependencies
. venv/*/activate

# Installing Dependencies
pip3 install -r requirements.txt

# Deactivate the env and exit
deactivate

# Genarating KEY For master
KEY=$(openssl rand -base64 32)

echo "Enter DATABASE NAME: "  
read DB_NAME

if [[ "$OSTYPE" == "msys" ]]; then
    HOSTNAME="127.0.0.1"
else
    HOSTNAME=$(hostname -I)
fi;

cat > .env <<EOF
STUDENT_CLOUD_KEY=st67hq
FACULTY_CLOUD_KEY=fu19xa
DB_URI_STRING=mongodb://localhost:27017/
DB_NAME=$DB_NAME
USER_COLLECTION=hello
PENDING_USER_COLLECTION=pending_users
ADMIN_COLLECTION=adminConfig
MANAGER_COLLECTION=managers
SERVER_COLLECTION=servers
SECRET_KEY=$KEY
OWN_URL=${HOSTNAME}:5000
PORT=5000
TYPE=dev
RESTRICT_KEYWORD=raspberry_pi_admin
EOF

# Displaying KEY
echo ""
echo ""
echo "Your KEY :: "$KEY
echo ""
echo "NOTE - Make sure you copied this key into safe place for other node installations."