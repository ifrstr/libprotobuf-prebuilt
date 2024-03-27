#!/bin/bash

set -euxo pipefail

mkdir -p protobuf/cmake/build
cd protobuf/cmake/build

(test -n "${LIBPROTOBUF_PREBUILT_GENERATE_ARGS}" && readarray -t generate_args < <(xargs printf '%s\n' <<<"${LIBPROTOBUF_PREBUILT_GENERATE_ARGS}")) || generate_args=()
(test -n "${LIBPROTOBUF_PREBUILT_BUILD_ARGS}" && readarray -t build_args < <(xargs printf '%s\n' <<<"${LIBPROTOBUF_PREBUILT_BUILD_ARGS}")) || build_args=()

declare -p generate_args
declare -p build_args

cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_STANDARD=23 -DCMAKE_CXX_STANDARD=23 -Dprotobuf_BUILD_TESTS=OFF -DABSL_BUILD_TESTING=OFF -DABSL_USE_GOOGLETEST_HEAD=OFF -DABSL_PROPAGATE_CXX_STD=ON -Dprotobuf_WITH_ZLIB=OFF -DCMAKE_MESSAGE_LOG_LEVEL=VERBOSE -DCMAKE_INSTALL_PREFIX=. "${generate_args[@]}" ../..
cmake --build . --config Release "${build_args[@]}"
cmake --install . --config Release

cd ../../..
