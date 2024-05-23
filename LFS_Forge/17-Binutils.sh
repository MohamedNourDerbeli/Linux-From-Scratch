#!/bin/bash

cd /sources

tar -xvf binutils-2.42.tar.xz

cd binutils-2.42

mkdir -v build
cd       build

../configure --prefix=/usr       \
             --sysconfdir=/etc   \
             --enable-gold       \
             --enable-ld=default \
             --enable-plugins    \
             --enable-shared     \
             --disable-werror    \
             --enable-64-bit-bfd \
             --with-system-zlib  \
             --enable-default-hash-style=gnu

make tooldir=/usr

make -k check

grep '^FAIL:' $(find -name '*.log')

make tooldir=/usr install

rm -fv /usr/lib/lib{bfd,ctf,ctf-nobfd,gprofng,opcodes,sframe}.a

cd /sources

rm -rf binutils-2.42
