#!/bin/bash

cat > /etc/sysconfig/console << "EOF"
# Begin /etc/sysconfig/console

KEYMAP="qwerty"
FONT="latarcyrheb-sun16 -m 8859-2"

# End /etc/sysconfig/console
EOF
