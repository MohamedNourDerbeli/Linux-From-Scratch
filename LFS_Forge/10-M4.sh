#!/bin/bash

cd /sources

tar -xvf m4-1.4.19.tar.xz 

cd m4-1.4.19

./configure --prefix=/usr

make

# make check

make install

cd /sources 

rm -rf m4-1.4.19
