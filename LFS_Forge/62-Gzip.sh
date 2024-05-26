#!/bin/bash

cd /sources

tar -xvf gzip-1.13.tar.xz

cd gzip-1.13

./configure --prefix=/usr

make

# make check

make install

cd /sources

rm -rf gzip-1.13
