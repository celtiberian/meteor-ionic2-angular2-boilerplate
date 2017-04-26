#!/bin/bash

# we need to init the replica set after mongod is launched
(sleep 5 && mongo admin --eval 'rs.initiate()') &

mongod --replSet rs0 --oplogSize 50

