#!/bin/bash

cd /sources

tar -xvf inetutils-2.5.tar.xz 

cd inetutils-2.5

./configure --prefix=/usr        \
            --bindir=/usr/bin    \
            --localstatedir=/var \
            --disable-logger     \
            --disable-whois      \
            --disable-rcp        \
            --disable-rexec      \
            --disable-rlogin     \
            --disable-rsh        \
            --disable-servers

make

# make check

make install

mv -v /usr/{,s}bin/ifconfig

cd /sources

rm -rf inetutils-2.5
