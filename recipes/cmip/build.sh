#!/usr/bin/env bash

# Create bin dir
mkdir -p $PREFIX/bin

#sed -i "18c CFLAGS = -c $(DEBUG) $(PROFILE) --fallow-argument-mismatch" src90/Makefile 
sed -i "6c OPTIONS = -O3 -ffixed-line-length-132 $(MACH64) $(PARALLEL) $(BINFMT) -mtune=generic -falign-commons -fcray-pointer $(DEBUG) -fallow-argument-mismatch" dist/src/Makefile

# Change to src directory
cd dist/src

# Compile using make
make \
    F77="${FC}" \
    CPP="${CXX}"

# Copy executable to environment bin dir included in the path
chmod u+x cmip watden titration
cp cmip watden titration $PREFIX/bin/

# Change to src90 directory
cd ../../src90
# Compile using make
make \
    F77="${FC}" \
    CPP="${CXX}"

# Copy executable to environment bin dir included in the path
chmod u+x canal avgEpsGrid surfnet2binaryGrid grd2cube getPatch
cp canal avgEpsGrid surfnet2binaryGrid grd2cube getPatch $PREFIX/bin/

cd ..
mkdir -p $PREFIX/share/cmip
cp -r dat dist/tests dist/wrappers dist/scripts $PREFIX/share/cmip/
