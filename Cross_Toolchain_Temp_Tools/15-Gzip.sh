#!/bin/bash

# must be super user (use 'sudo su')
if [ "$(id -u)" -ne 0 ]; then
   echo "This script must be run as root" >&2
   exit 1
fi

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
