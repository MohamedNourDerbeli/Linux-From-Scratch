#!/bin/bash

# must be super user (use 'sudo su')
if [ "$(id -u)" -ne 0 ]; then
   echo "This script must be run as root" >&2
   exit 1
fi

# Change to the /sources directory
cd /sources

# Extract Bison
echo "Extracting Bison"
tar -xvf bison-3.8.2.tar.xz

# Change to the extracted Bison directory
cd bison-3.8.2

# Configure Bison with a specified prefix and docdir
./configure --prefix=/usr \
            --docdir=/usr/share/doc/bison-3.8.2

# Compile Bison
make

# Install Bison
make install

# Change back to the /sources directory
cd /sources

# Remove the extracted Bison directory
rm -rf bison-3.8.2
