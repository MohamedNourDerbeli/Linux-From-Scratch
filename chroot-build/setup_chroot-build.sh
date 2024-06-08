#!/bin/bash

# must be super user (use 'sudo su')
if [ "$(id -u)" -ne 0 ]; then
   echo "This script must be run as root" >&2
   exit 1
fi

# Execute other scripts
bash 4-DirCreation.sh 
bash 5-FileSymlinkSetup.sh
