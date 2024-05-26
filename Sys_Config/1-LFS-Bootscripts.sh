#!/bin/bash

cd /sources

tar -xvf lfs-bootscripts-20230728

cd lfs-bootscripts-20230728

make install

cd /sources

rm -rf lfs-bootscripts-20230728
