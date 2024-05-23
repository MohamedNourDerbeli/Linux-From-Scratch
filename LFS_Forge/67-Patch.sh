#!/bin/bash

cd /sources

tar -xvf patch-2.7.6.tar.xz

cd patch-2.7.6

./configure --prefix=/usr

make

make install

cd /sources

rm -rf patch-2.7.6
