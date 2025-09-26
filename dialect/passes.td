def ConvertAreyToLLVMPass : Pass<"arey-to-llvm">{
  let summary = "Arey to LLVM";

  let dependentDialects = [ "::mlir::scf::SCFDialect", "::mlir::memref::MemRefDialect", "mlir::arith::ArithDialect", "mlir::LLVM::LLVMDialect", "mlir::func::FuncDialect"];

}

def RemoveAreyPass : Pass<"remove-arey">{
  let summary = "Remove Arey Ops";

  let dependentDialects = [ "AreyDialect", "::mlir::scf::SCFDialect", "::mlir::memref::MemRefDialect", "mlir::arith::ArithDialect", "mlir::func::FuncDialect", "mlir::LLVM::LLVMDialect"];

}