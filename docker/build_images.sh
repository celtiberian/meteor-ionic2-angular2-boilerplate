#!/bin/sh

cd ..
docker build -f docker/dockerfile.base -t meteor:base .
docker build -f docker/dockerfile.app -t meteor:app .
docker build -f docker/dockerfile.db -t meteor:db .
