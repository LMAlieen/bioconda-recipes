#!/bin/bash

set -ex

export R_LIBS="${PREFIX}/lib/R/library"

if [[ "${target_platform}" == linux-aarch64 ]]; then
    export CFLAGS="${CFLAGS} -march=armv8-a+crc+crypto -mtune=generic"
    export CXXFLAGS="${CXXFLAGS} -march=armv8-a+crc+crypto -mtune=generic"
    export FFLAGS="${FFLAGS} -march=armv8-a+crc+crypto -mtune=generic"
    export FCFLAGS="${FCFLAGS} -march=armv8-a+crc+crypto -mtune=generic"
    
    mkdir -p ${R_LIBS}
    
    export BLAS_LIBS="-L${PREFIX}/lib -lopenblas"
    export LAPACK_LIBS="-L${PREFIX}/lib -lopenblas"
fi

export BLAS="-lopenblas"
export LAPACK="-lopenblas"

cd "${SRC_DIR}"

cat > ${PREFIX}/lib/R/etc/Makeconf.aarch64 << EOF
# BLAS and LAPACK settings for aarch64
BLAS_LIBS = ${BLAS_LIBS}
LAPACK_LIBS = ${LAPACK_LIBS}
EOF

${R} CMD INSTALL . --build --configure-args="--with-blas --with-lapack" || exit 1

