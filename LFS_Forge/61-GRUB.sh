#!/bin/bash

cd /sources

tar -xvf freetype-2.13.2.tar.xz
tar -xvf harfbuzz-8.3.0.tar.xz 
tar -xvf mandoc-1.14.6.tar.gz
tar -xvf efivar-39.tar.gz 
tar -xvf popt-1.19.tar.gz
tar -xvf efibootmgr-18.tar.gz 
tar -xvf grub-2.12.tar.xz

cd freetype-2.13.2

tar -xf ../freetype-doc-2.13.2.tar.xz --strip-components=2 -C docs

sed -ri "s:.*(AUX_MODULES.*valid):\1:" modules.cfg &&

sed -r "s:.*(#.*SUBPIXEL_RENDERING) .*:\1:" \
    -i include/freetype/config/ftoption.h  &&

./configure --prefix=/usr --enable-freetype-config --disable-static &&
make

make install

cp -v -R docs -T /usr/share/doc/freetype-2.13.2 &&
rm -v /usr/share/doc/freetype-2.13.2/freetype-config.1

cd /sources


cd harfbuzz-8.3.0

mkdir build &&
cd    build &&

meson setup ..            \
      --prefix=/usr       \
      --buildtype=release  &&
ninja

ninja install

cd /sources/freetype-2.13.2

sed -ri "s:.*(AUX_MODULES.*valid):\1:" modules.cfg &&

sed -r "s:.*(#.*SUBPIXEL_RENDERING) .*:\1:" \
    -i include/freetype/config/ftoption.h  &&

./configure --prefix=/usr --enable-freetype-config --disable-static &&
make

make install

cp -v -R docs -T /usr/share/doc/freetype-2.13.2 &&
rm -v /usr/share/doc/freetype-2.13.2/freetype-config.1

cd /sources

cd mandoc-1.14.6

./configure &&
make mandoc

install -vm755 mandoc   /usr/bin &&
install -vm644 mandoc.1 /usr/share/man/man1

cd /sources 

cd efivar-39

make

make install LIBDIR=/usr/lib

cd /sources 


cd popt-1.19

./configure --prefix=/usr --disable-static &&
make

make install

cd /sources 

cd efibootmgr-18

make EFIDIR=LFS EFI_LOADER=grubx64.efi

make install EFIDIR=LFS

cd /sources 

cd grub-2.12

mkdir -pv /usr/share/fonts/unifont &&
gunzip -c ../unifont-15.1.04.pcf.gz > /usr/share/fonts/unifont/unifont.pcf

unset {C,CPP,CXX,LD}FLAGS

echo depends bli part_gpt > grub-core/extra_deps.lst

./configure --prefix=/usr        \
            --sysconfdir=/etc    \
            --disable-efiemu     \
            --enable-grub-mkfont \
            --with-platform=efi  \
            --target=x86_64      \
            --disable-werror     &&
unset TARGET_CC &&
make

make install &&
mv -v /etc/bash_completion.d/grub /usr/share/bash-completion/completions

cd /sources

rm -rf grub-2.12 efibootmgr-18 popt-1.19 efivar-39 freetype-2.13.2 harfbuzz-8.3.0 mandoc-1.14.6
