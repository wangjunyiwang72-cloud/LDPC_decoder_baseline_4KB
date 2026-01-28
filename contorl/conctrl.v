module conctrl (
        input wire        sys_clk,
        input wire        sys_rst_n,
        input wire [ 1:0] flag_buffer_in,     // buffer 存有的帧数
        input wire        flag_org_write_end, // buffer 数据写入 ram_llr 完成
        input wire [532:0] flag_org_read_end,  //初始数据读取rom完成
        input wire [20:0] flag_VFU_end,       //VFU模块更新完成
        input wire [3:0] flag_CFU_end,       //CFU模块更新完成
        input wire        flag_judge_end,     //判决模块完成
        input wire [6:0] H_sum,              //校验方程校验成立结果

        output reg       flag_first_store,
        output reg       flag_org_read_start,
        output reg       flag_VFU_start,
        output reg       flag_CFU_start,
        output reg       flag_judge_start,
        output reg       flag_serial,           // 拉高一个周期说明本帧计算完成
        output reg       flag_org_update,       // 可以写入下一帧了
        output reg [4:0] iter                  //迭代次数
    );

    // * 增添帧与帧之间的控制逻辑，增加输出信号 flag_org_update 进行下一帧的操作

    parameter ITER_MAX = 5'd30;
    reg flag_first;
    reg flag_over;  //结束信号
    reg flag_org_write_end_reg; // 多打一拍
    reg flag_judge_end_reg;  //控制flag_CFU_start信号

    reg busy; // 为 1 说明解码忙碌



    //************************************************************
    //*                       帧间控制逻辑                        *
    //************************************************************
    always @(posedge sys_clk or negedge sys_rst_n)
        if (sys_rst_n  == 1'b0)
            flag_org_update <= 1'b0;
        else if (busy == 1'b0 && flag_buffer_in != 2'b0)
            flag_org_update <= 1'b1;
        else
            flag_org_update <= 1'b0;


    always @(posedge sys_clk or negedge sys_rst_n)
        if (sys_rst_n  == 1'b0)
            busy <= 1'b0;
        else if (busy == 1'b0 && flag_buffer_in != 2'b0)
            busy <= 1'b1;
        else if (flag_serial ==  1'b1)
            busy <= 1'b0;
        else
            busy <= busy;


    //************************************************************
    //*                       之前的帧内控制逻辑                   *
    //************************************************************
    always @(posedge sys_clk or negedge sys_rst_n)
        if (sys_rst_n == 1'b0)
            iter <= 5'b0;
        else if (flag_org_write_end == 1'b1)
            iter <= 5'b0;
        else if (iter == ITER_MAX)
            iter <= ITER_MAX;
        else if (flag_judge_end == 1'b1)
            iter <= iter + 1'b1;
        else
            iter <= iter;


    always @(posedge sys_clk or negedge sys_rst_n)
        if (sys_rst_n == 1'b0)
            flag_judge_end_reg <= 1'b0;
        else
            flag_judge_end_reg <= flag_judge_end;


    always @(posedge sys_clk or negedge sys_rst_n)
        if (sys_rst_n == 1'b0)
            flag_org_write_end_reg <= 1'b0;
        else
            flag_org_write_end_reg <= flag_org_write_end;


    always @(posedge sys_clk or negedge sys_rst_n)
        if (sys_rst_n == 1'b0)
            flag_first_store <= 1'b0;
        else if (flag_org_write_end_reg == 1'b1)
            flag_first_store <= 1'b1;
        else
            flag_first_store <= 1'b0;


    always @(posedge sys_clk or negedge sys_rst_n)
        if (sys_rst_n == 1'b0)
            flag_first <= 1'b0;
        else if (flag_org_read_end == {533{1'b1}})
            flag_first <= 1'b0;
        else if (flag_org_write_end_reg == 1'b1)
            flag_first <= 1'b1;
        else
            flag_first <= flag_first;


    always @(posedge sys_clk or negedge sys_rst_n)
        if (sys_rst_n == 1'b0)
            flag_org_read_start <= 1'b0;
        else if (flag_org_write_end == 1'b1 || flag_CFU_end == 4'hf)
            flag_org_read_start <= 1'b1;
        else
            flag_org_read_start <= 1'b0;


    always @(posedge sys_clk or negedge sys_rst_n)
        if (sys_rst_n == 1'b0)
            flag_VFU_start <= 1'b0;
        else if (flag_CFU_end == 4'hf)
            flag_VFU_start <= 1'b1;
        else
            flag_VFU_start <= 1'b0;


    always @(posedge sys_clk or negedge sys_rst_n)
        if (sys_rst_n == 1'b0)
            flag_CFU_start <= 1'b0;
        else if (flag_over == 1'b1 || flag_serial == 1'b1)
            flag_CFU_start <= 1'b0;
        else if (flag_judge_end_reg == 1'b1 || (flag_org_read_end == {533{1'b1}} && flag_first == 1'b1))
            flag_CFU_start <= 1'b1;
        else
            flag_CFU_start <= 1'b0;


    always @(posedge sys_clk or negedge sys_rst_n)
        if (sys_rst_n == 1'b0)
            flag_judge_start <= 1'b0;
        else if (flag_VFU_end == {21{1'b1}})
            flag_judge_start <= 1'b1;
        else
            flag_judge_start <= 1'b0;


    always @(posedge sys_clk or negedge sys_rst_n)
        if (sys_rst_n == 1'b0)
            flag_serial <= 1'b0;
        else if (iter == ITER_MAX || (flag_judge_end == 1'b1 && H_sum == 7'd0))
            flag_serial <= 1'b1;
        else
            flag_serial <= 1'b0;


    always @(posedge sys_clk or negedge sys_rst_n)
        if (sys_rst_n == 1'b0)
            flag_over <= 1'b0;
        else if (flag_org_write_end == 1'b1)
            flag_over <= 1'b0;
        else if (flag_serial == 1'b1)
            flag_over <= 1'b1;
        else
            flag_over <= flag_over;


endmodule
