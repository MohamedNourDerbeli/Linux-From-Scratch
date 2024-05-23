#!/bin/bash

cd /sources

tar -xvf flit_core-3.9.0.tar.gz

cd flit_core-3.9.0

pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD

pip3 install --no-index --no-user --find-links dist flit_core

cd /sources

rm -rf flit_core-3.9.0
