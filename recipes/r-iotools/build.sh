#!/bin/bash

set -ex

export R_HOME=$PREFIX/lib/R
export R_LIBS=$PREFIX/lib/R/library
export R_LIBS_USER=$R_LIBS

export CFLAGS="-I$PREFIX/include -fPIC -O2"
export CXXFLAGS="$CFLAGS"
export LDFLAGS="-L$PREFIX/lib -Wl,-rpath,$PREFIX/lib"

#  aarch64 optimization plan
if [[ "$target_platform" == "linux-aarch64" ]]; then
    export CFLAGS="$CFLAGS -march=armv8-a+crc -mtune=generic"
    export CXXFLAGS="$CXXFLAGS -march=armv8-a+crc -mtune=generic"
fi

# set pkg-config path
export PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH

mkdir -p $R_LIBS

# start install
$R CMD INSTALL . --build --configure-args="--with-zlib=$PREFIX --with-bzlib=$PREFIX --with-lzma=$PREFIX"

