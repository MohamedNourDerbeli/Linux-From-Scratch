#!/bin/bash

# Export the path
export LFS_PATH=/mnt/lfs/usr/

# Array of script files
scripts=(
    "1-binutils_setup.sh"
    "2-GCC_setup.sh"
    "3-Linux_API_Headers.sh"
    "4-Glibc_setup.sh"
    "5-Libstdc++.sh"
    "6-M4.sh"
    "7-Ncurses.sh"
    "8-Bash.sh"
    "9-Coreutils.sh"
    "10-Diffutils.sh"
    "11-File.sh"
    "12-Findutils.sh"
    "13-Gawk.sh"
    "14-Grep.sh"
    "15-Gzip.sh"
    "16-Make.sh"
    "17-Patch.sh"
    "18-Sed.sh"
    "19-Tar.sh"
    "20-Xz.sh"
    "21-Binutils.sh"
    "22-GCC.sh"
)

# Loop through each script file
for script in "${scripts[@]}"; do
    bash "${LFS_PATH}${script}"
    sleep 3
done
