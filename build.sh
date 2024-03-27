#!/bin/bash

set -euxo pipefail

mkdir -p protobuf/cmake/build
cd protobuf/cmake/build

cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_STANDARD=23 -DCMAKE_CXX_STANDARD=23 -Dprotobuf_BUILD_TESTS=OFF -DABSL_BUILD_TESTING=OFF -DABSL_USE_GOOGLETEST_HEAD=OFF -DABSL_PROPAGATE_CXX_STD=ON -Dprotobuf_WITH_ZLIB=OFF -DCMAKE_MESSAGE_LOG_LEVEL=VERBOSE -DCMAKE_INSTALL_PREFIX=. ${LIBPROTOBUF_PREBUILT_GENERATE_ARG} ../..
cmake --build . --config Release ${LIBPROTOBUF_PREBUILT_BUILD_ARG}
cmake --install . --config Release

cd ../../..
