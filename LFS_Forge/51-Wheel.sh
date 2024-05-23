#!/bin/bash

cd /sources

tar -xvf wheel-0.42.0.tar.gz

cd wheel-0.42.0

pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD

pip3 install --no-index --find-links=dist wheel


cd /sources

rm -rf wheel-0.42.0
