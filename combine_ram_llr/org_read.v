module org_read (
        input wire sys_clk,
        input wire sys_rst_n,
        input wire flag_org_read_start,         // ? 控制信号给的

        output wire [6:0] org_addr,             // 由读信号持续时间产生的地址自增器
        output wire       org_rd_en,
        output reg        flag_org_read_end
    );

	// * 本模块主要实现 ram_llr 的读写控制逻辑

    parameter CNT_DATA_MAX = 7'd63;

    reg [6:0] cnt_data;
    reg       cnt;
    reg       org_read_en;


    always @(posedge sys_clk or negedge sys_rst_n)
        if (sys_rst_n == 1'b0)
            org_read_en <= 1'b0;
        else if (cnt_data == CNT_DATA_MAX && cnt == 1'b1)
            org_read_en <= 1'b0;
        else if (flag_org_read_start == 1'b1)
            org_read_en <= 1'b1;
        else
            org_read_en <= org_read_en;


    always @(posedge sys_clk or negedge sys_rst_n)
        if (sys_rst_n == 1'b0)
            cnt <= 1'b0;
        else if (org_read_en == 1'b0)
            cnt <= 1'b0;
        else if (org_read_en == 1'b1)
            cnt <= cnt + 1'b1;
        else
            cnt <= cnt;


    always @(posedge sys_clk or negedge sys_rst_n)
        if (sys_rst_n == 1'b0)
            cnt_data <= 7'd0;
        else if ((cnt_data == CNT_DATA_MAX && cnt == 1'b1) || flag_org_read_start == 1'b1)
            cnt_data <= 7'd0;
        else if (org_read_en == 1'b1 && cnt == 1'b1)
            cnt_data <= cnt_data + 1'b1;
        else
            cnt_data <= cnt_data;


    always @(posedge sys_clk or negedge sys_rst_n)
        if (sys_rst_n == 1'b0)
            flag_org_read_end <= 1'b0;
        else if (cnt_data == CNT_DATA_MAX && cnt == 1'b1)
            flag_org_read_end <= 1'b1;
        else
            flag_org_read_end <= 1'b0;

    assign org_addr  = (org_read_en == 1'b1) ? cnt_data : 7'd0;
    assign org_rd_en = (org_read_en == 1'b1) ? 1'b1 : 1'b0;


endmodule
