#!/bin/bash

# Remove OLD DIR if available
if [[ -d "ncloud" ]]; then
    rm -rf ncloud
fi;

# Cloning ncloud repo from github
git clone https://github.com/project-ncloud/ncloud.git

# Change Dir to ncloud
cd ncloud


# Installing dependencies
npm install

echo ""
echo "Done..."
echo ""