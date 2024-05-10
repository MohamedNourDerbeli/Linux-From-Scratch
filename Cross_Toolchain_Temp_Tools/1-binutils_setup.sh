#!/bin/bash
# LFS environment variables
export LFS="/mnt/lfs"
export LFS_TGT="$(uname -m)-lfs-linux-gnu"

# Navigate to the directory containing the Binutils source code
cd $LFS/sources

# Extract the source code
echo "Extracting Binutils"
tar -xvJf binutils-2.42.tar.xz

# Create build directory
mkdir -v $LFS/sources/binutils-2.42/build
cd $LFS/sources/binutils-2.42/build

echo "Configuring and building Binutils"
# Configure Build and install Binutils
time { ../configure --prefix=$LFS/tools \
              --with-sysroot=$LFS \
              --target=$LFS_TGT \
              --disable-nls \
              --enable-gprofng=no \
              --disable-werror \
              --enable-default-hash-style=gnu && make && make install; }

# Clean up
cd $LFS/sources
rm -rf binutils-2.42
