
include "mlir/IR/DialectBase.td"
include "mlir/IR/AttrTypeBase.td"
include "mlir/IR/SymbolInterfaces.td"
include "mlir/IR/OpBase.td"
include "mlir/IR/BuiltinAttributes.td"
include "mlir/IR/EnumAttr.td"
include "mlir/Pass/PassBase.td"


def AreyDialect : Dialect {
    let summary = "A dialect for debuging and prototyping";
    let name = "arey";
    let cppNamespace = "mlir::arey";
}

// Operations

class AreyDialectOp<string mnemonic> : Op<AreyDialect, mnemonic>
{
    let summary = "Arey Dialect Operations Class";
}

def PrintOp : Op<AreyDialect, "print">
{
    let summary = "Print Op";
    let assemblyFormat = "attr-dict";
}