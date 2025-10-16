#include "mlir/IR/Builders.h"
#include "mlir/IR/Dialect.h"
#include "mlir/IR/Attributes.h"
#include "mlir/IR/Operation.h"
#include "mlir/IR/BuiltinOps.h"
#include "mlir/IR/MLIRContext.h"
#include "mlir/Support/FileUtilities.h"
#include "mlir/Parser/Parser.h"
#include "mlir/Pass/PassManager.h"

#include "llvm/Support/CommandLine.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/ToolOutputFile.h"

#include "mlir/Dialect/DLTI/DLTI.h"
#include "mlir/Dialect/MemRef/IR/MemRef.h"
#include "mlir/Dialect/Arith/IR/Arith.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/Affine/IR/AffineOps.h"
#include "mlir/Dialect/OpenMP/OpenMPDialect.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"

#include "includes/areyDialect.h"
#include "includes/areyOps.h"
#include "conversion/areyToLLVM.h"
#include "conversion/removeArey.h"

using namespace mlir;
using namespace llvm;

int main(int argc, char **argv) {
  // === Command-line options ===
  cl::opt<std::string> inputFilename(cl::Positional,
                                     cl::desc("<input MLIR file>"),
                                     cl::Required);
  cl::opt<std::string> outputFilename("o",
                                      cl::desc("Output file"),
                                      cl::value_desc("filename"),
                                      cl::init("-"));

  cl::opt<bool> runConvertAreyToLLVM("convert-arey-to-llvm",
                                     cl::desc("Run AreyToLLVM conversion pass"));
  cl::opt<bool> runRemoveArey("remove-arey",
                              cl::desc("Run RemoveArey transformation pass"));

  cl::ParseCommandLineOptions(argc, argv, "Arey Dialect Optimizer\n");

  // === Setup MLIR Context and Dialects ===
  DialectRegistry registry;
  registry.insert<mlir::func::FuncDialect,
                  mlir::memref::MemRefDialect,
                  mlir::arith::ArithDialect,
                  mlir::affine::AffineDialect,
                  mlir::LLVM::LLVMDialect,
                  mlir::arey::AreyDialect,
                  mlir::omp::OpenMPDialect>();

  MLIRContext context;
  context.appendDialectRegistry(registry);
  context.allowUnregisteredDialects();

  // === Read Input File ===
  std::string errorMessage;
  auto file = mlir::openInputFile(inputFilename, &errorMessage);
  if (!file) {
    errs() << "Error: failed to open input file '" << inputFilename << "': "
           << errorMessage << "\n";
    return 1;
  }

  llvm::SourceMgr sourceMgr;
  sourceMgr.AddNewSourceBuffer(std::move(file), SMLoc());

  OwningOpRef<ModuleOp> module = parseSourceFile<ModuleOp>(sourceMgr, &context);
  if (!module) {
    errs() << "Error: failed to parse MLIR file\n";
    return 1;
  }

  // === Setup Pass Manager ===
  PassManager pm(&context);

  if (runConvertAreyToLLVM)
    pm.addPass(mlir::arey::createConvertAreyToLLVMPass());

  if (runRemoveArey)
    pm.addPass(mlir::arey::createRemoveAreyPass());

  if (!runConvertAreyToLLVM && !runRemoveArey) {
    outs() << "Warning: no passes specified! Use --help for options.\n";
  }

  // === Run Passes ===
  if (failed(pm.run(module.get()))) {
    errs() << "Error: pass manager failed.\n";
    return 1;
  }

  // === Output Result ===
  std::string errorMessageOut;
  auto output = mlir::openOutputFile(outputFilename, &errorMessageOut);
  if (!output) {
    errs() << "Error: cannot open output file: " << errorMessageOut << "\n";
    return 1;
  }

  module->print(output->os());
  output->keep();

  return 0;
}
