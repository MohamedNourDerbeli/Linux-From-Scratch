#!/bin/bash

# must be super user (use 'sudo su')
if [ "$(id -u)" -ne 0 ]; then
   echo "This script must be run as root" >&2
   exit 1
fi

# Navigate to the directory containing the source code
cd $LFS/sources

# Extract the source code for M4
echo "Extracting M4"
tar -xvJf m4-1.4.19.tar.xz

# Navigate to the M4 folder
cd $LFS/sources/m4-1.4.19

# Configure and build M4
# This is the main build process for M4
echo "Configuring and building M4"
time ./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess) && make && make DESTDIR=$LFS install

# Navigate back to the sources directory
cd $LFS/sources

# Remove the M4 source directory
# This is done to clean up after the build process
rm -rf m4-1.4.19
