#!/bin/bash

cd /sources

tar -xvf libffi-3.4.4.tar.gz

cd libffi-3.4.4

./configure --prefix=/usr          \
            --disable-static       \
            --with-gcc-arch=native

make

# make check

make install

cd /sources

rm -rf libffi-3.4.4
