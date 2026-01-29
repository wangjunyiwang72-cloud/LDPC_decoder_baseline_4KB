# LDPC_decoder_baseline_4KB
## 项目简介

本项目是一个基于 Verilog 实现的 **4KB QC-LDPC (Quasi-Cyclic Low-Density Parity-Check)** 解码器。该设计采用了硬件友好的部分并行架构，针对 4KB 码长、高码率（约 0.96）的 LDPC 码进行了优化。顶层模块为 `top.v`，集成了输入缓冲、控制逻辑、变量节点更新（VFU）、校验节点更新（CFU）、消息存储（RAM）及判决输出等核心功能。

## 核心参数

* **码长类型**: 4KB ($N=34112$ bits)
* **基础矩阵列数 (Columns)**: 533 (对应 `QC_LDPC_COL_COUNT`)
* **扩展因子 (Z)**: 64 (对应 `QC_LDPC_BLOCK_SIZE`)
* **量化位宽**: 4-bit (3-bit magnitude + 1-bit sign) (对应 `QNT_BIT`)
* **解码算法**: 最小和 (Min-Sum)
* **架构风格**: 节点并行 (Node-Parallel) / 边缘存储架构

## 模块层级结构 (Module Hierarchy)

项目采用模块化设计，通过 `include` 文件大规模例化计算单元以实现并行处理。

```text
top (Top Module)
├── u_buffer_in (1 instance)
│   └── buffer_ram (Internal FIFO/RAM)
│
├── conctrl_inst (1 instance) [Main Controller]
│
├── combine_ram_llr_inst_X (533 instances) [Channel LLR Storage]
│   ├── Included via: "combine_ram_llr_1_533.txt"
│   └── Indexes: 1 to 533 (One per Base Matrix Column)
│
├── ram_ctrl_inst_R_C (Multiple instances) [Edge Message Storage & Routing]
│   ├── Included via: "combine_ram_ctrl_inst21_533.txt"
│   ├── Quantity: 对应基础矩阵 Hb 中非零元素的总数 (Total Weight)
│   └── Function: Handles barrel shifting (cyclic shift) and message storage
│
├── CFU_102_ctrl_X (21 instances) [Check Node Units]
│   ├── Included via: "CFU_inst_1_21.txt"
│   ├── Indexes: 1 to 21 (One per Base Matrix Row)
│   └── Core: min_least_102 (Min-Sum logic)
│
├── VFU_4_ctrl_X (533 instances) [Variable Node Units]
│   ├── Included via: "VFU_inst_1_533.txt"
│   ├── Indexes: 1 to 533 (One per Base Matrix Column)
│   └── Core: vn4 / vn5 (Processing logic)
│
├── judge_ctrl_inst (1 instance) [Syndrome Check & Decision]
│
└── u_buffer_out (1 instance)

```

## 关键模块统计

* **VFU (Variable Node Unit)**: 共 **533** 个。对应基础矩阵的列数。每个 VFU 并行处理 64 个比特，实现了对 34112 个变量节点的并行更新。
* **CFU (Check Node Unit)**: 共 **21** 个。对应基础矩阵的行数。由于是高码率代码，行重（Row Weight）较大，每个 CFU 需要处理多达 100+ 个输入。
* **RAMs**:
* **LLR RAM**: 533 个，存储信道软信息。
* **Edge RAM (Combine RAM Ctrl)**: 数量等于基础矩阵的非零元素个数（Edge Count）。它们充当 Tanner 图中的“边”，负责 VFU 与 CFU 之间的信息交换和循环移位网络（Cyclic Shifter）。

## 模块详细说明

### 1. 顶层模块 (Top Level)

* **文件名**: `top.v`
* **功能**: 系统的顶层封装，连接各子模块，管理时钟、复位及全局控制信号。
* **输入**: `sink` (输入数据), `sink_star`/`sink_stop` (流控制)。
* **输出**: `data_decode` (解码数据), `iter` (当前迭代次数), `buffer_full` (状态信号)。

### 2. 核心子模块

| 模块名称 | 例化名 | 数量 | 核心功能说明 |
| --- | --- | --- | --- |
| **buffer_in** | `u_buffer_in` | 1 | **输入缓冲模块**。<br>

<br>负责接收外部串行/并行数据，将其整型并存入内部 RAM。参数配置为 533 列，块大小 64。 |
| **conctrl** | `conctrl_inst` | 1 | **主控制器**。<br>

<br>负责解码流程的状态机调度。生成 `flag_VFU_start`, `flag_CFU_start`, `flag_judge_start` 等握手信号，控制迭代循环。 |
| **combine_ram_llr** | `combine_ram_llr_inst_x` | 533 | **信道信息存储**。<br>

<br>通过 `include "combine_ram_llr_1_533.txt"` 批量例化。存储从信道接收到的初始 LLR (Log-Likelihood Ratio) 值，供 VFU 读取。 |
| **combine_ram_ctrl** | `ram_ctrl_inst_x_y` | 76+* | **边信息存储与路由**。<br>

<br>通过 `include "combine_ram_ctrl_inst21_533.txt"` 例化。对应 Tanner 图中的“边”，负责在 VFU 和 CFU 之间交换 extrinsic 信息。同时也处理循环移位 (`cyclic_shif`)。 <br>

<br>*(注：代码注释提及76个单元，实际数量取决于基础矩阵非零元素个数)* |
| **CFU_102_ctrl** | `CFU_102_ctrl_x` | 21* | **校验节点单元 (Check Node Unit)**。<br>

