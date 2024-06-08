#!/bin/bash

# Change the current directory to $LFS/sources
cd $LFS/sources

# Extract the Grep archive file
echo "Extracting Grep"
tar -xvJf grep-3.11.tar.xz

# Change the current directory to $LFS/sources/grep-3.11
cd $LFS/sources/grep-3.11

# Display a message indicating the configuration and building of Grep
echo "Configuring and building Grep"

# Run the configure script with specified options, build Grep, and install it to $LFS
time ./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(./build-aux/config.guess) && make && make DESTDIR=$LFS install

# Change the current directory back to $LFS/sources
cd $LFS/sources

# Remove the grep-3.11 directory
rm -rf grep-3.11
