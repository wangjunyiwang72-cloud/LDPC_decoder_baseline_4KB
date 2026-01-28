module VFU_4_ctrl (
        input wire        sys_clk,         // 系统时钟
        input wire        sys_rst_n,       // 系统复位信号，低电平有效
        input wire        flag_VFU_start,  // VFU 开始信号
        input wire [3:0]  ram_VFU_data_1,  // RAM 数据输出 1（3 位）
        input wire [3:0]  ram_VFU_data_2,  // RAM 数据输出 2（3 位）
        input wire [3:0]  ram_VFU_data_3,  // RAM 数据输出 3（3 位）
        input wire [3:0]  ram_VFU_data_4,  // RAM 数据输出 4（3 位）
        input wire [3:0]  org_data,        // 原始数据（3 位）

        output reg  [9:0] VFU_addr,        // VFU 地址（最大值为 96，7 位宽）
        output wire [3:0] VFU_data_1,      // VFU 输出数据 1（3 位）
        output wire [3:0] VFU_data_2,      // VFU 输出数据 2（3 位）
        output wire [3:0] VFU_data_3,      // VFU 输出数据 3（3 位）
        output wire [3:0] VFU_data_4,      // VFU 输出数据 4（3 位）
        output wire       VFU_wr_en,       // VFU 写使能信号
        output reg  [532:0] bit_data_reg,   // 硬判决数据（96 位宽）
        output wire       VFU_re_en,       // VFU 读使能信号
        output reg        flag_VFU_end     // VFU 结束信号
    );

    reg         cnt_rd_wr;                 // 读写计数器（0 表示读，1 表示写）
    reg         VFU_en;                   // VFU 使能信号
    wire [3:0]  cn_all_sum;               // 所有校验节点数据的总和（3 位）
    reg  [532:0] bit_data;                 // 硬判决数据寄存器（96 位宽）

    // VFU 使能逻辑
    always @(posedge sys_clk or negedge sys_rst_n)
        if (!sys_rst_n)
            VFU_en <= 1'b0;
        else if (VFU_addr == 10'd532 && cnt_rd_wr == 1'b1)  // 当地址达到最大值且完成写操作时，关闭使能
            VFU_en <= 1'b0;
        else if (flag_VFU_start == 1'b1)  // 接收到开始信号时，开启使能
            VFU_en <= 1'b1;
        else
            VFU_en <= VFU_en;

    // VFU 地址生成逻辑
    always @(posedge sys_clk or negedge sys_rst_n)
        if (!sys_rst_n)
            VFU_addr <= 10'd0;  // 复位时地址清零
        else if (flag_VFU_start == 1'b1 || (VFU_addr == 10'd532 && cnt_rd_wr == 1'b1))  // 开始信号或地址达到最大值时清零
            VFU_addr <= 10'd0;
        else if (cnt_rd_wr == 1'b1 && VFU_en == 1'b1)  // 写操作时地址递增
            VFU_addr <= VFU_addr + 1'b1;
        else
            VFU_addr <= VFU_addr;

    // 读写计数器逻辑
    always @(posedge sys_clk or negedge sys_rst_n)
        if (sys_rst_n == 1'b0)
            cnt_rd_wr <= 1'b0;  // 复位时清零
        else if (VFU_en == 1'b0)
            cnt_rd_wr <= 1'b0;  // 当使能信号关闭时，清零
        else if (VFU_en == 1'b1)
            cnt_rd_wr <= cnt_rd_wr + 1'b1;  // 当使能信号开启时，自增
        else
            cnt_rd_wr <= cnt_rd_wr;

    // 硬判决数据生成逻辑
    always @(posedge sys_clk or negedge sys_rst_n)
        if (!sys_rst_n)
            bit_data <= 533'd0;  // 复位时清零
        else if (flag_VFU_end == 1'b1 || flag_VFU_start == 1'b1)
            bit_data <= 533'd0;  // 结束信号或开始信号时清零
        else if (cnt_rd_wr == 1'b1)
            bit_data <= {cn_all_sum[2], bit_data[532:1]};  // 将当前列的最高位插入到硬判决数据中
        else
            bit_data <= bit_data;

    always @(posedge sys_clk or negedge sys_rst_n)
        if (!sys_rst_n)
            bit_data_reg <= 533'd0;  // 复位时清零
        else if (flag_VFU_start == 1'b1)
            bit_data_reg <= 533'd0;  // 开始信号时清零
        else if (flag_VFU_end == 1'b1)
            bit_data_reg <= bit_data;  // 结束信号时更新硬判决数据寄存器
        else
            bit_data_reg <= bit_data_reg;

    // VFU 结束信号逻辑
    always @(posedge sys_clk or negedge sys_rst_n)
        if (!sys_rst_n)
            flag_VFU_end <= 1'b0;  // 复位时清零
        else if (VFU_addr == 10'd532 && cnt_rd_wr == 1'b1)  // 当地址达到最大值且完成写操作时，设置结束信号
            flag_VFU_end <= 1'b1;
        else
            flag_VFU_end <= 1'b0;

    // 读写使能信号
    assign VFU_re_en = (cnt_rd_wr == 1'b0 && VFU_en == 1'b1) ? 1'b1 : 1'b0;  // 读操作使能
    assign VFU_wr_en = (cnt_rd_wr == 1'b1 && VFU_en == 1'b1) ? 1'b1 : 1'b0;  // 写操作使能

    // 实例化 vn4 模块
    vn4 vn4_inst (
        .ori_data(org_data),
        .cn_out_1(ram_VFU_data_1),
        .cn_out_2(ram_VFU_data_2),
        .cn_out_3(ram_VFU_data_3),
        .cn_out_4(ram_VFU_data_4),
        .cn_all_sum(cn_all_sum),
        .vn_1(VFU_data_1),
        .vn_2(VFU_data_2),
        .vn_3(VFU_data_3),
        .vn_4(VFU_data_4)
    );

endmodule