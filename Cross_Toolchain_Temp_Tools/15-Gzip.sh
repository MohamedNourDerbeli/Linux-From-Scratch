#!/bin/bash

# Change directory to the sources folder
cd $LFS/sources

# Extract the gzip archive
echo "Extracting Gzip"
tar -xvJf gzip-1.13.tar.xz

# Change directory to the gzip source folder
cd $LFS/sources/gzip-1.13

# Configure and build gzip with the specified options
echo "Configuring and building Gzip"
time ./configure --prefix=/usr --host=$LFS_TGT \
     && make && make DESTDIR=$LFS install

# Change back to the sources folder
cd $LFS/sources

# Remove the gzip source folder
rm -rf gzip-1.13
