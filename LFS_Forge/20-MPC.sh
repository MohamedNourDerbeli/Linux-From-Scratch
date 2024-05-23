#!/bin/bash

cd /sources

tar -xvf mpc-1.3.1.tar.gz

cd mpc-1.3.1

./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/mpc-1.3.1

make
make html

make check

make install
make install-html

cd /sources

rm -rf mpc-1.3.1
