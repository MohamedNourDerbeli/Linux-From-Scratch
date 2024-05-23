#!/bin/bash

cd /sources


tar -xvf 3.09.tar.gz

cd sysvinit-3.09

patch -Np1 -i ../sysvinit-3.09-consolidated-1.patch

make

make install

cd /sources

rm -rf 3.09
