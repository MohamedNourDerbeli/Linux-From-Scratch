#!/bin/bash

cd /sources

tar -xvf acl-2.3.2.tar.xz

cd acl-2.3.2

./configure --prefix=/usr         \
            --disable-static      \
            --docdir=/usr/share/doc/acl-2.3.2

make

make install

cd /sources

rm -rf acl-2.3.2
