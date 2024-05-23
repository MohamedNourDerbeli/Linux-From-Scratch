#!/bin/bash

cd /sources

tar -xvf texinfo-7.1.tar.xz

cd texinfo-7.1

./configure --prefix=/usr

make

make install

make TEXMF=/usr/share/texmf install-tex

cd /sources

rm -rf texinfo-7.1
