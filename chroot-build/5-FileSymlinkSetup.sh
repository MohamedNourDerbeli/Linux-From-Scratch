#!/bin/bash

# Create a symbolic link for /etc/mtab pointing to /proc/self/mounts
ln -sv /proc/self/mounts /etc/mtab

# Write to /etc/hosts file
cat > /etc/hosts << EOF
127.0.0.1  localhost $(hostname)
::1        localhost
EOF

# Write to /etc/passwd file
cat > /etc/passwd << "EOF"
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/dev/null:/usr/bin/false
daemon:x:6:6:Daemon User:/dev/null:/usr/bin/false
messagebus:x:18:18:D-Bus Message Daemon User:/run/dbus:/usr/bin/false
uuidd:x:80:80:UUID Generation Daemon User:/dev/null:/usr/bin/false
nobody:x:65534:65534:Unprivileged User:/dev/null:/usr/bin/false
EOF

# Write to /etc/group file
cat > /etc/group << "EOF"
root:x:0:
bin:x:1:daemon
sys:x:2:
kmem:x:3:
tape:x:4:
tty:x:5:
daemon:x:6:
floppy:x:7:
disk:x:8:
lp:x:9:
dialout:x:10:
audio:x:11:
video:x:12:
utmp:x:13:
cdrom:x:15:
adm:x:16:
messagebus:x:18:
input:x:24:
mail:x:34:
kvm:x:61:
uuidd:x:80:
wheel:x:97:
users:x:999:
nogroup:x:65534:
EOF

# Add a new user 'tester' to /etc/passwd file
echo "tester:x:101:101::/home/tester:/bin/bash" >> /etc/passwd

# Add a new group 'tester' to /etc/group file
echo "tester:x:101:" >> /etc/group

# Create a new directory /home/tester with ownership set to 'tester'
install -o tester -d /home/tester

# Execute /usr/bin/bash with --login option
exec /usr/bin/bash --login -c '
touch /var/log/{btmp,lastlog,faillog,wtmp}
chgrp -v utmp /var/log/lastlog
chmod -v 664  /var/log/lastlog
chmod -v 600  /var/log/btmp
bash 6-Gettext.sh 
bash 7-Bison.sh 
bash 8-Perl.sh 
bash 9-Python.sh 
bash 10-Texinfo.sh 
bash 11-Util-linux.sh 
'
