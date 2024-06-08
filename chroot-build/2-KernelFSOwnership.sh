#!/bin/bash

# Export the LFS variable containing the path to the LFS directory
export LFS="/mnt/lfs"

# must be super user (use 'sudo su')
if [ "$(id -u)" -ne 0 ]; then
   echo "This script must be run as root" >&2
   exit 1
fi

# Create the necessary directories in the LFS directory
mkdir -pv $LFS/{dev,proc,sys,run}

# Mount the /dev directory to the LFS/dev directory
mount -v --bind /dev $LFS/dev

# Mount the devpts file system to the LFS/dev/pts directory
# Mount the proc file system to the LFS/proc directory
# Mount the sysfs file system to the LFS/sys directory
# Mount the tmpfs file system to the LFS/run directory
mount -vt devpts devpts -o gid=5,mode=0620 $LFS/dev/pts
mount -vt proc proc $LFS/proc
mount -vt sysfs sysfs $LFS/sys
mount -vt tmpfs tmpfs $LFS/run

# Check if /dev/shm is a symbolic link
if [ -h $LFS/dev/shm ]; then
  install -v -d -m 1777 $LFS$(realpath /dev/shm)
else
  mount -vt tmpfs -o nosuid,nodev tmpfs $LFS/dev/shm
fi
