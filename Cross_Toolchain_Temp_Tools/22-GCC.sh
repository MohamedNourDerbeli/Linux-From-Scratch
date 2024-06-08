#!/bin/bash

# Navigate to the directory containing the source code
cd $LFS/sources

# must be super user (use 'sudo su')
if [ "$(id -u)" -ne 0 ]; then
   echo "This script must be run as root" >&2
   exit 1
fi

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

# Modify Makefile.in for libgcc and libstdc++-v3 to use gthr-posix.h
sed '/thread_header =/s/@.*@/gthr-posix.h/' \
    -i libgcc/Makefile.in libstdc++-v3/include/Makefile.in

# Create a build directory
mkdir -v build
cd       build

echo "Configuring and building GCC"
# Configure, build, and install GCC with specific options
time ../configure                                       \
    --build=$(../config.guess)                     \
    --host=$LFS_TGT                                \
    --target=$LFS_TGT                              \
    LDFLAGS_FOR_TARGET=-L$PWD/$LFS_TGT/libgcc      \
    --prefix=/usr                                  \
    --with-build-sysroot=$LFS                      \
    --enable-default-pie                           \
    --enable-default-ssp                           \
    --disable-nls                                  \
    --disable-multilib                             \
    --disable-libatomic                            \
    --disable-libgomp                              \
    --disable-libquadmath                          \
    --disable-libsanitizer                         \
    --disable-libssp                               \
    --disable-libvtv                               \
    --enable-languages=c,c++ && make && make DESTDIR=$LFS install

# Create a symbolic link for cc to gcc
ln -sv gcc $LFS/usr/bin/cc

# Clean up by removing the GCC source directory
cd $LFS/sources
rm -rf gcc-13.2.0
