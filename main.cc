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



using namespace std;
using namespace mlir;





int main(int argc, char *argv[])
{
    

    MLIRContext context;
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

    // OwningOpRef<ModuleOp> module2 = ModuleOp::create(UnknownLoc::get(&context));
    OwningOpRef<ModuleOp> module = mlir::parseSourceFile<mlir::ModuleOp>(sourceMgr, &context);

   

    if (!module) {
        llvm::errs() << "Failed to parse the MLIR file.\n";
        return 2;
    }
    



    module->dump();


    return 0;
}