<br>通过 `include "CFU_inst_1_21.txt"` 例化。负责执行校验方程计算（行更新）。<br>

<br>*(注：顶层文件注释提及12个，但 Include 文件名为 1_21 且包含 21 个实例，对应高码率矩阵的行数)* |
| **VFU_4_ctrl** | `VFU_4_ctrl_x` | 533 | **变量节点单元 (Variable Node Unit)**。<br>

<br>通过 `include "VFU_inst_1_533.txt"` 例化。负责执行变量节点更新（列更新），计算最终的后验概率并进行硬判决预处理。每个 VFU 处理基础矩阵的一列。 |
| **judge_ctrl** | `judge_ctrl_inst` | 1 | **判决与校验模块**。<br>

<br>接收来自 VFU 的 533 路 `bit_data`，计算校验子 (`H_sum`) 以判断解码是否成功，并生成迭代终止信号。 |
| **buffer_out** | `u_buffer_out` | 1 | **输出缓冲模块**。<br>

<br>将解码完成的 533 路并行数据进行重组、缓存，并按 `64-bit` 位宽串行输出 `data_decode`。 |


## 核心模块接口定义 (Signal Definitions)

以下表格列出了核心模块的关键信号定义。
*(注：`QNT_BIT = 4`, `Z = 64`)*

### 1. 顶层模块 (Baseline_8KB)

| 信号名 | 方向 | 位宽 | 描述 |
| --- | --- | --- | --- |
| `sys_clk` | Input | 1 | 系统时钟 |
| `sys_rst_n` | Input | 1 | 异步复位 (低电平有效) |
| `sink` | Input | `[3:0]` | 输入 LLR 数据 (4-bit 量化) |
| `sink_star` | Input | 1 | 输入流开始信号 |
| `data_decode` | Output | `[63:0]` | 解码输出数据 (每周期输出 64 bits) |
| `iter` | Output | `[4:0]` | 当前迭代次数监控 |
| `buffer_full` | Output | 1 | 输入缓冲满指示信号 |

### 2. 变量节点单元 (VFU_4_ctrl)

*负责列更新运算，计算后验概率。*

| 信号名 | 方向 | 位宽 | 描述 |
| --- | --- | --- | --- |
| `flag_VFU_start` | Input | 1 | VFU 启动触发信号 (来自 Controller) |
| `org_data` | Input | `[3:0]` | 原始信道 LLR 值 (来自 combine_ram_llr) |
| `ram_VFU_data_X` | Input | `[3:0]` | 来自各个 CFU 的校验节点信息 (最多 4-5 路输入) |
| `VFU_data_X` | Output | `[3:0]` | 输出给 CFU 的变量节点信息 (Extrinsic) |
| `bit_data_reg` | Output | `[63:0]` | **硬判决输出** (Z=128，全并行输出给判决模块) |
| `VFU_wr/re_en` | Output | 1 | 读写使能控制 |
| `VFU_addr` | Output | `[7:0]` | RAM 读写地址 |

### 3. 校验节点单元 (CFU_102_ctrl)

*负责行更新运算，执行最小和算法。*

| 信号名 | 方向 | 位宽 | 描述 |
| --- | --- | --- | --- |
| `flag_CFU_start` | Input | 1 | CFU 启动触发信号 |
| `ram_CFU_data_X` | Input | `[3:0]` | 来自各个 VFU 的变量节点信息 (多达 102 路输入) |
| `CFU_data_X` | Output | `[3:0]` | 更新后的校验节点信息 (回写给 VFU) |
| `CFU_addr` | Output | `[7:0]` | RAM 地址控制 |
| `flag_CFU_end` | Output | 1 | 该行计算完成标志 |

### 4.  判决模块 (judge_ctrl)

*负责校验子计算 () 判断是否收敛。*

| 信号名 | 方向 | 位宽 | 描述 |
| --- | --- | --- | --- |
| `bit_data_X` | Input | `[63:0]` | 来自 533 个 VFU 的 128-bit 硬判决数据<br>

<br>(总输入带宽极高) |
| `H_sum` | Output | `[6:0]` | 校验和 (Syndrome Sum)。为 0 时表示校验通过。 |
| `flag_judge_end` | Output | 1 | 判决完成信号 |

### 5. 主控制器 (conctrl)

*状态机调度中心。*

| 信号名 | 方向 | 位宽 | 描述 |
| --- | --- | --- | --- |
| `flag_VFU_end` | Input | `[532:0]` | 533 个 VFU 的完成状态汇总 |
| `flag_CFU_end` | Input | `[20:0]` | 21 个 CFU 的完成状态汇总 |
| `H_sum` | Input | `[6:0]` | 来自判决模块的校验和结果 |
| `flag_VFU_start` | Output | 1 | 全局 VFU 启动信号 |
| `flag_CFU_start` | Output | 1 | 全局 CFU 启动信号 |
| `flag_judge_start` | Output | 1 | 全局判决启动信号 |



## 备注

* **代码差异说明**: `top.v` 中的部分注释（如“24个变量节点计算模块”）可能对应于旧版本或折叠架构，实际逻辑以 `include` 文件中的 **533** 个 VFU 实例为准，这实现了全并行的列处理能力。
* **参数**: `cyclic_shif_data` 等参数在 `Hb_H_QC_N68224_K65536_R0.96_z128.txt` 中定义，表明该解码器对应的是 Rate 0.96 的 LDPC 码。
