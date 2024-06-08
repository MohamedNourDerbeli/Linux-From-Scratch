#!/bin/bash

export LFS="/mnt/lfs/"

umount -v $LFS/dev/pts
mountpoint -q $LFS/dev/shm && umount -v $LFS/dev/shm
umount -v $LFS/dev
umount -v $LFS/run
umount -v $LFS/proc
umount -v $LFS/sys
umount -v /dev/sdc2
umount -v /dev/sdc1
umount -v $LFS
