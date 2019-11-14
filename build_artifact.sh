#!/bin/bash
set -euxo pipefail

ROOT=$PWD
DIST=$ROOT/dist
rm -rf $DIST && mkdir $DIST

cd $ROOT

echo "copying configs"
cp docker-compose.yml $DIST

# git clone --single-branch --branch develop --depth=1 https://github.com/divvun/divvun-api.git || (cd divvun-api && git pull && cd ..)
docker build -t divvun/pahkat-server ../pahkat
docker save divvun/pahkat-server | gzip > $DIST/pahkat-server.tar.gz

pushd $DIST
tar cvvfz "$ROOT/dist.tar.gz" .
