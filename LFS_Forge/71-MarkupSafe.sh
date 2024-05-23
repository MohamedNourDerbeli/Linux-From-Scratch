#!/bin/bash

cd /sources

tar -xvf MarkupSafe-2.1.5.tar.gz 

cd MarkupSafe-2.1.5

pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD

pip3 install --no-index --no-user --find-links dist Markupsafe

cd /sources

rm -rf MarkupSafe-2.1.5
