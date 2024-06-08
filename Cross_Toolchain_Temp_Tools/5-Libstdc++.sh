#!/bin/bash

# must be super user (use 'sudo su')
if [ "$(id -u)" -ne 0 ]; then
   echo "This script must be run as root" >&2
   exit 1
fi

# Navigate to the directory containing the source code
cd $LFS/sources

# Extract the source code for GCC
echo "Extracting GCC"
tar -xvJf gcc-13.2.0.tar.xz

# Navigate to the GCC folder
cd $LFS/sources/gcc-13.2.0

# Create a build directory
mkdir -v $LFS/sources/gcc-13.2.0/build
cd $LFS/sources/gcc-13.2.0/build

# Configure and build Libstdc++
# This is the main build process for Libstdc++
echo "Configuring and building Libstdc++"
time ../libstdc++-v3/configure           \
    --host=$LFS_TGT                 \
    --build=$(../config.guess)      \
    --prefix=/usr                   \
    --disable-multilib              \
    --disable-nls                   \
    --disable-libstdcxx-pch         \
    --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/13.2.0 && make && make DESTDIR=$LFS install

# Remove unnecessary files
# Remove the libtool archive files because they are harmful for cross-compilation
rm -v $LFS/usr/lib/lib{stdc++{,exp,fs},supc++}.la

# Clean up by removing the GCC source directory
# This is done to remove unnecessary files and directories
cd $LFS/sources
rm -rf gcc-13.2.0
