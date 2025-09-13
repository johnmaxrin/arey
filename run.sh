#!/bin/bash
set -e  # Exit immediately if any command fails

cd build
make -j$(nproc)
cd ..

./build/bin/app testcases/gemm.mlir 2>out.mlir
# ./build/bin/app testcases/input.mlir 2>out2.mlir