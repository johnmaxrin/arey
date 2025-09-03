set(LLVM_TARGET_DEFINITIONS dialect.td)
mlir_tablegen(Dialect.h.inc -gen-dialect-decls -dialect=arey)
mlir_tablegen(Dialect.cpp.inc -gen-dialect-defs -dialect=arey)
mlir_tablegen(Ops.h.inc -gen-op-decls)
mlir_tablegen(Ops.cpp.inc -gen-op-defs)
mlir_tablegen(Passes.h.inc -gen-pass-decls)

add_public_tablegen_target(MLIRAreyDialectIncGen)
