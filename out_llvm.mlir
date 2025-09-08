module {
  llvm.mlir.global internal constant @"hi\00"("hi\00") {addr_space = 0 : i32}
  llvm.func @printf(!llvm.ptr, ...) -> i32
  llvm.mlir.global internal constant @print_format("%d\0A\00") {addr_space = 0 : i32}
  llvm.func @matmul(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr, %arg4: !llvm.ptr, %arg5: i64, %arg6: i64, %arg7: i64, %arg8: i64, %arg9: i64, %arg10: !llvm.ptr, %arg11: !llvm.ptr, %arg12: i64, %arg13: i64, %arg14: i64, %arg15: i64, %arg16: i64, %arg17: !llvm.ptr, %arg18: !llvm.ptr, %arg19: i64, %arg20: i64, %arg21: i64, %arg22: i64, %arg23: i64) {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.insertvalue %arg17, %0[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %2 = llvm.insertvalue %arg18, %1[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.insertvalue %arg19, %2[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.insertvalue %arg20, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.insertvalue %arg22, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %6 = llvm.insertvalue %arg21, %5[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %7 = llvm.insertvalue %arg23, %6[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %8 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %9 = llvm.insertvalue %arg10, %8[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %10 = llvm.insertvalue %arg11, %9[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %11 = llvm.insertvalue %arg12, %10[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %12 = llvm.insertvalue %arg13, %11[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %13 = llvm.insertvalue %arg15, %12[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %14 = llvm.insertvalue %arg14, %13[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %15 = llvm.insertvalue %arg16, %14[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %16 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %17 = llvm.insertvalue %arg3, %16[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %18 = llvm.insertvalue %arg4, %17[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %19 = llvm.insertvalue %arg5, %18[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %20 = llvm.insertvalue %arg6, %19[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %21 = llvm.insertvalue %arg8, %20[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %22 = llvm.insertvalue %arg7, %21[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %23 = llvm.insertvalue %arg9, %22[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %24 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %25 = llvm.sext %arg0 : i32 to i64
    %26 = llvm.sext %arg1 : i32 to i64
    %27 = llvm.sext %arg2 : i32 to i64
    %28 = llvm.mlir.constant(0 : i32) : i32
    %29 = llvm.mlir.constant(1 : i32) : i32
    %30 = llvm.mlir.addressof @print_format : !llvm.ptr
    %31 = llvm.getelementptr %30[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i8>
    %32 = llvm.call @printf(%31) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr) -> i32
    %33 = llvm.mlir.constant(0 : i32) : i32
    %34 = llvm.mlir.constant(1 : i32) : i32
    %35 = llvm.mlir.addressof @"hi\00" : !llvm.ptr
    %36 = llvm.getelementptr %35[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<3 x i8>
    %37 = llvm.call @printf(%36) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr) -> i32
    %38 = llvm.mlir.constant(0 : index) : i64
    %39 = llvm.mlir.constant(1000 : index) : i64
    %40 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb1(%38 : i64)
  ^bb1(%41: i64):  // 2 preds: ^bb0, ^bb8
    %42 = llvm.icmp "slt" %41, %39 : i64
    llvm.cond_br %42, ^bb2, ^bb9
  ^bb2:  // pred: ^bb1
    %43 = llvm.mlir.constant(0 : index) : i64
    %44 = llvm.mlir.constant(1000 : index) : i64
    %45 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb3(%43 : i64)
  ^bb3(%46: i64):  // 2 preds: ^bb2, ^bb7
    %47 = llvm.icmp "slt" %46, %44 : i64
    llvm.cond_br %47, ^bb4, ^bb8
  ^bb4:  // pred: ^bb3
    %48 = llvm.extractvalue %7[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %49 = llvm.mlir.constant(128 : index) : i64
    %50 = llvm.mul %41, %49 : i64
    %51 = llvm.add %50, %46 : i64
    %52 = llvm.getelementptr %48[%51] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %24, %52 : f32, !llvm.ptr
    %53 = llvm.mlir.constant(0 : index) : i64
    %54 = llvm.mlir.constant(1000 : index) : i64
    %55 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb5(%53 : i64)
  ^bb5(%56: i64):  // 2 preds: ^bb4, ^bb6
    %57 = llvm.icmp "slt" %56, %54 : i64
    llvm.cond_br %57, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    %58 = llvm.extractvalue %23[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %59 = llvm.mlir.constant(128 : index) : i64
    %60 = llvm.mul %41, %59 : i64
    %61 = llvm.add %60, %56 : i64
    %62 = llvm.getelementptr %58[%61] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %63 = llvm.load %62 : !llvm.ptr -> f32
    %64 = llvm.extractvalue %15[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %65 = llvm.mlir.constant(128 : index) : i64
    %66 = llvm.mul %56, %65 : i64
    %67 = llvm.add %66, %46 : i64
    %68 = llvm.getelementptr %64[%67] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %69 = llvm.load %68 : !llvm.ptr -> f32
    %70 = llvm.fmul %63, %69  : f32
    %71 = llvm.extractvalue %7[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %72 = llvm.mlir.constant(128 : index) : i64
    %73 = llvm.mul %41, %72 : i64
    %74 = llvm.add %73, %46 : i64
    %75 = llvm.getelementptr %71[%74] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %76 = llvm.load %75 : !llvm.ptr -> f32
    %77 = llvm.fadd %76, %70  : f32
    %78 = llvm.extractvalue %7[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %79 = llvm.mlir.constant(128 : index) : i64
    %80 = llvm.mul %41, %79 : i64
    %81 = llvm.add %80, %46 : i64
    %82 = llvm.getelementptr %78[%81] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %77, %82 : f32, !llvm.ptr
    %83 = llvm.add %56, %55 : i64
    llvm.br ^bb5(%83 : i64)
  ^bb7:  // pred: ^bb5
    %84 = llvm.add %46, %45 : i64
    llvm.br ^bb3(%84 : i64)
  ^bb8:  // pred: ^bb3
    %85 = llvm.add %41, %40 : i64
    llvm.br ^bb1(%85 : i64)
  ^bb9:  // pred: ^bb1
    llvm.return
  }
}

