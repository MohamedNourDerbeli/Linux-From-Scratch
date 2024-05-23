#!/bin/bash

cd /sources

tar -xvf libcap-2.69.tar.xz 

cd libcap-2.69

sed -i '/install -m.*STA/d' libcap/Makefile

make prefix=/usr lib=lib

make test

make prefix=/usr lib=lib install

cd /sources

rm -rf libcap-2.69
