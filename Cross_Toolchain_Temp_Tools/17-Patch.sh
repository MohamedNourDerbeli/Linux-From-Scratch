#!/bin/bash

# Change to the $LFS/sources directory
cd $LFS/sources

# Echo a message to the user indicating that the patch is being extracted
echo "Extracting Patch"

# Extract the patch-2.7.6.tar.xz file
tar -xvJf patch-2.7.6.tar.xz

# Change to the extracted patch-2.7.6 directory
cd $LFS/sources/patch-2.7.6

# Echo a message to the user indicating that the patch is being configured and built
echo "Configuring and building Patch"

# Configure and build the patch with the specified options
time ./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess) && make && make DESTDIR=$LFS install

# Change back to the $LFS/sources directory
cd $LFS/sources

# Remove the extracted patch-2.7.6 directory
rm -rf patch-2.7.6
