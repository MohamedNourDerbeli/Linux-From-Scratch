#!/bin/bash

cd /sources

tar -xvf meson-1.3.2.tar.gz 

cd meson-1.3.2

pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD

pip3 install --no-index --find-links dist meson
install -vDm644 data/shell-completions/bash/meson /usr/share/bash-completion/completions/meson
install -vDm644 data/shell-completions/zsh/_meson /usr/share/zsh/site-functions/_meson

cd /sources

rm -rf meson-1.3.2
