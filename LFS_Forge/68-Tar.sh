#!/bin/bash

cd /sources

tar -xvf tar-1.35.tar.xz

cd tar-1.35

FORCE_UNSAFE_CONFIGURE=1  \
./configure --prefix=/usr

make

make install
make -C doc install-html docdir=/usr/share/doc/tar-1.35

cd /sources

rm -rf tar-1.35
