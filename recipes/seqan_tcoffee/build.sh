#!/bin/bash

mkdir -p $PREFIX/bin

mkdir -p build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_POLICY_VERSION_MINIMUM=3.5

make seqan_tcoffee
cp bin/seqan_tcoffee $PREFIX/bin
chmod +x $PREFIX/bin/seqan_tcoffee
