#!/bin/bash

cd /sources

tar -xvf expat-2.6.0.tar.xz

cd expat-2.6.0

./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/expat-2.6.0

make

# make check

make install

install -v -m644 doc/*.{html,css} /usr/share/doc/expat-2.6.0

cd /sources

rm -rf expat-2.6.0
