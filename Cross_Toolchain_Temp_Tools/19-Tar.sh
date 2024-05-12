#!/bin/bash

# Change to the $LFS/sources directory
cd $LFS/sources

# Echo a message to the user indicating that tar is being extracted
echo "Extracting Tar"

# Extract the tar-1.35.tar.xz file
tar -xvJf tar-1.35.tar.xz

# Change to the extracted tar-1.35 directory
cd $LFS/sources/tar-1.35

# Echo a message to the user indicating that tar is being configured and built
echo "Configuring and building Tar"

# Configure and build tar with the specified options
time ./configure --prefix=/usr                     \
            --host=$LFS_TGT                   \
            --build=$(build-aux/config.guess) && make && make DESTDIR=$LFS install

# Change back to the $LFS/sources directory
cd $LFS/sources

# Remove the extracted tar-1.35 directory
rm -rf tar-1.35
