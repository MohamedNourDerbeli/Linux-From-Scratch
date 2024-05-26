#!/bin/bash

cd /sources

tar -xvf file-5.45.tar.gz

cd file-5.45

./configure --prefix=/usr

make

# make check

make install

cd /sources/

rm -rf file-5.45
