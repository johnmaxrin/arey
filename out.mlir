Here
module {
  llvm.mlir.global internal constant @msg("hi\00") {addr_space = 0 : i32}
  llvm.func @printf(!llvm.ptr, ...) -> i32
  llvm.mlir.global internal constant @print_format("%d\0A\00") {addr_space = 0 : i32}
  func.func @matmul(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: memref<?x128xf32>, %arg4: memref<?x128xf32>, %arg5: memref<?x128xf32>) {
    %cst = arith.constant 0.000000e+00 : f32
    %0 = arith.index_cast %arg0 : i32 to index
    %1 = arith.index_cast %arg1 : i32 to index
    %2 = arith.index_cast %arg2 : i32 to index
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.mlir.addressof @print_format : !llvm.ptr
    %6 = llvm.getelementptr %5[%3, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<4 x i8>
    %7 = llvm.call @printf(%6) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr) -> i32
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.mlir.constant(1 : i32) : i32
    %10 = llvm.mlir.addressof @msg : !llvm.ptr
    %11 = llvm.getelementptr %10[%8, %8] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<3 x i8>
    %12 = llvm.call @printf(%11) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr) -> i32
    affine.for %arg6 = 0 to 1000 {
      affine.for %arg7 = 0 to 1000 {
        affine.store %cst, %arg5[%arg6, %arg7] : memref<?x128xf32>
        affine.for %arg8 = 0 to 1000 {
          %13 = affine.load %arg3[%arg6, %arg8] : memref<?x128xf32>
          %14 = affine.load %arg4[%arg8, %arg7] : memref<?x128xf32>
          %15 = arith.mulf %13, %14 : f32
          %16 = affine.load %arg5[%arg6, %arg7] : memref<?x128xf32>
          %17 = arith.addf %16, %15 : f32
          affine.store %17, %arg5[%arg6, %arg7] : memref<?x128xf32>
        }
      }
    }
    return
  }
}
