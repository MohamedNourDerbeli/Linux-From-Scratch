#!/bin/bash

# Change to the /sources directory
cd /sources

# Extract Python source code
echo "Extracting Python"
tar -xvf Python-3.12.2.tar.xz

# Change to the extracted Python source code directory
cd Python-3.12.2

# Configure Python with the specified options
# --prefix=/usr: Install Python in the /usr directory
# --enable-shared: Enable building a shared library
# --without-ensurepip: Do not install the ensurepip module
./configure --prefix=/usr   \
            --enable-shared \
            --without-ensurepip

# Build Python from the source code
make

# Install Python to the specified location
make install

# Change back to the /sources directory
cd /sources

# Remove the extracted Python source code directory
rm -rf Python-3.12.2
