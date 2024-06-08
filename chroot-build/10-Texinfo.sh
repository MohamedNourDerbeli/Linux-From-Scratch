#!/bin/bash

# must be super user (use 'sudo su')
if [ "$(id -u)" -ne 0 ]; then
   echo "This script must be run as root" >&2
   exit 1
fi

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
