#!/bin/bash

# Export the LFS variable containing the path to the LFS directory
export LFS="/mnt/lfs"

# Create the necessary directories in the LFS directory
mkdir -pv $LFS/{dev,proc,sys,run}

# Mount the /dev directory to the LFS/dev directory
mount -v --bind /dev $LFS/dev

# Mount the devpts file system to the LFS/dev/pts directory
mount -vt devpts devpts -o gid=5,mode=0620 $LFS/dev/pts

# Mount the proc file system to the LFS/proc directory
mount -vt proc proc $LFS/proc

# Mount the sysfs file system to the LFS/sys directory
mount -vt sysfs sysfs $LFS/sys

# Mount the tmpfs file system to the LFS/run directory
mount -vt tmpfs tmpfs $LFS/run

# Check if /dev/shm is a symbolic link
if [ -h $LFS/dev/shm ]; then
  # If it is, create a directory in the LFS directory with the same name as the target of the symbolic link
  install -v -d -m 1777 $LFS$(realpath /dev/shm)
else
  # If it is not, mount the tmpfs file system to the LFS/dev/shm directory
  mount -vt tmpfs -o nosuid,nodev tmpfs $LFS/dev/shm
fi
