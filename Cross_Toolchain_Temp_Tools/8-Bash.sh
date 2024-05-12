#!/bin/bash

# Change to the LFS/sources directory
cd $LFS/sources

# Extract Bash
echo "Extracting Bash"
tar -xvJf bash-5.2.21.tar.gz

# Change to the extracted Bash directory
cd $LFS/sources/bash-5.2.21

# Configure and build Bash with specified parameters
echo "Configuring and building Bash"
time ./configure --prefix=/usr                      \
            --build=$(sh support/config.guess) \
            --host=$LFS_TGT                    \
            --without-bash-malloc && make && make DESTDIR=$LFS install

# Create a symbolic link for sh pointing to bash
ln -sv bash $LFS/bin/sh

# Change back to the LFS/sources directory
cd $LFS/sources

# Remove the extracted Bash directory
rm -rf bash-5.2.21
