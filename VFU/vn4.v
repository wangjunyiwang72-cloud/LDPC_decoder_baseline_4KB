module vn4 (
        input wire [3:0] ori_data,       // 原始输入数据�? 位）

        input wire [3:0] cn_out_1,       // 校验节点输出数据 1�? 位）
        input wire [3:0] cn_out_2,       // 校验节点输出数据 2�? 位）
        input wire [3:0] cn_out_3,       // 校验节点输出数据 3�? 位）
        input wire [3:0] cn_out_4,       // 校验节点输出数据 4�? 位）

        output wire [3:0] cn_all_sum,    // 所有校验节点输出数据的总和�? 位）
        output wire [3:0] vn_1,          // 变量节点输出数据 1�? 位）
        output wire [3:0] vn_2,          // 变量节点输出数据 2�? 位）
        output wire [3:0] vn_3,          // 变量节点输出数据 3�? 位）
        output wire [3:0] vn_4           // 变量节点输出数据 4�? 位）
    );

    // 判断输入是否为零的中间信�?
    wire [3:0] cn_out_judge_1;          // 校验节点输出数据 1 的零值判断结�?
    wire [3:0] cn_out_judge_2;          // 校验节点输出数据 2 的零值判断结�?
    wire [3:0] cn_out_judge_3;          // 校验节点输出数据 3 的零值判断结�?
    wire [3:0] cn_out_judge_4;          // 校验节点输出数据 4 的零值判断结�?
    wire [3:0] ori_data_judge;          // 原始输入数据的零值判断结�?

    // 补码转换的中间信�?
    wire [3:0] cn_out_bu_1;             // 校验节点输出数据 1 的补�?
    wire [3:0] cn_out_bu_2;             // 校验节点输出数据 2 的补�?
    wire [3:0] cn_out_bu_3;             // 校验节点输出数据 3 的补�?
    wire [3:0] cn_out_bu_4;             // 校验节点输出数据 4 的补�?
    wire [3:0] ori_data_bu;             // 原始输入数据的补�?
    wire [3:0] cn_all_sum_bu;           // 所有校验节点输出数据的补码总和
    wire [3:0] vn_bu_1;                 // 变量节点输出数据 1 的补�?
    wire [3:0] vn_bu_2;                 // 变量节点输出数据 2 的补�?
    wire [3:0] vn_bu_3;                 // 变量节点输出数据 3 的补�?
    wire [3:0] vn_bu_4;                 // 变量节点输出数据 4 的补�?

    // 判断输入是否为零，如果是零则输出 0，否则保持原�?
    assign cn_out_judge_1 = (cn_out_1[1:0] == 2'b0) ? 3'd0 : cn_out_1;
    assign cn_out_judge_2 = (cn_out_2[1:0] == 2'b0) ? 3'd0 : cn_out_2;
    assign cn_out_judge_3 = (cn_out_3[1:0] == 2'b0) ? 3'd0 : cn_out_3;
    assign cn_out_judge_4 = (cn_out_4[1:0] == 2'b0) ? 3'd0 : cn_out_4;
    assign ori_data_judge = (ori_data[1:0] == 2'b0) ? 3'd0 : ori_data;

    // 将输入数据转换为补码形式（如果是负数则取补码，否则保持原值）
    assign cn_out_bu_1    = (cn_out_judge_1[2] == 1'b1) ? {cn_out_judge_1[2], ~cn_out_judge_1[1:0] + 1'b1} : cn_out_judge_1;
    assign cn_out_bu_2    = (cn_out_judge_2[2] == 1'b1) ? {cn_out_judge_2[2], ~cn_out_judge_2[1:0] + 1'b1} : cn_out_judge_2;
    assign cn_out_bu_3    = (cn_out_judge_3[2] == 1'b1) ? {cn_out_judge_3[2], ~cn_out_judge_3[1:0] + 1'b1} : cn_out_judge_3;
    assign cn_out_bu_4    = (cn_out_judge_4[2] == 1'b1) ? {cn_out_judge_4[2], ~cn_out_judge_4[1:0] + 1'b1} : cn_out_judge_4;
    assign ori_data_bu    = (ori_data_judge[2] == 1'b1) ? {ori_data_judge[2], ~ori_data_judge[1:0] + 1'b1} : ori_data_judge;

    // 计算所有校验节点输出数据的补码总和
    assign cn_all_sum_bu  = cn_out_bu_1 + cn_out_bu_2 + cn_out_bu_3 + cn_out_bu_4 + ori_data_bu;

    // 计算每个变量节点的补码输出（排除当前节点的值）
    assign vn_bu_1        = cn_out_bu_2 + cn_out_bu_3 + cn_out_bu_4 + ori_data_bu;
    assign vn_bu_2        = cn_out_bu_1 + cn_out_bu_3 + cn_out_bu_4 + ori_data_bu;
    assign vn_bu_3        = cn_out_bu_1 + cn_out_bu_2 + cn_out_bu_4 + ori_data_bu;
    assign vn_bu_4        = cn_out_bu_1 + cn_out_bu_2 + cn_out_bu_3 + ori_data_bu;

    // 将补码结果转换回原码形式（如果是负数则取补码，否则保持原值）
    assign cn_all_sum     = (cn_all_sum_bu[2] == 1'b1) ? {cn_all_sum_bu[2], ~(cn_all_sum_bu[1:0] - 1'b1)} : cn_all_sum_bu;
    assign vn_1           = (vn_bu_1[2] == 1'b1) ? {vn_bu_1[2], ~(vn_bu_1[1:0] - 1'b1)} : vn_bu_1;
    assign vn_2           = (vn_bu_2[2] == 1'b1) ? {vn_bu_2[2], ~(vn_bu_2[1:0] - 1'b1)} : vn_bu_2;
    assign vn_3           = (vn_bu_3[2] == 1'b1) ? {vn_bu_3[2], ~(vn_bu_3[1:0] - 1'b1)} : vn_bu_3;
    assign vn_4           = (vn_bu_4[2] == 1'b1) ? {vn_bu_4[2], ~(vn_bu_4[1:0] - 1'b1)} : vn_bu_4;

endmodule
