#ifndef AREY_TO_LLVM
#define AREY_TO_LLVM


#include "mlir/Dialect/SCF/IR/SCF.h"
#include "mlir/Dialect/MemRef/IR/MemRef.h"
#include "mlir/Dialect/Arith/IR/Arith.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"

#include "mlir/Transforms/DialectConversion.h"
#include "mlir/Conversion/LLVMCommon/ConversionTarget.h"

#include "includes/areyOps.h"


#include "mlir/Pass/Pass.h"

#include "includes/areyDialect.h"

namespace mlir {
    namespace arey {
        std::unique_ptr<mlir::Pass> createConvertAreyToLLVMPass();
    }
}



#endif