#!/bin/sh

# Run meteor
cd /home/meteor/build/bundle
echo "Starting Meteor Application..."
exec node ./main.js
