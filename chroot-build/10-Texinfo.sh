#!/bin/bash

# Change to the LFS/sources directory
cd $LFS/sources

# Extract the Texinfo archive
echo "Extracting Texinfo"
tar -xvJf texinfo-7.1.tar.xz

# Change to the extracted Texinfo directory
cd $LFS/sources/texinfo-7.1

# Configure Texinfo with the prefix set to /usr
./configure --prefix=/usr

# Build Texinfo
make

# Install Texinfo
make install

# Change back to the LFS/sources directory
cd $LFS/sources

# Remove the extracted Texinfo directory
rm -rf texinfo-7.1
