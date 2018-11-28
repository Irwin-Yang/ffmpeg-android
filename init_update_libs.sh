#!/bin/bash

echo "============================================"
echo "Updating submodules"
git submodule update --init
echo "============================================"
echo "Updating libpng, expat and fribidi"
rm -rf libpng-*
rm -rf expat-*
rm -rf fribidi-*
rm -rf lame-*

wget -O- ftp://ftp.simplesystems.org/pub/libpng/png/src/libpng16/libpng-1.6.34.tar.xz | tar xJ
wget -O- http://downloads.sourceforge.net/project/expat/expat/2.1.0/expat-2.1.0.tar.gz | tar xz
wget -O- https://github.com/fribidi/fribidi/releases/download/v1.0.5/fribidi-1.0.5.tar.bz2 | tar xj
wget -O- http://sourceforge.net/projects/lame/files/lame/3.99/lame-3.99.5.tar.gz | tar xz
echo "============================================"
