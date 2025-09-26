module {
  llvm.mlir.global internal constant @msg("Hi\00") {addr_space = 0 : i32}
  llvm.func @abort() -> i32
  llvm.func @printf(!llvm.ptr, ...) -> i32
  llvm.mlir.global internal constant @assertMsg("Assertion Failed!\0A") {addr_space = 0 : i32}
  func.func @matmul(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: memref<?x128xf32>, %arg4: memref<?x128xf32>, %arg5: memref<?x128xf32>) {
    %cst = arith.constant 0.000000e+00 : f32
    %0 = arith.index_cast %arg0 : i32 to index
    %1 = arith.index_cast %arg1 : i32 to index
    %2 = arith.index_cast %arg2 : i32 to index
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.mlir.addressof @assertMsg : !llvm.ptr
    %6 = llvm.getelementptr %5[%3, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<18 x i8>
    %7 = llvm.mlir.constant(1000 : i64) : i32
    %8 = llvm.icmp "eq" %arg0, %7 : i32
    llvm.cond_br %8, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    affine.for %arg6 = 0 to 128 {
      %11 = llvm.mlir.constant(0 : i32) : i32
      %12 = llvm.mlir.constant(1 : i32) : i32
      %13 = llvm.mlir.addressof @msg : !llvm.ptr
      %14 = llvm.getelementptr %13[%11, %11] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<3 x i8>
      %15 = llvm.call @printf(%14) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr) -> i32
      affine.for %arg7 = 0 to 128 {
        affine.store %cst, %arg5[%arg6, %arg7] : memref<?x128xf32>
        affine.for %arg8 = 0 to 128 {
          %16 = affine.load %arg3[%arg6, %arg8] : memref<?x128xf32>
          %17 = affine.load %arg4[%arg8, %arg7] : memref<?x128xf32>
          %18 = arith.mulf %16, %17 : f32
          %19 = affine.load %arg5[%arg6, %arg7] : memref<?x128xf32>
          %20 = arith.addf %19, %18 : f32
          affine.store %20, %arg5[%arg6, %arg7] : memref<?x128xf32>
        }
      }
    }
    return
  ^bb2:  // pred: ^bb0
    %9 = llvm.call @printf(%6) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr) -> i32
    %10 = llvm.call @abort() : () -> i32
    llvm.unreachable
  }
}
