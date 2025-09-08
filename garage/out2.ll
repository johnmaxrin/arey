; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

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
  br label %50

50:                                               ; preds = %90, %24
  %51 = phi i64 [ %91, %90 ], [ 0, %24 ]
  %52 = icmp slt i64 %51, 1000
  br i1 %52, label %53, label %92

53:                                               ; preds = %50
  br label %54

54:                                               ; preds = %88, %53
  %55 = phi i64 [ %89, %88 ], [ 0, %53 ]
  %56 = icmp slt i64 %55, 1000
  br i1 %56, label %57, label %90

57:                                               ; preds = %54
  %58 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %31, 1
  %59 = mul i64 %51, 128
  %60 = add i64 %59, %55
  %61 = getelementptr float, ptr %58, i64 %60
  store float 0.000000e+00, ptr %61, align 4
  br label %62

62:                                               ; preds = %65, %57
  %63 = phi i64 [ %87, %65 ], [ 0, %57 ]
  %64 = icmp slt i64 %63, 1000
  br i1 %64, label %65, label %88

65:                                               ; preds = %62
  %66 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %45, 1
  %67 = mul i64 %51, 128
  %68 = add i64 %67, %63
  %69 = getelementptr float, ptr %66, i64 %68
  %70 = load float, ptr %69, align 4
  %71 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %38, 1
  %72 = mul i64 %63, 128
  %73 = add i64 %72, %55
  %74 = getelementptr float, ptr %71, i64 %73
  %75 = load float, ptr %74, align 4
  %76 = fmul float %70, %75
  %77 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %31, 1
  %78 = mul i64 %51, 128
  %79 = add i64 %78, %55
  %80 = getelementptr float, ptr %77, i64 %79
  %81 = load float, ptr %80, align 4
  %82 = fadd float %81, %76
  %83 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %31, 1
  %84 = mul i64 %51, 128
  %85 = add i64 %84, %55
  %86 = getelementptr float, ptr %83, i64 %85
  store float %82, ptr %86, align 4
  %87 = add i64 %63, 1
  br label %62

88:                                               ; preds = %62
  %89 = add i64 %55, 1
  br label %54

90:                                               ; preds = %54
  %91 = add i64 %51, 1
  br label %50

92:                                               ; preds = %50
  ret void
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
