#/bin/bash

cd /sources

tar -xvf iana-etc-20240125.tar.gz

cd iana-etc-20240125

cp services protocols /etc

cd /sources

rm -rf iana-etc-20240125
