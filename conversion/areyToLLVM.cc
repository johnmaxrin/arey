
#include "areyToLLVM.h"
#include "dialect/Passes.h.inc"

using namespace mlir;
using namespace mlir::arey;

static mlir::LLVM::LLVMFuncOp getOrInsertAbortFn(mlir::PatternRewriter &rewriter, mlir::Location loc);

struct ConvertPrintToLLVM : public OpConversionPattern<PrintOp>
{
    using OpConversionPattern::OpConversionPattern;

    LogicalResult matchAndRewrite(
        PrintOp op, OpAdaptor adaptor,
        ConversionPatternRewriter &rewriter) const override
    {

        auto loc = op->getLoc();
        auto mod = op->getParentOfType<mlir::ModuleOp>();

        Value val = op->getOperand(0);

        auto ctx = rewriter.getContext();
        auto i8Ty = IntegerType::get(ctx, 8);
        auto ptrTy = LLVM::LLVMPointerType::get(ctx);

        std::string fmt;
        Type valTy = val.getType();

        if (mlir::isa<mlir::IndexType>(valTy))
            fmt = "%d\n";
        else if (mlir::isa<mlir::IntegerType>(valTy))
            fmt = "%d\n";
        else if (mlir::isa<LLVM::LLVMPointerType>(valTy))
            fmt = "%d\n";

        fmt.push_back('\0');

        auto arrayType = mlir::LLVM::LLVMArrayType::get(i8Ty, fmt.size());

        rewriter.setInsertionPointToStart(mod.getBody());

        auto global = rewriter.create<mlir::LLVM::GlobalOp>(
            loc,
            LLVM::LLVMArrayType::get(i8Ty, fmt.size()),
            true,
            LLVM::Linkage::Internal,
            "print_format",
            rewriter.getStringAttr(fmt));

        // mod.push_back(global);

        if (!mod.lookupSymbol<mlir::LLVM::LLVMFuncOp>("printf"))
        {
            auto printfType = mlir::LLVM::LLVMFunctionType::get(
                rewriter.getI32Type(), ptrTy, /*isVarArg=*/true);
            rewriter.setInsertionPointToStart(mod.getBody());
            rewriter.create<mlir::LLVM::LLVMFuncOp>(loc, "printf", printfType);
        }

        rewriter.setInsertionPoint(op);
        auto zero = rewriter.create<mlir::LLVM::ConstantOp>(op.getLoc(), rewriter.getI32Type(), rewriter.getI32IntegerAttr(0));
        auto one = rewriter.create<mlir::LLVM::ConstantOp>(op.getLoc(), rewriter.getI32Type(), rewriter.getI32IntegerAttr(1));
        auto strPtr = rewriter.create<mlir::LLVM::AddressOfOp>(op.getLoc(), global);

        auto gep = rewriter.create<mlir::LLVM::GEPOp>(op.getLoc(), ptrTy, arrayType, strPtr, mlir::ValueRange{zero, zero});

        auto fn = mod.lookupSymbol<mlir::LLVM::LLVMFuncOp>("printf");
        mlir::LLVM::LLVMFunctionType fnType =
            dyn_cast<mlir::LLVM::LLVMFunctionType>(fn.getFunctionType());

        if (auto ptrTy = mlir::dyn_cast<LLVM::LLVMPointerType>(val.getType()))
        {
            // Get the actual type.
            val = rewriter.create<LLVM::LoadOp>(loc, rewriter.getI32Type(), val);
            rewriter.create<mlir::LLVM::CallOp>(
                op.getLoc(),
                fn,
                mlir::ValueRange{gep, val});
        }
        else if (auto ptrTy = mlir::dyn_cast<mlir::IndexType>(val.getType()))
        {
            auto castedVal = rewriter.create<mlir::arith::IndexCastOp>(
                op.getLoc(), rewriter.getIntegerType(64), val);

            rewriter.create<mlir::LLVM::CallOp>(
                op.getLoc(),
                fn,
                mlir::ValueRange{gep, castedVal});
        }
        else
        {
            rewriter.create<mlir::LLVM::CallOp>(
                op.getLoc(),
                fn,
                mlir::ValueRange{gep, val});
        }

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
        auto loc = op->getLoc();
        auto mod = op->getParentOfType<mlir::ModuleOp>();

        auto attr = op->getAttr("msg");
        auto strAttr = dyn_cast<StringAttr>(attr);
        std::string msg = strAttr.getValue().str();

        auto ctx = rewriter.getContext();
        auto i8Ty = IntegerType::get(ctx, 8);
        auto ptrTy = LLVM::LLVMPointerType::get(ctx);

        msg.push_back('\0');

        auto arrayType = mlir::LLVM::LLVMArrayType::get(i8Ty, msg.size());

        rewriter.setInsertionPointToStart(mod.getBody());

        auto global = rewriter.create<mlir::LLVM::GlobalOp>(
            loc,
            LLVM::LLVMArrayType::get(i8Ty, msg.size()),
            true,
            LLVM::Linkage::Internal,
            "msg",
            rewriter.getStringAttr(msg));

        // mod.push_back(global);

        // ---- 2. Declare printf if missing ----
        if (!mod.lookupSymbol<mlir::LLVM::LLVMFuncOp>("printf"))
        {
            auto printfType = mlir::LLVM::LLVMFunctionType::get(
                rewriter.getI32Type(), ptrTy, /*isVarArg=*/true);
            rewriter.setInsertionPointToStart(mod.getBody());
            rewriter.create<mlir::LLVM::LLVMFuncOp>(loc, "printf", printfType);
        }

        rewriter.setInsertionPoint(op);
        auto zero = rewriter.create<mlir::LLVM::ConstantOp>(op.getLoc(), rewriter.getI32Type(), rewriter.getI32IntegerAttr(0));
        auto one = rewriter.create<mlir::LLVM::ConstantOp>(op.getLoc(), rewriter.getI32Type(), rewriter.getI32IntegerAttr(1));
        auto strPtr = rewriter.create<mlir::LLVM::AddressOfOp>(op.getLoc(), global);

        auto gep = rewriter.create<mlir::LLVM::GEPOp>(op.getLoc(), ptrTy, arrayType, strPtr, mlir::ValueRange{zero, zero});

        // ---- 3. Call printf with value ----

        auto fn = mod.lookupSymbol<mlir::LLVM::LLVMFuncOp>("printf");
        mlir::LLVM::LLVMFunctionType fnType =
            dyn_cast<mlir::LLVM::LLVMFunctionType>(fn.getFunctionType());

        rewriter.create<mlir::LLVM::CallOp>(
            op.getLoc(),
            fn,
            mlir::ValueRange{gep});

        rewriter.eraseOp(op);
        return success();
    }
};

