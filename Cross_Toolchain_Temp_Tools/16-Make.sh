#!/bin/bash

# Change directory to $LFS/sources
cd $LFS/sources

# Extract the make-4.4.1.tar.gz archive
echo "Extracting Make"
tar -xvJf make-4.4.1.tar.gz

# Change directory to $LFS/sources/make-4.4.1
cd $LFS/sources/make-4.4.1

# Configure and build Make with specified options
echo "Configuring and building Make"
time ./configure --prefix=/usr   \
            --without-guile \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess) &&
# Run make to build the Make package
make &&
# Install Make to $LFS with DESTDIR option
make DESTDIR=$LFS install

# Change directory back to $LFS/sources
cd $LFS/sources

# Remove the extracted make-4.4.1 directory
rm -rf make-4.4.1
