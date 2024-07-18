#!/bin/bash
set -euo pipefail

# Trap errors and call cleanup function
trap 'echo "An error occurred. Exiting..."; exit 1;' ERR

export Info=$(readlink -f "info.txt")
echo $Info
export LOGFILE=$(readlink -f "logfile.log")
# Truncate the log file at the beginning of the script
>"$LOGFILE"
>"$Info"
bash Part1:Preparing_for_the_Build/install-requirements.sh | tee -a $LOGFILE
#bash Part2:Cross_Toolchain_and_Temporary_Tools/Cross-Toolchain | tee -a $LOGFILE
#bash Part2:Cross_Toolchain_and_Temporary_Tools/Temporary_Tools | tee -a $LOGFILE
#bash Part2:Cross_Toolchain_and_Temporary_Tools/Chroot-Additional-Temp | tee -a $LOGFILE
#bash Part3:Building_the_LFS_System/Basic-System-Software1 | tee -a $LOGFILE
#bash Part3:Building_the_LFS_System/Basic-System-Software2 | tee -a $LOGFILE
#bash Part3:Building_the_LFS_System/System-Configuration | tee -a $LOGFILE
