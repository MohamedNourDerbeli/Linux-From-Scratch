#!/bin/bash

cd /sources

tar -xvf libpipeline-1.5.7.tar.gz 

cd libpipeline-1.5.7

./configure --prefix=/usr

make

make check

make install

cd /sources

rm -rf libpipeline-1.5.7
