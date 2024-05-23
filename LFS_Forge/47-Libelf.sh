#!/bin/bash

cd /sources

tar -xvf elfutils-0.190.tar.bz2

cd elfutils-0.190

./configure --prefix=/usr                \
            --disable-debuginfod         \
            --enable-libdebuginfod=dummy

make

make check

make -C libelf install
install -vm644 config/libelf.pc /usr/lib/pkgconfig
rm /usr/lib/libelf.a

cd /sources

rm -rf elfutils-0.190
