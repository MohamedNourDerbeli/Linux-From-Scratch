#!/bin/bash

# must be super user (use 'sudo su')
if [ "$(id -u)" -ne 0 ]; then
   echo "This script must be run as root" >&2
   exit 1
fi

# Change to the LFS/sources directory
cd $LFS/sources

# Extract Findutils from the tar.xz file
echo "Extracting Findutils"
tar -xvJf findutils-4.9.0.tar.xz

# Change to the extracted Findutils directory
cd $LFS/sources/findutils-4.9.0

# Configure and build Findutils with specified parameters
echo "Configuring and building Findutils"
time ./configure --prefix=/usr                   \
            --localstatedir=/var/lib/locate \
            --host=$LFS_TGT                 \
            --build=$(build-aux/config.guess) && make && make DESTDIR=$LFS install

# Change back to the LFS/sources directory
cd $LFS/sources

# Remove the extracted Findutils directory to save space
rm -rf findutils-4.9.0
