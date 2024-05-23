#!/bin/bash

cd /sources

tar -xvf kbd-2.6.4.tar.xz

cd kbd-2.6.4

patch -Np1 -i ../kbd-2.6.4-backspace-1.patch

sed -i '/RESIZECONS_PROGS=/s/yes/no/' configure
sed -i 's/resizecons.8 //' docs/man/man8/Makefile.in

./configure --prefix=/usr --disable-vlock

make

make check

make install

cp -R -v docs/doc -T /usr/share/doc/kbd-2.6.4

cd /sources

rm -rf kbd-2.6.4
