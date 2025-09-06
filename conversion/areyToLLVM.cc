#include "mlir/Dialect/SCF/IR/SCF.h"
#include "mlir/Dialect/MemRef/IR/MemRef.h"
#include "mlir/Dialect/Arith/IR/Arith.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"


#include "areyToLLVM.h"
#include "dialect/Passes.h.inc"

using namespace mlir;
using namespace mlir::arey;

namespace{
    #define GEN_PASS_DEF_CONVERTAREYTOLLVMPASS
    #include "dialect/Passes.h.inc"

    struct ConvertAreyToLLVMPass
        : public impl::ConvertAreyToLLVMPassBase<ConvertAreyToLLVMPass>
        {
            using ConvertAreyToLLVMPassBase::ConvertAreyToLLVMPassBase;

            void runOnOperation() override {
                llvm::errs() << "Hello";
            }
        };
}

std::unique_ptr<mlir::Pass> mlir::arey::createConvertAreyToLLVMPass() {
  return std::make_unique<ConvertAreyToLLVMPass>();
}