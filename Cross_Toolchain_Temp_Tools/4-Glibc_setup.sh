#!/bin/bash

# must be super user (use 'sudo su')
if [ "$(id -u)" -ne 0 ]; then
   echo "This script must be run as root" >&2
   exit 1
fi

# Navigate to the directory containing the source code
# This is where the script assumes the source code is located
cd $LFS/sources

# Extract the source code for Glibc
# This is done using the tar command with the -xvJf options
echo "Extracting Glibc"
tar -xvJf glibc-2.39.tar.xz

# Navigate to the Glibc folder
# This is where the extracted source code is located
cd $LFS/sources/glibc-2.39

# Create symbolic links based on the system architecture
# This is done to ensure compatibility with different architectures
case $(uname -m) in
    i?86)   ln -sfv ld-linux.so.2 $LFS/lib/ld-lsb.so.3
    ;;
    x86_64) ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64
            ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64/ld-lsb-x86-64.so.3
    ;;
esac

# Apply a patch to Glibc
# This is done to fix any issues or add new features to Glibc
patch -Np1 -i../glibc-2.39-fhs-1.patch

# Create a build directory
# This is where the build process will take place
mkdir -v $LFS/sources/glibc-2.39/build
cd $LFS/sources/glibc-2.39/build

# Set the rootsbindir variable to /usr/sbin
# This is a configuration option for the build process
echo "rootsbindir=/usr/sbin" > configparms

# Configure and build Glibc
# This is the main build process for Glibc
echo "Configuring and building GCC"
time ../configure                             \
      --prefix=/usr                      \
      --host=$LFS_TGT                    \
      --build=$(../scripts/config.guess) \
      --enable-kernel=4.19               \
      --with-headers=$LFS/usr/include    \
      --disable-nscd                     \
      libc_cv_slibdir=/usr/lib && make && make DESTDIR=$LFS install

# Modify the ldd script to remove /usr from RTLDLIST
# This is done to fix an issue with the ldd script
sed '/RTLDLIST=/s@/usr@@g' -i $LFS/usr/bin/ldd

# Test if the linker is working correctly
# This is a simple test to ensure the linker is functioning as expected
echo 'int main(){}' | $LFS_TGT-gcc -xc -
readelf -l a.out | grep ld-linux

# Remove the test file
# This is done to clean up after the test
rm -v a.out

# Clean up by removing the Glibc source directory
# This is done to remove unnecessary files and directories
cd $LFS/sources
rm -rf glibc-2.39
