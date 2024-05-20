#!/bin/bash

# Change to the /sources directory
cd /sources

# Extract the Texinfo archive
echo "Extracting Texinfo"
tar -xvf texinfo-7.1.tar.xz

# Change to the extracted Texinfo directory
cd texinfo-7.1

# Configure Texinfo with the prefix set to /usr
./configure --prefix=/usr

# Build Texinfo
make

# Install Texinfo
make install

# Change back to the /sources directory
cd /sources

# Remove the extracted Texinfo directory
rm -rf texinfo-7.1
