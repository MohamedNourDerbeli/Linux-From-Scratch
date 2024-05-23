#!/bin/bash

cd /sources

tar -xvf less-643.tar.gz

cd less-643
 
./configure --prefix=/usr --sysconfdir=/etc

make

make check

make install

cd /sources

rm -rf less-643
