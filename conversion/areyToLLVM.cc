
#include "areyToLLVM.h"
#include "dialect/Passes.h.inc"

using namespace mlir;
using namespace mlir::arey;


struct ConvertPrintToLLVM : public OpConversionPattern<PrintOp>
{
    using OpConversionPattern::OpConversionPattern;

    LogicalResult matchAndRewrite(
        PrintOp op, OpAdaptor adaptor,
        ConversionPatternRewriter &rewriter) const override
    {
        rewriter.eraseOp(op);
        return success();
    }
};

struct ConvertPrintStringToLLVM : public OpConversionPattern<PrintStringOp>
{
    using OpConversionPattern::OpConversionPattern;

    LogicalResult matchAndRewrite(
        PrintStringOp op, OpAdaptor adaptor,
        ConversionPatternRewriter &rewriter) const override
    {
        rewriter.eraseOp(op);
        return success();
    }
};

namespace{
    #define GEN_PASS_DEF_CONVERTAREYTOLLVMPASS
    #include "dialect/Passes.h.inc"

    struct ConvertAreyToLLVMPass
        : public impl::ConvertAreyToLLVMPassBase<ConvertAreyToLLVMPass>
        {
            using ConvertAreyToLLVMPassBase::ConvertAreyToLLVMPassBase;

            void runOnOperation() override {
                mlir::MLIRContext *context = &getContext();
                auto *module = getOperation();

                ConversionTarget target(*context);
                target.addIllegalOp<arey::PrintOp>();
                target.addIllegalOp<arey::PrintStringOp>();
                target.markUnknownOpDynamicallyLegal([](Operation *op) { return true; });
            
                
                RewritePatternSet patterns(context);

                patterns.add<ConvertPrintToLLVM, ConvertPrintStringToLLVM>(context);
                if (failed(applyPartialConversion(module, target, std::move(patterns))))
                {
                    signalPassFailure();
                }
                
            }
        };
}

std::unique_ptr<mlir::Pass> mlir::arey::createConvertAreyToLLVMPass() {
  return std::make_unique<ConvertAreyToLLVMPass>();
}