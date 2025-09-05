#!/bin/bash
set -e  # Exit immediately if any command fails

# Step 1: Build the project
cd build
make -j$(nproc)
cd ..

# Step 2: Run the application with the given testcase
./build/bin/app testcases/gemm.mlir