struct ConvertAssertToLLVM : public OpConversionPattern<AssertOp>
{
    using OpConversionPattern::OpConversionPattern;

    LogicalResult matchAndRewrite(
        AssertOp op, OpAdaptor adaptor, ConversionPatternRewriter &rewriter) const override
    {
        auto mod = op->getParentOfType<mlir::ModuleOp>();

        if (mlir::isa<mlir::IntegerType>(op.getVal1().getType()))
        {

            // Generate code to
            // Compare val1 and val2 for equality.
            // If not equal break!

            // Add a printf.

            std::string assertMsg = "Assertion Failed!\n";
            auto ctx = rewriter.getContext();
            auto i8Ty = IntegerType::get(ctx, 8);
            auto ptrTy = LLVM::LLVMPointerType::get(ctx);
            auto arrayType = mlir::LLVM::LLVMArrayType::get(i8Ty, assertMsg.size());

            rewriter.setInsertionPointToStart(mod.getBody());

            auto global = rewriter.create<mlir::LLVM::GlobalOp>(
                op.getLoc(),
                LLVM::LLVMArrayType::get(i8Ty, assertMsg.size()),
                true,
                LLVM::Linkage::Internal,
                "assertMsg",
                rewriter.getStringAttr(assertMsg));

            if (!mod.lookupSymbol<mlir::LLVM::LLVMFuncOp>("printf"))
            {
                auto printfType = mlir::LLVM::LLVMFunctionType::get(
                    rewriter.getI32Type(), ptrTy, /*isVarArg=*/true);
                rewriter.setInsertionPointToStart(mod.getBody());
                rewriter.create<mlir::LLVM::LLVMFuncOp>(op.getLoc(), "printf", printfType);
            }

            // End of printf.

            rewriter.setInsertionPoint(op);

            // For Printf
            auto zero = rewriter.create<mlir::LLVM::ConstantOp>(op.getLoc(), rewriter.getI32Type(), rewriter.getI32IntegerAttr(0));
            auto one = rewriter.create<mlir::LLVM::ConstantOp>(op.getLoc(), rewriter.getI32Type(), rewriter.getI32IntegerAttr(1));
            auto strPtr = rewriter.create<mlir::LLVM::AddressOfOp>(op.getLoc(), global);

            auto gep = rewriter.create<mlir::LLVM::GEPOp>(op.getLoc(), ptrTy, arrayType, strPtr, mlir::ValueRange{zero, zero});

            // For Printf

            auto val2 = rewriter.create<LLVM::ConstantOp>(op.getLoc(), rewriter.getI32Type(), op.getVal2Attr());
            auto cond = rewriter.create<LLVM::ICmpOp>(op.getLoc(), rewriter.getI1Type(), LLVM::ICmpPredicate::eq, op.getVal1(), val2);

            // Create Blocks
            mlir::Block *curBlk = op->getBlock();
            mlir::Block *trueBlk = rewriter.splitBlock(curBlk, mlir::Block::iterator(op));
            mlir::Block *falseBlk = rewriter.createBlock(trueBlk->getParent());

            rewriter.setInsertionPointToEnd(curBlk);
            rewriter.create<LLVM::CondBrOp>(op.getLoc(), cond, trueBlk, mlir::ValueRange{}, falseBlk, mlir::ValueRange{});

            rewriter.setInsertionPointToStart(falseBlk);

            // Call printf
            auto fn = mod.lookupSymbol<mlir::LLVM::LLVMFuncOp>("printf");
            mlir::LLVM::LLVMFunctionType fnType =
                dyn_cast<mlir::LLVM::LLVMFunctionType>(fn.getFunctionType());

            rewriter.create<mlir::LLVM::CallOp>(
                op.getLoc(),
                fn,
                mlir::ValueRange{gep});


                // Call Abort
            auto abortFn = getOrInsertAbortFn(rewriter, op.getLoc());
            rewriter.create<LLVM::CallOp>(op.getLoc(), abortFn, mlir::ValueRange{});
            rewriter.create<LLVM::UnreachableOp>(op.getLoc());
        }

        else
        {
            llvm::errs() << "Not an integer type for assertion! \n";
            return failure();
        }

        rewriter.eraseOp(op);
        return success();
    }
};

