# A Template for C++ Unum Sub-Projects

Simply fork this repo in case you want to write a small C++ library. 
Put your code in the `main.hpp`, the tests into `main_test.cxx` and banchmark into `main_bench.cxx`.
To run all:

```sh
./scripts/install_deps.sh
./scripts/build_release.sh
./bin/main_test
./bin/main_bench
```

## Style Guidelines

### Naming

* Everything must be `snake_case`.
* Variable names should be nouns, function names — verbs.
* Type/ Class/ Struct/ Union names must all end with `_t` (type).
* Compile time constants end with `_k`.
* Templates end with `_gt` (generic type).
* Template type arguments end with `_at` (a type).
* Template non-type arguments end with `_ak` (a constant).

### Third-party Libraries

* I/O with `<<` and `>>` is ugly, stop doing it.
* Using `<iostream>` is banned. It’s slow and hard to compile, use `<fmt/format.h>`.
* `std::thread` is hard to kill and expensive to construct. Use a shared thread-pool from `tf::Executor`.
* Using `<boost/...>` is banned. Same as `<poco/...>`, `<folly/...>`, `<qt/...>` and other frameworks.
* `std::set<std::string>` -> `std::unordered_set<std::string>`.
* `std::mutex` -> `unum::lockfree_patex_t`, `unum::lockfree_mutex_t`.
* Prefer libraries, that are actively maintained and hosted in precompiled state on Conan-Center.
* Write your own POD return types instead of generic `std::pair` and `std::tuple` both for readable member names, faster compilation and -sometimes- faster runtime.
* Recommended classes and data-structures from STL: `set`, `vector`, `unordered_set`, `chrono::*`, `span`, `basic_string_view`.

### Coding

* `#ifdef ...` -> `#if defined(...)`
* `#define FILE_NAME_H` -> `#pragma once` in headers
* Use `#pragma region` or `#pragma mark` to markup long files
* `auto v = expr(); if (v) {}` -> `if (auto v = expr(); v) {}`
* `do { } while ()` -> `while () {}` -> `for (; ;)`
* Use `inline` for functions defined in headers just to help make linking easier. Use our `inline_m` macro to force inlining where it matters, but don’t overdo to keep compilation times sane.
* Prefer passing by value. When objects are expensive and no-concurrency is present — can use `const &` for immutable arguments.

### Performance

* Branching is disasteros in HPC. `if (x) { a; } else { b; }` is worse than `x ? a : b`. Which is also worse than `auto arr[2] = {a, b}; arr[x]` in some cases.
* Remember, `a && b` and `bool(a) & bool(b)` are not the same and may have serious performance implications.
* Reuse memory buffers, align them -if possible- to use faster SIMD load instructions.
* Integer division and modulo operations are extremely expensive, avoid them.
* Fits your batch sizes into cache-lines, RAM pages or NAND page sizes depending on the application.
* When working with SIMD prioritize [AVX/AVX2 subset of x86](https://software.intel.com/sites/landingpage/IntrinsicsGuide/#techs=AVX,AVX2) and the [NEON subset of ARM](https://developer.arm.com/architectures/instruction-sets/simd-isas/neon/intrinsics) ISA.

### Compilation

* Root directory contains of each repository:
  	* `CMakeLists.txt` for cross-platform compilation.
  	* `conanfile.py` for dependencies management.
  	* `.vscode/` with launch options and compilations tasks.
	* `.devcontainer/` with a `Dockerfile`, that installs the right version of Linux and GCC with C++20 support.
  	* `python/` for `PyBind11` bindings.
	* `graphviz/` that will contain the `.dot` dependency graphs after compilation.
* Don’t hard-code the compiler path in CMake.
