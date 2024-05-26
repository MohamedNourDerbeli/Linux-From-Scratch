#!/bin/bash

cd /sources

tar -xvf psmisc-23.6.tar.xz

cd psmisc-23.6

./configure --prefix=/usr

make

# make check

make install

cd /sources

rm -rf psmisc-23.6
