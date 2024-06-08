#!/bin/bash

# must be super user (use 'sudo su')
if [ "$(id -u)" -ne 0 ]; then
   echo "This script must be run as root" >&2
   exit 1
fi

# Change to the LFS/sources directory
cd $LFS/sources

# Extract Ncurses
echo "Extracting Ncurses"
tar -xvJf ncurses-6.4-20230520.tar.xz

# Change to the extracted Ncurses directory
cd $LFS/sources/ncurses-6.4-20230520

# Remove the dependency on mawk by replacing it with an empty string in the configure file
sed -i s/mawk// configure

# Create a build directory and navigate into it
mkdir build
pushd build

# Configure and build Ncurses
../configure
make -C include
make -C progs tic
popd

# Configure and build Ncurses with specific options
echo "Configuring and building Ncurses"
time ./configure --prefix=/usr                \
            --host=$LFS_TGT              \
            --build=$(./config.guess)    \
            --mandir=/usr/share/man      \
            --with-manpage-format=normal \
            --with-shared                \
            --without-normal             \
            --with-cxx-shared            \
            --without-debug              \
            --without-ada                \
            --disable-stripping          \
            --enable-widec && make

# Install Ncurses to the LFS directory
make DESTDIR=$LFS TIC_PATH=$(pwd)/build/progs/tic install

# Create a symbolic link for libncursesw.so
ln -sv libncursesw.so $LFS/usr/lib/libncurses.so

# Modify the curses.h file to enable XOPEN
sed -e 's/^#if.*XOPEN.*$/#if 1/' \
    -i $LFS/usr/include/curses.h

# Change to the LFS/sources directory
cd $LFS/sources

# Remove the extracted Ncurses directory
rm -rf ncurses-6.4-20230520
