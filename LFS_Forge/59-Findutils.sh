#!/bin/bash

cd /sources

tar -xvf findutils-4.9.0.tar.xz

cd findutils-4.9.0

./configure --prefix=/usr --localstatedir=/var/lib/locate

make

chown -R tester .
su tester -c "PATH=$PATH make check"

make install

cd /sources

rm -rf findutils-4.9.0
