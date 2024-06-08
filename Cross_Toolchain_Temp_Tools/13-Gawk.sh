#!/bin/bash

# must be super user (use 'sudo su')
if [ "$(id -u)" -ne 0 ]; then
   echo "This script must be run as root" >&2
   exit 1
fi

# Change to the LFS/sources directory
cd $LFS/sources

# Extract Gawk from the tar.xz file
echo "Extracting Gawk"
tar -xvJf gawk-5.3.0.tar.xz

# Change to the extracted Gawk directory
cd $LFS/sources/gawk-5.3.0

# Remove the 'extras' target from Makefile.in
sed -i '/extras//' Makefile.in

# Configure and build Gawk with specified parameters
echo "Configuring and building Gawk"
time ./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess) && make && make DESTDIR=$LFS install

# Change back to the LFS/sources directory
cd $LFS/sources

# Remove the extracted Gawk directory to save space
rm -rf gawk-5.3.0
