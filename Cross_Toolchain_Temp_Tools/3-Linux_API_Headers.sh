#!/bin/bash

# Navigate to the directory containing the source code
cd $LFS/sources

# Extract the source code for Linux API Headers
echo "Extracting Linux API Headers"
tar -xvJf linux-6.7.4.tar.xz

# Navigate to the Linux API Headers folder
cd $LFS/sources/linux-6.7.4

make mrproper

make headers
find usr/include -type f ! -name '*.h' -delete
cp -rv usr/include $LFS/usr


# Clean up by removing the Linux API Headers folder source directory
cd $LFS/sources
rm -rf linux-6.7.4
