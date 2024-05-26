#!/bin/bash

cd /sources

tar -xvf make-4.4.1.tar.gz

cd make-4.4.1

./configure --prefix=/usr

make

# chown -R tester .
# su tester -c "PATH=$PATH make check"

make install

cd /sources

rm -rf make-4.4.1
