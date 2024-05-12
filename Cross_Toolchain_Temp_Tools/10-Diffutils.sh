#!/bin/bash

# Change to the LFS/sources directory
cd $LFS/sources

# Extract Diffutils from the tar.xz file
echo "Extracting Diffutils"
tar -xvJf diffutils-3.10.tar.xz

# Change to the extracted Diffutils directory
cd $LFS/sources/diffutils-3.10

# Configure and build Diffutils with specified parameters
echo "Configuring and building Diffutils"
time ./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(./build-aux/config.guess) && make && make DESTDIR=$LFS install

# Change back to the LFS/sources directory
cd $LFS/sources

# Remove the extracted Diffutils directory to save space
rm -rf diffutils-3.10
