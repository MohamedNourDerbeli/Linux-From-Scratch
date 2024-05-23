#!/bin/bash

cd /sources

tar -xvf bash-5.2.21.tar.gz

cd bash-5.2.21

patch -Np1 -i ../bash-5.2.21-upstream_fixes-1.patch

./configure --prefix=/usr             \
            --without-bash-malloc     \
            --with-installed-readline \
            --docdir=/usr/share/doc/bash-5.2.21

make

chown -R tester .

su -s /usr/bin/expect tester << "EOF"
set timeout -1
spawn make tests
expect eof
lassign [wait] _ _ _ value
exit $value
EOF

make install

cd /sources

rm -rf bash-5.2.21

