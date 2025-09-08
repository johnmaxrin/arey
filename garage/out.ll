; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

@msg = internal constant [14 x i8] c"Debug Here: \0A\00"
@print_format = internal constant [4 x i8] c"%d\0A\00"

declare i32 @printf(ptr, ...)

define void @matmul(i32 %0, i32 %1, i32 %2, ptr %3, ptr %4, i64 %5, i64 %6, i64 %7, i64 %8, i64 %9, ptr %10, ptr %11, i64 %12, i64 %13, i64 %14, i64 %15, i64 %16, ptr %17, ptr %18, i64 %19, i64 %20, i64 %21, i64 %22, i64 %23) {
  %25 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %17, 0
  %26 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %25, ptr %18, 1
  %27 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %26, i64 %19, 2
  %28 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %27, i64 %20, 3, 0
  %29 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %28, i64 %22, 4, 0
  %30 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %29, i64 %21, 3, 1
  %31 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %30, i64 %23, 4, 1
  %32 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %10, 0
  %33 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %32, ptr %11, 1
  %34 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %33, i64 %12, 2
  %35 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %34, i64 %13, 3, 0
  %36 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %35, i64 %15, 4, 0
  %37 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %36, i64 %14, 3, 1
  %38 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %37, i64 %16, 4, 1
  %39 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %3, 0
  %40 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %39, ptr %4, 1
  %41 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %40, i64 %5, 2
  %42 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %41, i64 %6, 3, 0
  %43 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %42, i64 %8, 4, 0
  %44 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %43, i64 %7, 3, 1
  %45 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %44, i64 %9, 4, 1
  %46 = sext i32 %0 to i64
  %47 = sext i32 %1 to i64
  %48 = sext i32 %2 to i64
  %49 = call i32 (ptr, ...) @printf(ptr @print_format)
  %50 = call i32 (ptr, ...) @printf(ptr @msg)
  br label %51

51:                                               ; preds = %91, %24
  %52 = phi i64 [ %92, %91 ], [ 0, %24 ]
  %53 = icmp slt i64 %52, 1000
  br i1 %53, label %54, label %93

54:                                               ; preds = %51
  br label %55

55:                                               ; preds = %89, %54
  %56 = phi i64 [ %90, %89 ], [ 0, %54 ]
  %57 = icmp slt i64 %56, 1000
  br i1 %57, label %58, label %91

58:                                               ; preds = %55
  %59 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %31, 1
  %60 = mul i64 %52, 128
  %61 = add i64 %60, %56
  %62 = getelementptr float, ptr %59, i64 %61
  store float 0.000000e+00, ptr %62, align 4
  br label %63

63:                                               ; preds = %66, %58
  %64 = phi i64 [ %88, %66 ], [ 0, %58 ]
  %65 = icmp slt i64 %64, 1000
  br i1 %65, label %66, label %89

66:                                               ; preds = %63
  %67 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %45, 1
  %68 = mul i64 %52, 128
  %69 = add i64 %68, %64
  %70 = getelementptr float, ptr %67, i64 %69
  %71 = load float, ptr %70, align 4
  %72 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %38, 1
  %73 = mul i64 %64, 128
  %74 = add i64 %73, %56
  %75 = getelementptr float, ptr %72, i64 %74
  %76 = load float, ptr %75, align 4
  %77 = fmul float %71, %76
  %78 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %31, 1
  %79 = mul i64 %52, 128
  %80 = add i64 %79, %56
  %81 = getelementptr float, ptr %78, i64 %80
  %82 = load float, ptr %81, align 4
  %83 = fadd float %82, %77
  %84 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %31, 1
  %85 = mul i64 %52, 128
  %86 = add i64 %85, %56
  %87 = getelementptr float, ptr %84, i64 %86
  store float %83, ptr %87, align 4
  %88 = add i64 %64, 1
  br label %63

89:                                               ; preds = %63
  %90 = add i64 %56, 1
  br label %55

91:                                               ; preds = %55
  %92 = add i64 %52, 1
  br label %51

93:                                               ; preds = %51
  ret void
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
