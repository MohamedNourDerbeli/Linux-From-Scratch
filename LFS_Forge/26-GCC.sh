#!/bin/bash

cd /sources

tar -xvf gcc-13.2.0.tar.xz

cd gcc-13.2.0

case $(uname -m) in
  x86_64)
    sed -e '/m64=/s/lib64/lib/' \
        -i.orig gcc/config/i386/t-linux64
  ;;
esac

mkdir -v build
cd       build

../configure --prefix=/usr            \
             LD=ld                    \
             --enable-languages=c,c++ \
             --enable-default-pie     \
             --enable-default-ssp     \
             --disable-multilib       \
             --disable-bootstrap      \
             --disable-fixincludes    \
             --with-system-zlib

make

make install

chown -v -R root:root \
    /usr/lib/gcc/$(gcc -dumpmachine)/13.2.0/include{,-fixed}

ln -svr /usr/bin/cpp /usr/lib

ln -sv gcc.1 /usr/share/man/man1/cc.1

ln -sfv ../../libexec/gcc/$(gcc -dumpmachine)/13.2.0/liblto_plugin.so \
        /usr/lib/bfd-plugins/

# echo 'int main(){}' > dummy.c
# cc dummy.c -v -Wl,--verbose &> dummy.log
# readelf -l a.out | grep ': /lib'

# grep -E -o '/usr/lib.*/S?crt[1in].*succeeded' dummy.log

# grep -B4 '^ /usr/include' dummy.log

# grep 'SEARCH.*/usr/lib' dummy.log |sed 's|; |\n|g'

# grep "/lib.*/libc.so.6 " dummy.log

# grep found dummy.log

# rm -v dummy.c a.out dummy.log

cd /sources

rm -rf gcc-13.2.0
