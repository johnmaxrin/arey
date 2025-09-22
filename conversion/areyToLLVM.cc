
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
        
        if(mlir::isa<mlir::IntegerType>(op.getVal1().getType()))
        {
           // Compate val1 and val2 for equality. 
           // If not equal break!  
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