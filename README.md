# A GCC-Based Static Checker for MISRA C:2025

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

## Validation Suite

The companion repository
[misra-c-2025-single-tu-tests](https://github.com/OmOstarter/misra-c-2025-single-tu-tests)
contains the MISRA C:2025 single-translation-unit (STU) validation suite used
to exercise this project's `-Wmisra-c` diagnostics.

---

## Contribution Differences from the Original Checker

The original
[CCU-HPCLAB GCC-MISRAC-Checker](https://github.com/CCU-HPCLAB/GCC-MISRAC-Checker)
targeted MISRA C:2012 Amendment 1 single-translation-unit rules and introduced
the `-Wmisra-c` integration in GCC 7.5.0. Its implementation was imported into
this repository as base commit `63e83f82c`. The imported source matches the CCU
checker state introduced by commit `cdfc0c7`; the exact CCU checkout commit was
not preserved by the import.

Relative to that inherited base, this project contributes:

- diagnostics for **34 post-2012 rule identifiers**, consisting of **31 STU
  identifiers** and **partial compiler-side diagnostics for 3 System-rule
  identifiers**;
- completed implementations for **8 MISRA C:2012 rule identifiers** that were
  missing from the inherited checker; and
- corrections to **29 existing MISRA C:2012 rule implementations** that had
  incomplete or incorrect detection logic.

These counts describe implementation history, not exhaustive semantic
coverage. The three System-rule diagnostics are partial diagnostics and must
not be interpreted as complete System-rule checker support. Rule-number
migrations are not counted as newly implemented rules.

The original checker is described in:

> Chih-Yuan Chen, Yung-An Fang, Guan-Ren Wang, and Peng-Sheng Chen,
> “A GCC-based checker for compliance with MISRA-C's
> single-translation-unit rules,” *Connection Science*, 35(1), 2023.
> [https://doi.org/10.1080/09540091.2023.2222934](https://doi.org/10.1080/09540091.2023.2222934)

---

## 基於 GCC 的 MISRA C:2025 靜態檢查器

* 以 GCC 7.5.0 為基礎，內建對 MISRA C:2025 單一翻譯單元（Single Translation Unit, STU）規則的靜態分析支援。
* 此專案為既有 GCC MISRA C:2012 檢查器的擴充版本。

(https://github.com/CCU-HPCLAB/GCC-MISRAC-Checker)

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

### 修改的原始碼檔案

| 檔案 | 修改內容 |
|------|----------|
| `gcc/c/c-parser.c` | 運算式解析、運算子優先序規則 |
| `gcc/c/c-typeck.c` | 型別檢查、指標相容性 |
| `gcc/c/c-decl.c` | 宣告、struct／VLA 檢查 |
| `gcc/c-family/c-lex.c` | 詞法分析、標頭檔引入檢查 |
| `gcc/tree-cfg.c` | 控制流程、缺少 return 的檢查 |
| `libcpp/directives.c` | 前處理器指令檢查 |
| `libcpp/macro.c` | 巨集識別符檢查 |

## 驗證測試套件

配套 repository
[misra-c-2025-single-tu-tests](https://github.com/OmOstarter/misra-c-2025-single-tu-tests)
收錄本專案用來驗證 `-Wmisra-c` 診斷的 MISRA C:2025 單一翻譯單元（STU）
validation suite。

## 與原始檢查器的貢獻差異

原始
[CCU-HPCLAB GCC-MISRAC-Checker](https://github.com/CCU-HPCLAB/GCC-MISRAC-Checker)
以 MISRA C:2012 Amendment 1 的單一翻譯單元規則為目標，並在 GCC 7.5.0
中加入 `-Wmisra-c`。其實作在本 repository 中以 base commit `63e83f82c`
匯入；檔案比對顯示匯入內容符合 CCU commit `cdfc0c7` 建立的 checker 狀態，
但匯入時未保留實際 checkout 的精確 CCU commit。

相較該繼承版本，本次擴充的貢獻為：

- 新增 **34 個 2012 後續版本的 rule diagnostics**，其中包含 **31 個 STU
  rule identifiers** 與 **3 個 System-rule identifiers 的 partial compiler-side
  diagnostics**；
- 補上學長版本缺少的 **8 個 MISRA C:2012 rule implementations**；
- 修正學長版本中 **29 個已有但偵測不完整或不正確的 MISRA C:2012 rule
  implementations**。

以上數量描述的是實作歷史，不代表每條規則的所有語意情況皆已完整涵蓋。
3 個 System-rule diagnostics 只能視為部分診斷，不代表完整的 System-rule
checker support；規則改號亦未重複計入新增規則。
