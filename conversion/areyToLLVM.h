#ifndef AREY_TO_LLVM
#define AREY_TO_LLVM

#include "mlir/Pass/Pass.h"

#include "includes/areyDialect.h"

namespace mlir {
    namespace arey {
        std::unique_ptr<mlir::Pass> createConvertAreyToLLVMPass();
    }
}



#endif