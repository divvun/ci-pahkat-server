#!/bin/bash
set -euxo pipefail

ROOT=$PWD
DIST=$ROOT/dist
rm -rf $DIST && mkdir $DIST

cd $ROOT

git clone --single-branch --branch develop --depth=1 https://github.com/divvun/pahkat.git || (cd pahkat && git pull && cd ..)
docker build -t divvun/pahkat-server pahkat
# docker build -t divvun/pahkat-server ../pahkat
docker save divvun/pahkat-server | gzip > $DIST/pahkat-server.tar.gz

pushd $DIST
tar cvvfz "$ROOT/dist.tar.gz" .
