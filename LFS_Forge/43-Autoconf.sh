#!/bin/bash

cd /sources

tar -xvf autoconf-2.72.tar.xz

cd autoconf-2.72

./configure --prefix=/usr

make

make check

make install

cd /sources

rm -rf autoconf-2.72
