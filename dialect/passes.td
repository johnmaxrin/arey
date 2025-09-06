def ConvertAreyToLLVMPass : Pass<"arey-to-llvm">{
  let summary = "Arey to LLVM";

  let dependentDialects = [ "::mlir::scf::SCFDialect", "::mlir::memref::MemRefDialect", "mlir::arith::ArithDialect", "mlir::LLVM::LLVMDialect", "mlir::func::FuncDialect"];

}