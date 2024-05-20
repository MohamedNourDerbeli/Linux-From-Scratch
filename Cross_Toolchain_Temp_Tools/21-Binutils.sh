#!/bin/bash

# Change to the sources directory in the LFS (Linux From Scratch) environment
cd $LFS/sources

# Extract Binutils source code
echo "Extracting Binutils"
tar -xvJf binutils-2.42.tar.xz

# Change to the extracted Binutils source code directory
cd $LFS/sources/binutils-2.42

# Modify the ltmain.sh file to remove an unwanted directory addition
sed '6009s/$add_dir//' -i ltmain.sh

# Create a build directory and change to it
mkdir -v build
cd build

# Configure and build Binutils with specified options
echo "Configuring and building Binutils"
time ../configure                   \
    --prefix=/usr              \
    --build=$(../config.guess) \
    --host=$LFS_TGT            \
    --disable-nls              \
    --enable-shared            \
    --enable-gprofng=no        \
    --disable-werror           \
    --enable-64-bit-bfd        \
    --enable-default-hash-style=gnu 

make && make DESTDIR=$LFS install

# Remove unnecessary libraries
rm -v $LFS/usr/lib/lib{bfd,ctf,ctf-nobfd,opcodes,sframe}.{a,la}

# Change back to the sources directory and remove the extracted Binutils source code directory
cd $LFS/sources
rm -rf binutils-2.42
