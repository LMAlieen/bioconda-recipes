#!/bin/bash

set -ex


export R_HOME=$PREFIX/lib/R
export R_LIBS=$PREFIX/lib/R/library
export R_LIBS_USER=$R_LIBS

export CFLAGS="-I$PREFIX/include -fPIC -O2"
export CXXFLAGS="$CFLAGS -std=c++11"
export LDFLAGS="-L$PREFIX/lib -Wl,-rpath,$PREFIX/lib"

if [[ "$target_platform" == "linux-aarch64" ]]; then
    export CFLAGS="$CFLAGS -march=armv8-a+crc -mtune=generic"
    export CXXFLAGS="$CXXFLAGS -march=armv8-a+crc -mtune=generic"
fi

export PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH

export SQLITE_LIBS="-L$PREFIX/lib -lsqlite3"
export SQLITE_CFLAGS="-I$PREFIX/include"

mkdir -p $R_LIBS


pkg-config --exists sqlite3 || {
    find $PREFIX -name "*sqlite*" | head -10
    exit 1
}


$R CMD INSTALL . --build

