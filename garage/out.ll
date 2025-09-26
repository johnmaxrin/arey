; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

@msg = internal constant [3 x i8] c"Hi\00"
@assertMsg = internal constant [18 x i8] c"Assertion Failed!\0A"

declare i32 @abort()

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
  %49 = icmp eq i32 %0, 1000
  br i1 %49, label %50, label %95

50:                                               ; preds = %24
  br label %51

51:                                               ; preds = %92, %50
  %52 = phi i64 [ %93, %92 ], [ 0, %50 ]
  %53 = icmp slt i64 %52, 128
  br i1 %53, label %54, label %94

54:                                               ; preds = %51
  %55 = call i32 (ptr, ...) @printf(ptr @msg)
  br label %56

56:                                               ; preds = %90, %54
  %57 = phi i64 [ %91, %90 ], [ 0, %54 ]
  %58 = icmp slt i64 %57, 128
  br i1 %58, label %59, label %92

59:                                               ; preds = %56
  %60 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %31, 1
  %61 = mul i64 %52, 128
  %62 = add i64 %61, %57
  %63 = getelementptr float, ptr %60, i64 %62
  store float 0.000000e+00, ptr %63, align 4
  br label %64

64:                                               ; preds = %67, %59
  %65 = phi i64 [ %89, %67 ], [ 0, %59 ]
  %66 = icmp slt i64 %65, 128
  br i1 %66, label %67, label %90

67:                                               ; preds = %64
  %68 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %45, 1
  %69 = mul i64 %52, 128
  %70 = add i64 %69, %65
  %71 = getelementptr float, ptr %68, i64 %70
  %72 = load float, ptr %71, align 4
  %73 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %38, 1
  %74 = mul i64 %65, 128
  %75 = add i64 %74, %57
  %76 = getelementptr float, ptr %73, i64 %75
  %77 = load float, ptr %76, align 4
  %78 = fmul float %72, %77
  %79 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %31, 1
  %80 = mul i64 %52, 128
  %81 = add i64 %80, %57
  %82 = getelementptr float, ptr %79, i64 %81
  %83 = load float, ptr %82, align 4
  %84 = fadd float %83, %78
  %85 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %31, 1
  %86 = mul i64 %52, 128
  %87 = add i64 %86, %57
  %88 = getelementptr float, ptr %85, i64 %87
  store float %84, ptr %88, align 4
  %89 = add i64 %65, 1
  br label %64

90:                                               ; preds = %64
  %91 = add i64 %57, 1
  br label %56

92:                                               ; preds = %56
  %93 = add i64 %52, 1
  br label %51

94:                                               ; preds = %51
  ret void

95:                                               ; preds = %24
  %96 = call i32 (ptr, ...) @printf(ptr @assertMsg)
  %97 = call i32 @abort()
  unreachable
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
