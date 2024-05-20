#!/bin/bash

# Export the LFS variable, which points to the LFS partition
export LFS="/mnt/lfs"

# Copy all shell scripts from chroot-build directory to $LFS and make them executable
cp chroot-build/*.sh "$LFS" && chmod +x "$LFS"/*.sh

# Enter chroot environment and execute setup_chroot-build.sh
chroot "$LFS" /usr/bin/env -i \
    HOME=/root \
    TERM="$TERM" \
    PS1='(lfs chroot) \u:\w\$ ' \
    PATH=/usr/bin:/usr/sbin \
    MAKEFLAGS="-j$(nproc)" \
    TESTSUITEFLAGS="-j$(nproc)" \
    /bin/bash --login -c '
        if [ -f setup_chroot-build.sh ]; then
            bash setup_chroot-build.sh
        fi
    '
chroot "$LFS" /usr/bin/env -i \
    HOME=/root \
    TERM="$TERM" \
    PS1='(lfs chroot) \u:\w\$ ' \
    PATH=/usr/bin:/usr/sbin \
    MAKEFLAGS="-j$(nproc)" \
    TESTSUITEFLAGS="-j$(nproc)" \
    /bin/bash --login
