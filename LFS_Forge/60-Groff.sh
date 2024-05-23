#!/bin/bash

cd /sources

tar -xvf groff-1.23.0.tar.gz

cd groff-1.23.0

PAGE=A4 ./configure --prefix=/usr

make

make check

make install

cd /sources

rm -rf groff-1.23.0
