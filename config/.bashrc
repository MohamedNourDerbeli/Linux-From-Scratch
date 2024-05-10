#!/bin/bash

# Create .bashrc for the lfs user
cat > /home/lfs/.bashrc << "EOF"
set +h
umask 022
LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/usr/bin
if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
PATH=$LFS/tools/bin:$PATH
CONFIG_SITE=$LFS/usr/share/config.site
export LFS LC_ALL LFS_TGT PATH CONFIG_SITE
export MAKEFLAGS=-j$(nproc)
if [ -f $LFS/usr/1-binutils_setup.sh ]; then
    $LFS/usr/1-binutils_setup.sh && rm -f $LFS/usr/1-binutils_setup.sh
fi

EOF

exit 1
