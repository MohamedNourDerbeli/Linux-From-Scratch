#!/bin/bash

cd /sources

tar -xvf gawk-5.3.0.tar.xz

cd gawk-5.3.0

sed -i 's/extras//' Makefile.in

./configure --prefix=/usr

make

chown -R tester .
su tester -c "PATH=$PATH make check"

rm -f /usr/bin/gawk-5.3.0
make install

ln -sv gawk.1 /usr/share/man/man1/awk.1

mkdir -pv                                   /usr/share/doc/gawk-5.3.0
cp    -v doc/{awkforai.txt,*.{eps,pdf,jpg}} /usr/share/doc/gawk-5.3.0

cd /sources

rm -rf gawk-5.3.0
