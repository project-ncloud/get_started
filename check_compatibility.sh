#!/bin/bash

check_win_package() {
    POTH=$1
    NAME=$2
    if [[ -d $POTH ]]; then
        echo -e "\033[1;32mInstalled\t$NAME\033[0m"
    else
        echo -e "\033[1;31mNot Installed\t$NAME\033[0m"
    fi;
}

check_env_package() {
    STR=$1
    NAME=$2
    if echo "$PATH" | grep -q "$STR"; then
        echo -e "\033[1;32mInstalled\t$NAME\033[0m"
    else
        echo -e "\033[1;31mNot Installed\t$NAME\033[0m"
    fi
}

check_unix_package() {
    PACKAGE=$1
    NAME=$2
    dpkg -s $PACKAGE > /dev/null 2>&1

    if [[ $? == 0 ]]; then
        echo -e "\033[1;32mInstalled\t$NAME\033[0m"
    else
        echo -e "\033[1;31mNot Installed\t$NAME\033[0m"
    fi
}


if [[ "$OSTYPE" == "msys" ]]; then
    check_win_package "C:/Program Files/nodejs" "NodeJS"
    check_env_package "Python" "Python"
    check_win_package "C:/Program Files/MongoDB/Server/" "MongoDB"
else
    check_unix_package "git" "Git"
    check_unix_package "nodejs" "NodeJS"
    check_unix_package "python3" "Python"
    check_unix_package "python3-venv" "Python VENV" # apt-get install python3-venv
    check_unix_package "mongodb-org" "MongoDB"
    check_unix_package "samba" "Samba"
    check_unix_package "samba-common-bin" "Samba common bin"
fi;