namespace
{
#define GEN_PASS_DEF_CONVERTAREYTOLLVMPASS
#include "dialect/Passes.h.inc"

    struct ConvertAreyToLLVMPass
        : public impl::ConvertAreyToLLVMPassBase<ConvertAreyToLLVMPass>
    {
        using ConvertAreyToLLVMPassBase::ConvertAreyToLLVMPassBase;

        void runOnOperation() override
        {
            mlir::MLIRContext *context = &getContext();
            auto *module = getOperation();

            ConversionTarget target(*context);
            target.addIllegalOp<arey::PrintOp>();
            target.addIllegalOp<arey::PrintStringOp>();
            target.addIllegalOp<arey::AssertOp>();
            target.addLegalDialect<LLVM::LLVMDialect>();
            target.markUnknownOpDynamicallyLegal([](Operation *op)
                                                 { return true; });

            RewritePatternSet patterns(context);

            patterns.add<ConvertPrintToLLVM, ConvertPrintStringToLLVM, ConvertAssertToLLVM>(context);
            if (failed(applyPartialConversion(module, target, std::move(patterns))))
            {
                signalPassFailure();
            }
        }
    };
}

std::unique_ptr<mlir::Pass> mlir::arey::createConvertAreyToLLVMPass()
{
    return std::make_unique<ConvertAreyToLLVMPass>();
}

static mlir::LLVM::LLVMFuncOp getOrInsertAbortFn(mlir::PatternRewriter &rewriter, mlir::Location loc)
{
    mlir::ModuleOp module = rewriter.getInsertionBlock()->getParentOp()->getParentOfType<mlir::ModuleOp>();
    mlir::OpBuilder::InsertionGuard guard(rewriter);

    // Check if "abort" already exists
    if (auto func = module.lookupSymbol<mlir::LLVM::LLVMFuncOp>("abort"))
        return func;

    // Otherwise insert the declaration at the module level
    rewriter.setInsertionPointToStart(module.getBody());

    auto llvmFnType = mlir::LLVM::LLVMFunctionType::get(
        rewriter.getI32Type(), /*params=*/{}, /*isVarArg=*/false);

    auto func = rewriter.create<mlir::LLVM::LLVMFuncOp>(
        loc, "abort", llvmFnType);

    return func;
}
