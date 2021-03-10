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

# Installing serve as global dependency
npm install -g serve

# Compile Production build
npm run-script build

echo ""
echo "Done..."
echo ""