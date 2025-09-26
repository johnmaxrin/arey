#include "removeArey.h"
#include "dialect/Passes.h.inc"

using namespace mlir;
using namespace mlir::arey;

struct RemovePrintOp : public OpConversionPattern<PrintOp>
{
    using OpConversionPattern::OpConversionPattern;

    LogicalResult matchAndRewrite(
        PrintOp op, OpAdaptor adaptor, ConversionPatternRewriter &rewriter) const override
    {
        rewriter.eraseOp(op);
        return success();
    }
};


struct RemovePrintStringOp : public OpConversionPattern<PrintStringOp>
{
    using OpConversionPattern::OpConversionPattern;

    LogicalResult matchAndRewrite(
        PrintStringOp op, OpAdaptor adaptor, ConversionPatternRewriter &rewriter) const override
    {
        rewriter.eraseOp(op);
        return success();
    }
};

struct RemoveAssertOp : public OpConversionPattern<AssertOp>
{
    using OpConversionPattern::OpConversionPattern;

    LogicalResult matchAndRewrite(
        AssertOp op, OpAdaptor adaptor, ConversionPatternRewriter &rewriter) const override
    {
        rewriter.eraseOp(op);
        return success();
    }
};

namespace
{
#define GEN_PASS_DEF_REMOVEAREYPASS
#include "dialect/Passes.h.inc"

    struct RemoveAreyPass
        : public impl::RemoveAreyPassBase<RemoveAreyPass>
    {
        using RemoveAreyPassBase::RemoveAreyPassBase;

        void runOnOperation() override
        {
            mlir::MLIRContext *context = &getContext();
            auto *module = getOperation();

            ConversionTarget target(*context);
            target.addIllegalDialect<arey::AreyDialect>();
            target.addLegalDialect<LLVM::LLVMDialect>();
            target.markUnknownOpDynamicallyLegal([](Operation *op)
                                                 { return true; });

            RewritePatternSet patterns(context);

            patterns.add<RemovePrintOp, RemoveAssertOp, RemovePrintStringOp>(context);
            if (failed(applyPartialConversion(module, target, std::move(patterns))))
            {
                signalPassFailure();
            }
        }
    };
}

std::unique_ptr<mlir::Pass> mlir::arey::createRemoveAreyPass()
{
    return std::make_unique<RemoveAreyPass>();
}

