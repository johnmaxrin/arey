#include "includes/areyDialect.h"
#include "includes/areyOps.h"



#include "mlir/IR/BuiltinOps.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/Attributes.h"

#include "dialect/Dialect.cpp.inc"

#include "llvm/ADT/TypeSwitch.h"
#include "mlir/IR/Builders.h"



#define GET_OP_CLASSES
#include "dialect/Ops.cpp.inc"


namespace mlir
{
    namespace arey
    {

        void AreyDialect::initialize()
        {

            addOperations<
                #define GET_OP_LIST
                #include "dialect/Ops.cpp.inc"
                >();
        }

    }

}