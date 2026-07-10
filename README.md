A GCC-Based Static Checker for MISRA C:2025

- GCC 7.5.0 with built-in static analysis support for MISRA C:2025 single-translation-unit rules
- An extended version of the existing GCC MISRA C: 2012 checker.
(https://github.com/CCU-HPCLAB/GCC-MISRAC-Checker)
---

## Usage

Enable MISRA C:2025 rule checking with the `-Wmisra-c` flag:

```bash
gcc -Wmisra-c -std=c11 your_file.c
```

Violations are reported in the format:

```
your_file.c:10:5: warning: MISRA C:2025 Rule X.Y [-Wmisra-c]
```

---

## Build

### Prerequisites

```bash
sudo apt update
sudo apt install libgmp-dev libmpfr-dev libmpc-dev
```

### Compile & Install

```bash
mkdir build && cd build
../gcc-7.5.0/configure --prefix=/usr/local/misrac2026 \
    --enable-languages=c --disable-multilib
make -j$(nproc)
sudo make install
```

> `$(nproc)` automatically uses all available CPU cores (e.g. `make -j8` for 8 cores).

---

## Modified Source Files

| File | Changes |
|------|---------|
| `gcc/c/c-parser.c` | Expression parsing, operator precedence rules |
| `gcc/c/c-typeck.c` | Type checking, pointer compatibility |
| `gcc/c/c-decl.c` | Declarations, struct / VLA checks |
| `gcc/c-family/c-lex.c` | Lexer, header inclusion checks |
| `gcc/tree-cfg.c` | Control flow, missing return checks |
| `libcpp/directives.c` | Preprocessor directive checks |
| `libcpp/macro.c` | Macro identifier checks |

---

## GCC 7.5.0 — MISRA C:2025 檢查器

本專案是 GCC 7.5.0 的修改版，新增了對 **MISRA C:2025** 規則的靜態分析支援，涵蓋附錄 B（Single Translation Unit）中的規則。

### 使用方式

```bash
gcc -Wmisra-c -std=c11 your_file.c
```

違規回報格式：

```
your_file.c:10:5: warning: MISRA C:2025 Rule X.Y [-Wmisra-c]
```

### 先備條件

```bash
sudo apt update
sudo apt install libgmp-dev libmpfr-dev libmpc-dev
```

### 建構方式

```bash
mkdir build && cd build
../gcc-7.5.0/configure --prefix=/usr/local/misrac2026 \
    --enable-languages=c --disable-multilib
make -j$(nproc)
sudo make install
```

> `$(nproc)` 會自動使用所有可用的 CPU 核心數。
