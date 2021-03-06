#!/bin/sh

cd ..

rm -rf node_modules
rm -rf .meteor\local
rm -rf .build
npm install --production
mkdir .build
meteor build --directory .build --architecture os.linux.x86_64

docker build -f docker/dockerfile.app -t meteor:app .
docker build -f docker/dockerfile.db -t meteor:db .
