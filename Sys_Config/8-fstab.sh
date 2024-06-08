#!/bin/bash

cat > /etc/fstab << "EOF"
# Begin /etc/fstab

# file system  mount-point    type     options             dump  fsck
#                                                                order
# Root
UUID=f556efa1-cd6e-4054-94d6-be112d7a0a43    /              ext4    defaults            1     1
# Swap
UUID=5f472b63-ec60-4919-82cd-75fd72e4d3e2     swap           swap     pri=1               0     0
proc           /proc          proc     nosuid,noexec,nodev 0     0
sysfs          /sys           sysfs    nosuid,noexec,nodev 0     0
devpts         /dev/pts       devpts   gid=5,mode=620      0     0
tmpfs          /run           tmpfs    defaults            0     0
devtmpfs       /dev           devtmpfs mode=0755,nosuid    0     0
tmpfs          /dev/shm       tmpfs    nosuid,nodev        0     0
cgroup2        /sys/fs/cgroup cgroup2  nosuid,noexec,nodev 0     0

# End /etc/fstab
EOF

cat > /boot/grub/grub.cfg << "EOF"
# Begin /boot/grub/grub.cfg
set default=0
set timeout=5

insmod part_gpt
insmod ext2
set root=(hd0,5)

menuentry "GNU/Linux, Linux 6.7.4-lfs-12.1" {
        linux   /boot/vmlinuz-6.7.4-lfs-12.1 root=/dev/sdc2 ro
}
EOF
