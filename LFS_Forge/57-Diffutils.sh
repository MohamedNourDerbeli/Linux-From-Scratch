#!/bin/bash

cd /sources

tar -xvf diffutils-3.10.tar.xz

cd diffutils-3.10

./configure --prefix=/usr

make

# make check

make install

cd /sources 

rm -rf diffutils-3.10
