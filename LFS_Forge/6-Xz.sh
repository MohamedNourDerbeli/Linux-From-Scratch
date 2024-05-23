#!/bin/bash

cd /sources

tar -xvf xz-5.4.6.tar.xz 

cd xz-5.4.6

./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/xz-5.4.6

make

make check

make install

cd /sources

rm -rf xz-5.4.6
