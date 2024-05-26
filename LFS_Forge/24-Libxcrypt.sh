#!/bin/bash

cd /sources

tar -xvf libxcrypt-4.4.36.tar.xz

cd libxcrypt-4.4.36

./configure --prefix=/usr                \
            --enable-hashes=strong,glibc \
            --enable-obsolete-api=no     \
            --disable-static             \
            --disable-failure-tokens

make

# make check

make install

cd /sources

rm -rf libxcrypt-4.4.36
