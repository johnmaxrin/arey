#include "mlir/IR/Builders.h"
#include "mlir/IR/Dialect.h"
#include "mlir/IR/Attributes.h"
#include "mlir/IR/Operation.h"
#include "mlir/IR/BuiltinOps.h"
#include "mlir/IR/MLIRContext.h"
#include "mlir/Support/FileUtilities.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/CommandLine.h"
#include "mlir/Parser/Parser.h"
#include "mlir/Dialect/DLTI/DLTI.h"

#include <iostream>

#include "mlir/Dialect/MemRef/IR/MemRef.h"
#include "mlir/Dialect/Arith/IR/Arith.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/Affine/IR/AffineOps.h"
#include "mlir/Dialect/OpenMP/OpenMPDialect.h"

using namespace std;
using namespace mlir;

#include "includes/areyDialect.h"
#include "includes/areyOps.h"
#include "conversion/areyToLLVM.h"
#include "conversion/removeArey.h"
#include "mlir/Pass/PassManager.h"

int main(int argc, char *argv[])
{
    mlir::DialectRegistry registry;
    registry.insert<mlir::func::FuncDialect>();
    registry.insert<mlir::memref::MemRefDialect>();
    registry.insert<mlir::arith::ArithDialect>();
    registry.insert<mlir::affine::AffineDialect>();
    registry.insert<mlir::LLVM::LLVMDialect>();
    registry.insert<mlir::arey::AreyDialect>();
    registry.insert<mlir::omp::OpenMPDialect>();

    MLIRContext context;
    context.appendDialectRegistry(registry);
    context.allowUnregisteredDialects();

    llvm::cl::opt<std::string> inpFileName(llvm::cl::Positional, llvm::cl::desc("<MLIR INP File>"), llvm::cl::Required);
    llvm::cl::ParseCommandLineOptions(argc, argv, "CL Parser\n");

    std::string errorMsg;
    auto mlirFile = mlir::openInputFile(inpFileName, &errorMsg);

    if (!mlirFile)
    {
        llvm::errs() << "Failed to open file: " << errorMsg << "\n";
        return 1;
    }

    llvm::SourceMgr sourceMgr;

    sourceMgr.AddNewSourceBuffer(std::move(mlirFile), llvm::SMLoc());

    OwningOpRef<ModuleOp> module = mlir::parseSourceFile<mlir::ModuleOp>(sourceMgr, &context);

    if (!module)
    {
        llvm::errs() << "Failed to parse the MLIR file.\n";
        return 2;
    }


    mlir::PassManager pm(&context);
    //pm.addPass(mlir::arey::createConvertAreyToLLVMPass());
    pm.addPass(mlir::arey::createRemoveAreyPass());

    if (failed(pm.run(module->getOperation()))) {
        llvm::errs() << "Failed to run passes\n";
        return 1;
    }


    module->dump();
    return 0;
}