#!/bin/bash

cd /sources

tar -xvf expect5.45.4.tar.gz

cd expect5.45.4

python3 -c 'from pty import spawn; spawn(["echo", "ok"])'

./configure --prefix=/usr           \
            --with-tcl=/usr/lib     \
            --enable-shared         \
            --mandir=/usr/share/man \
            --with-tclinclude=/usr/include

make

make test

make install
ln -svf expect5.45.4/libexpect5.45.4.so /usr/lib

cd /sources

rm -rf expect5.45.4
