#!/bin/bash

cd /sources

tar -xvf procps-ng-4.0.4.tar.xz

cd procps-ng-4.0.4

./configure --prefix=/usr                           \
            --docdir=/usr/share/doc/procps-ng-4.0.4 \
            --disable-static                        \
            --disable-kill
make

# make -k check

make install

cd /sources

rm -rf procps-ng-4.0.4
