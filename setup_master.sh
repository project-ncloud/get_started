#!/bin/bash

getJSON (){
    echo "\"$1\" : \"$2\","
}
getBooleanJSON (){
    echo "\"$1\" : $2,"
}

# Remove OLD Server if available
if [[ -d "master_server" ]]; then
    rm -rf master_server
fi;

# Getting server from github
git clone https://github.com/project-ncloud/master_server.git

# Goto the work dir
cd master_server

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
KEY=$(openssl rand -base64 32)

echo "Enter DATABASE NAME: "  
read DB_NAME

echo "Enter ADMIN KEY: "  
read ADMIN_KEY

if [[ "$OSTYPE" == "msys" ]]; then
    HOSTNAME="127.0.0.1"
else
    HOSTNAME=$(hostname -I)
fi;

# Genarating environment file for master
cat > .env <<EOF
STUDENT_CLOUD_KEY=st67hq
FACULTY_CLOUD_KEY=fu19xa
DB_URI_STRING=mongodb://localhost:27017/
DB_NAME=$DB_NAME
USER_COLLECTION=users
PENDING_USER_COLLECTION=pending_users
ADMIN_COLLECTION=admin_config
MANAGER_COLLECTION=managers
SERVER_COLLECTION=servers
SECRET_KEY=$KEY
OWN_URL=${HOSTNAME}:5000
PORT=5000
TYPE=dev
RESTRICT_KEYWORD=raspberry_pi_admin
EOF

# Database Setup
echo -e "\
 use $DB_NAME\n \
 db.dropDatabase()\n \
 use $DB_NAME\n \
 db.createCollection(\"users\")\n \
 db.createCollection(\"pending_users\")\n \
 db.createCollection(\"managers\")\n \
 db.createCollection(\"servers\")\n \
 db.createCollection(\"admin_config\")\n \
 db.admin_config.insertOne({\
 $(getJSON "name" "admin")\
 $(getJSON "key" "$ADMIN_KEY")\
 $(getBooleanJSON "addall_inNewHosts" "false")\
 $(getBooleanJSON "autoStartSrvr" "false")\
 $(getBooleanJSON "allowRegistration" "true")\
 $(getBooleanJSON "pendingNewUser" "true")\
 })" | mongo redirect

# Displaying KEY
echo ""
echo "Your SECRET KEY :: "$KEY
echo "Your ADMIN KEY  :: "$ADMIN_KEY
echo ""
echo "NOTE - Make sure you copied those key into safe place for other node installations."

cd ..

# Saving key into a file
if [[ -f "secret.keys" ]]; then
    rm -rf secret.keys
fi;
touch secret.keys
echo -e "\
Your SECRET KEY :: ${KEY}\n\
Your ADMIN KEY  :: ${ADMIN_KEY}\n" >> secret.keys
echo "Your KEY is saved into ${pwd}/secret.keys"