
include "mlir/IR/DialectBase.td"
include "mlir/IR/AttrTypeBase.td"
include "mlir/IR/SymbolInterfaces.td"
include "mlir/IR/OpBase.td"
include "mlir/IR/BuiltinAttributes.td"
include "mlir/IR/EnumAttr.td"
include "mlir/Pass/PassBase.td"
include "passes.td"


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
    let arguments = (ins AnyType : $printArg);
    let assemblyFormat = "$printArg `:` type($printArg) attr-dict";
}

def PrintStringOp : Op<AreyDialect, "print_str">
{
    let summary = "Print String Op";
    let arguments = (ins StrAttr:$msg);
    let assemblyFormat = "$msg attr-dict";
}

def AssertOp : Op<AreyDialect, "assert">
{
    let summary = "Assert Op";
    let arguments = (ins AnyType: $val1, AnyAttr: $val2);
    let assemblyFormat = "$val1 `:` type($val1) `eq` $val2 attr-dict";
}

def StartTimeOp : Op<AreyDialect, "start_timer">
{
    let summary = "Start Timer Op";
    let arguments = (ins AnyType: $val1, AnyAttr: $val2);
    let assemblyFormat = "$val1 `:` type($val1) `eq` $val2 attr-dict";
}

def StopTimeOp : Op<AreyDialect, "stop_timer">
{
    let summary = "Start Timer Op";
    let arguments = (ins AnyType: $val1, AnyAttr: $val2);
    let assemblyFormat = "$val1 `:` type($val1) `eq` $val2 attr-dict";
}