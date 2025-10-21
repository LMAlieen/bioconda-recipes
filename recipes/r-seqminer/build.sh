#!/bin/bash

set -ex

export R_HOME=$PREFIX/lib/R
export R_LIBS=$PREFIX/lib/R/library
export R_LIBS_USER=$R_LIBS

export CFLAGS="-I$PREFIX/include -fPIC -O2"
export CXXFLAGS="$CFLAGS"
export LDFLAGS="-L$PREFIX/lib -Wl,-rpath,$PREFIX/lib"

if [[ "$target_platform" == "linux-aarch64" ]]; then
    export CFLAGS="$CFLAGS -march=armv8-a+crc -mtune=generic"
    export CXXFLAGS="$CXXFLAGS -march=armv8-a+crc -mtune=generic"
fi

export PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH

export HTSLIB_LIBRARY_DIR=$PREFIX/lib
export HTSLIB_INCLUDE_DIR=$PREFIX/include
export CPPFLAGS="-I$PREFIX/include $CPPFLAGS"

mkdir -p $R_LIBS

$R CMD INSTALL . --build --configure-args="--with-htslib=$PREFIX"

