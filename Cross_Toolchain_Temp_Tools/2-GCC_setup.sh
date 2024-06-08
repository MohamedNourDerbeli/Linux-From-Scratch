#!/bin/bash

# must be super user (use 'sudo su')
if [ "$(id -u)" -ne 0 ]; then
   echo "This script must be run as root" >&2
   exit 1
fi

# Navigate to the directory containing the source code
cd $LFS/sources

# Extract the source code for GCC
echo "Extracting GCC"
tar -xvJf gcc-13.2.0.tar.xz

# Navigate to the GCC folder
cd $LFS/sources/gcc-13.2.0

# Extract and rename the required libraries
tar -xf../mpfr-4.2.1.tar.xz
mv -v mpfr-4.2.1 mpfr
tar -xf../gmp-6.3.0.tar.xz
mv -v gmp-6.3.0 gmp
tar -xf../mpc-1.3.1.tar.gz
mv -v mpc-1.3.1 mpc

# Apply a patch for x86_64 architecture
case $(uname -m) in
  x86_64)
    sed -e '/m64=/s/lib64/lib/' \
        -i.orig gcc/config/i386/t-linux64
 ;;
esac

# Create a build directory
mkdir -v $LFS/sources/gcc-13.2.0/build
cd $LFS/sources/gcc-13.2.0/build

echo "Configuring and building GCC"
# Configure, build, and install GCC with specific options
time ../configure                  \
    --target=$LFS_TGT         \
    --prefix=$LFS/tools       \
    --with-glibc-version=2.39 \
    --with-sysroot=$LFS       \
    --with-newlib             \
    --without-headers         \
    --enable-default-pie      \
    --enable-default-ssp      \
    --disable-nls             \
    --disable-shared          \
    --disable-multilib        \
    --disable-threads         \
    --disable-libatomic       \
    --disable-libgomp         \
    --disable-libquadmath     \
    --disable-libssp          \
    --disable-libvtv          \
    --disable-libstdcxx       \
    --enable-languages=c,c++ && make && make install

# Update the limits.h file
cd ..
cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
  `dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/include/limits.h

# Clean up by removing the GCC source directory
cd $LFS/sources
rm -rf gcc-13.2.0
