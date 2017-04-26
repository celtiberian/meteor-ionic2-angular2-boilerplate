#!/bin/bash

# See if we have a valid meteor source
METEOR_DIR=".meteor"

echo "Meteor source found in ${METEOR_DIR}"
cd ${METEOR_DIR}/..

# Check Meteor version
RELEASE=$(cat .meteor/release | cut -f2 -d'@')
echo "Checking Meteor version: "

# Download Meteor installer
echo "Downloading Meteor install script..."
curl -o /tmp/meteor.sh https://install.meteor.com/

# Install Meteor tool
echo "Installing Meteor ${RELEASE}..."
sed -i "s/^RELEASE=.*/RELEASE=${RELEASE}/" /tmp/meteor.sh
sh /tmp/meteor.sh
rm /tmp/meteor.sh
