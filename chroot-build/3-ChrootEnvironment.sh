#!/bin/bash

# Export the LFS variable, which points to the LFS partition
export LFS="/mnt/lfs"

# Copy all shell scripts from chroot-build directory to $LFS and make them executable
cp -r LFS_Forge "$LFS" && chmod +x "$LFS"/LFS_Forge/*.sh
# Enter chroot environment and execute setup_chroot-build.sh
chroot "$LFS" /usr/bin/env -i \
    HOME=/root \
    TERM="$TERM" \
    PS1='(lfs chroot) \u:\w\$ ' \
    PATH=/usr/bin:/usr/sbin \
    MAKEFLAGS="-j$(nproc)" \
    TESTSUITEFLAGS="-j$(nproc)" \
    /bin/bash --login -c '
        if [ -f /usr/setup_chroot-build.sh ]; then
            cd /usr
            bash setup_chroot-build.sh
            rm -rf *.sh
            cd /

        fi
        if [ -f "/LFS_Forge/Setup_lfs_forge.sh" ]; then
            cd /LFS_Forge/
            bash Setup_lfs_forge.sh
            cd
            rm -rf /LFS_Forge
        fi
    '

