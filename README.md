# 😩 Arey Dialect (अरे!)

`arey` is a custom [MLIR](https://mlir.llvm.org/) dialect for debugging MLIR Programs.  
It provides simple ops like `arey.print`, `arey.assert` etc to make your life easier when hunting bugs.  

Think of it as **`printf` debugging made first-class in MLIR**.  

---

## ✨ Features  
- **`arey.print`** – printf-style debugging, inserted exactly where you write it.  
- **`arey.assert`** – runtime assertions with custom messages.
---

## 🚀 Build Instructions  

You’ll need a working build of **LLVM + MLIR** first.  
Follow the [MLIR getting started guide](https://mlir.llvm.org/getting_started/) to build them.  

Then build `arey`:  

```bash
# Clone this repo
git clone https://github.com/your-username/arey
cd arey

# Create build directory
mkdir build
cd build

# Configure with CMake
cmake ..

# Build the project
make
```

If everything works, you’ll get a demo binary at:
`./bin/arey-opt`

# 🏆 This project was selected as a finalist at [Segfault Compiler Hackathon](https://segfault.compilertech.org/)
