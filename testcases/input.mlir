module attributes {avial.target_devices = [#dlti.target_device_spec<"type" = "node", "arch" = "x86">, #dlti.target_device_spec<"type" = "node", "arch" = "x86">]} {
  llvm.func @MPI_Barrier(i32) -> i32
  llvm.func @MPI_Comm_size(i32, !llvm.ptr) -> i32
  llvm.func @MPI_Comm_rank(i32, !llvm.ptr) -> i32
  llvm.func @MPI_Init(!llvm.ptr, !llvm.ptr) -> i32
  llvm.func @testFunc(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr, %arg4: !llvm.ptr, %arg5: i64, %arg6: i64, %arg7: i64, %arg8: i64, %arg9: i64, %arg10: !llvm.ptr, %arg11: !llvm.ptr, %arg12: i64, %arg13: i64, %arg14: i64, %arg15: i64, %arg16: i64, %arg17: !llvm.ptr, %arg18: !llvm.ptr, %arg19: i64, %arg20: i64, %arg21: i64, %arg22: i64, %arg23: i64) {
    %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.insertvalue %arg17, %0[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %2 = llvm.insertvalue %arg18, %1[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.insertvalue %arg19, %2[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.insertvalue %arg20, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.insertvalue %arg22, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %6 = llvm.insertvalue %arg21, %5[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %7 = llvm.insertvalue %arg23, %6[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %8 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %9 = llvm.insertvalue %arg10, %8[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %10 = llvm.insertvalue %arg11, %9[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %11 = llvm.insertvalue %arg12, %10[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %12 = llvm.insertvalue %arg13, %11[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %13 = llvm.insertvalue %arg15, %12[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %14 = llvm.insertvalue %arg14, %13[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %15 = llvm.insertvalue %arg16, %14[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %16 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %17 = llvm.insertvalue %arg3, %16[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %18 = llvm.insertvalue %arg4, %17[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %19 = llvm.insertvalue %arg5, %18[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %20 = llvm.insertvalue %arg6, %19[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %21 = llvm.insertvalue %arg8, %20[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %22 = llvm.insertvalue %arg7, %21[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %23 = llvm.insertvalue %arg9, %22[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %24 = llvm.mlir.zero : !llvm.ptr
    %25 = llvm.call @MPI_Init(%24, %24) : (!llvm.ptr, !llvm.ptr) -> i32
    %26 = llvm.mlir.constant(1140850688 : i64) : i64
    %27 = llvm.trunc %26 : i64 to i32
    arep.print %27 : i32
    %28 = llvm.mlir.constant(1 : i32) : i32
    %29 = llvm.alloca %28 x i32 : (i32) -> !llvm.ptr
    %30 = llvm.call @MPI_Comm_rank(%27, %29) : (i32, !llvm.ptr) -> i32
    %31 = llvm.load %29 : !llvm.ptr -> i32
    %32 = llvm.trunc %26 : i64 to i32
    %33 = llvm.mlir.constant(1 : i32) : i32
    %34 = llvm.alloca %33 x i32 : (i32) -> !llvm.ptr
    %35 = llvm.call @MPI_Comm_size(%32, %34) : (i32, !llvm.ptr) -> i32
    %36 = llvm.load %34 : !llvm.ptr -> i32
    %37 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %38 = llvm.sext %arg0 : i32 to i64
    %39 = llvm.sext %arg1 : i32 to i64
    %40 = llvm.sext %arg2 : i32 to i64
    %41 = llvm.mlir.constant(0 : i32) : i32
    %42 = llvm.srem %41, %36 : i32
    %43 = llvm.icmp "eq" %31, %42 : i32
    llvm.cond_br %43, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %44 = llvm.mlir.constant(500 : index) : i64
    %45 = llvm.mlir.constant(1000 : index) : i64
    %46 = llvm.mlir.constant(1 : index) : i64
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg24) : i64 = (%44) to (%45) step (%46) {
          %55 = llvm.mlir.constant(0 : index) : i64
          %56 = llvm.mlir.constant(1000 : index) : i64
          %57 = llvm.mlir.constant(1 : index) : i64
          llvm.br ^bb1(%55 : i64)
        ^bb1(%58: i64):  // 2 preds: ^bb0, ^bb5
          %59 = llvm.icmp "slt" %58, %56 : i64
          llvm.cond_br %59, ^bb2, ^bb6
        ^bb2:  // pred: ^bb1
          %60 = llvm.extractvalue %7[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
          %61 = llvm.mlir.constant(1000 : index) : i64
          %62 = llvm.mul %arg24, %61 overflow<nsw, nuw> : i64
          %63 = llvm.add %62, %58 overflow<nsw, nuw> : i64
          %64 = llvm.getelementptr inbounds|nuw %60[%63] : (!llvm.ptr, i64) -> !llvm.ptr, f32
          llvm.store %37, %64 : f32, !llvm.ptr
          %65 = llvm.mlir.constant(0 : index) : i64
          %66 = llvm.mlir.constant(1000 : index) : i64
          %67 = llvm.mlir.constant(1 : index) : i64
          llvm.br ^bb3(%65 : i64)
        ^bb3(%68: i64):  // 2 preds: ^bb2, ^bb4
          %69 = llvm.icmp "slt" %68, %66 : i64
          llvm.cond_br %69, ^bb4, ^bb5
        ^bb4:  // pred: ^bb3
          %70 = llvm.extractvalue %23[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
          %71 = llvm.mlir.constant(1000 : index) : i64
          %72 = llvm.mul %arg24, %71 overflow<nsw, nuw> : i64
          %73 = llvm.add %72, %68 overflow<nsw, nuw> : i64
          %74 = llvm.getelementptr inbounds|nuw %70[%73] : (!llvm.ptr, i64) -> !llvm.ptr, f32
          %75 = llvm.load %74 : !llvm.ptr -> f32
          %76 = llvm.extractvalue %15[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
          %77 = llvm.mlir.constant(1000 : index) : i64
          %78 = llvm.mul %68, %77 overflow<nsw, nuw> : i64
          %79 = llvm.add %78, %58 overflow<nsw, nuw> : i64
          %80 = llvm.getelementptr inbounds|nuw %76[%79] : (!llvm.ptr, i64) -> !llvm.ptr, f32
          %81 = llvm.load %80 : !llvm.ptr -> f32
          %82 = llvm.fmul %75, %81 : f32
          %83 = llvm.extractvalue %7[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
          %84 = llvm.mlir.constant(1000 : index) : i64
          %85 = llvm.mul %arg24, %84 overflow<nsw, nuw> : i64
          %86 = llvm.add %85, %58 overflow<nsw, nuw> : i64
          %87 = llvm.getelementptr inbounds|nuw %83[%86] : (!llvm.ptr, i64) -> !llvm.ptr, f32
          %88 = llvm.load %87 : !llvm.ptr -> f32
          %89 = llvm.fadd %88, %82 : f32
          %90 = llvm.extractvalue %7[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
          %91 = llvm.mlir.constant(1000 : index) : i64
          %92 = llvm.mul %arg24, %91 overflow<nsw, nuw> : i64
          %93 = llvm.add %92, %58 overflow<nsw, nuw> : i64
          %94 = llvm.getelementptr inbounds|nuw %90[%93] : (!llvm.ptr, i64) -> !llvm.ptr, f32
          llvm.store %89, %94 : f32, !llvm.ptr
          %95 = llvm.add %68, %67 : i64
          llvm.br ^bb3(%95 : i64)
        ^bb5:  // pred: ^bb3
          %96 = llvm.add %58, %57 : i64
          llvm.br ^bb1(%96 : i64)
        ^bb6:  // pred: ^bb1
          omp.yield
        }
      }
      omp.terminator
    }
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %47 = llvm.mlir.constant(1 : i32) : i32
    %48 = llvm.srem %47, %36 : i32
    %49 = llvm.icmp "eq" %31, %48 : i32
    llvm.cond_br %49, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    %50 = llvm.mlir.constant(0 : index) : i64
    %51 = llvm.mlir.constant(500 : index) : i64
    %52 = llvm.mlir.constant(1 : index) : i64
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg24) : i64 = (%50) to (%51) step (%52) {
          %55 = llvm.mlir.constant(0 : index) : i64
          %56 = llvm.mlir.constant(1000 : index) : i64
          %57 = llvm.mlir.constant(1 : index) : i64
          llvm.br ^bb1(%55 : i64)
        ^bb1(%58: i64):  // 2 preds: ^bb0, ^bb5
          %59 = llvm.icmp "slt" %58, %56 : i64
          llvm.cond_br %59, ^bb2, ^bb6
        ^bb2:  // pred: ^bb1
          %60 = llvm.extractvalue %7[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
          %61 = llvm.mlir.constant(1000 : index) : i64
          %62 = llvm.mul %arg24, %61 overflow<nsw, nuw> : i64
          %63 = llvm.add %62, %58 overflow<nsw, nuw> : i64
          %64 = llvm.getelementptr inbounds|nuw %60[%63] : (!llvm.ptr, i64) -> !llvm.ptr, f32
          llvm.store %37, %64 : f32, !llvm.ptr
          %65 = llvm.mlir.constant(0 : index) : i64
          %66 = llvm.mlir.constant(1000 : index) : i64
          %67 = llvm.mlir.constant(1 : index) : i64
          llvm.br ^bb3(%65 : i64)
        ^bb3(%68: i64):  // 2 preds: ^bb2, ^bb4
          %69 = llvm.icmp "slt" %68, %66 : i64
          llvm.cond_br %69, ^bb4, ^bb5
        ^bb4:  // pred: ^bb3
          %70 = llvm.extractvalue %23[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
          %71 = llvm.mlir.constant(1000 : index) : i64
          %72 = llvm.mul %arg24, %71 overflow<nsw, nuw> : i64
          %73 = llvm.add %72, %68 overflow<nsw, nuw> : i64
          %74 = llvm.getelementptr inbounds|nuw %70[%73] : (!llvm.ptr, i64) -> !llvm.ptr, f32
          %75 = llvm.load %74 : !llvm.ptr -> f32
          %76 = llvm.extractvalue %15[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
          %77 = llvm.mlir.constant(1000 : index) : i64
          %78 = llvm.mul %68, %77 overflow<nsw, nuw> : i64
          %79 = llvm.add %78, %58 overflow<nsw, nuw> : i64
          %80 = llvm.getelementptr inbounds|nuw %76[%79] : (!llvm.ptr, i64) -> !llvm.ptr, f32
          %81 = llvm.load %80 : !llvm.ptr -> f32
          %82 = llvm.fmul %75, %81 : f32
          %83 = llvm.extractvalue %7[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
          %84 = llvm.mlir.constant(1000 : index) : i64
          %85 = llvm.mul %arg24, %84 overflow<nsw, nuw> : i64
          %86 = llvm.add %85, %58 overflow<nsw, nuw> : i64
          %87 = llvm.getelementptr inbounds|nuw %83[%86] : (!llvm.ptr, i64) -> !llvm.ptr, f32
          %88 = llvm.load %87 : !llvm.ptr -> f32
          %89 = llvm.fadd %88, %82 : f32
          %90 = llvm.extractvalue %7[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
          %91 = llvm.mlir.constant(1000 : index) : i64
          %92 = llvm.mul %arg24, %91 overflow<nsw, nuw> : i64
          %93 = llvm.add %92, %58 overflow<nsw, nuw> : i64
          %94 = llvm.getelementptr inbounds|nuw %90[%93] : (!llvm.ptr, i64) -> !llvm.ptr, f32
          llvm.store %89, %94 : f32, !llvm.ptr
          %95 = llvm.add %68, %67 : i64
          llvm.br ^bb3(%95 : i64)
        ^bb5:  // pred: ^bb3
          %96 = llvm.add %58, %57 : i64
          llvm.br ^bb1(%96 : i64)
        ^bb6:  // pred: ^bb1
          omp.yield
        }
      }
      omp.terminator
    }
    llvm.br ^bb4
  ^bb4:  // 2 preds: ^bb2, ^bb3
    %53 = llvm.trunc %26 : i64 to i32
    %54 = llvm.call @MPI_Barrier(%53) : (i32) -> i32
    llvm.return
  }
}


