module ram_port_1_ctrl(
        input wire sys_clk,
        input wire sys_rst_n,
        input wire flag_first_store,   // ? 控制信号给的

        input wire [ 7:0] org_addr,    //org的存储地址
        input wire [3:0] org_data,    //org的数�?
        input wire        org_wr_en,   //org的写使能
        input wire [ 7:0] VFU_addr,    //VFU的写地址
        input wire [3:0] VFU_data,    //VFU写入ram的数�?
        input wire        VFU_wr_en,   //VFU的写使能
        input wire        VFU_re_en,   //VFU的读使能
        input wire [6:0] cyclic_shif, //循环移位数，即扩�?H 矩阵中对应的扩展因子

        output wire [3:0] ram_port_1_data,   //写入rom的数�?
        output wire        ram_port_1_wr_en,  //rom的写使能
        output wire [ 7:0] ram_port_1_addr,   //rom的地址
        output wire        ram_port_1_rd_en   //rom的读使能
    );

    // * VFU �?org �?H 矩阵中的 ram 读写数据，org 只进行写操作且只进行一�?

    reg        choice_wr;  // 1 为写入原�?LLR 数据�? 为写�?
    wire [6:0] addr_choice;
    wire [6:0] addr_shif;
    reg  [6:0] org_addr_reg;  //地址打一拍对齐数�?

    always @(posedge sys_clk or negedge sys_rst_n)
        if (sys_rst_n == 1'b0)
            org_addr_reg <= 7'd0;
        else
            org_addr_reg <= org_addr;

    always @(posedge sys_clk or negedge sys_rst_n)
        if (sys_rst_n == 1'b0)
            choice_wr <= 1'b0;
        else if (flag_first_store == 1'b1)
            choice_wr <= 1'b1;
        else if (org_addr_reg == 8'd63)
            choice_wr <= 1'b0;
        else
            choice_wr <= choice_wr;


    assign addr_choice      = (choice_wr == 1'b1) ? org_addr_reg : VFU_addr;  //选择org的地址还是VFU的地址
    assign addr_shif        = (addr_choice + (8'd64 - cyclic_shif) < 8'd64) ? (addr_choice + (8'd64 - cyclic_shif)) : (addr_choice - cyclic_shif);



    assign ram_port_1_wr_en = (choice_wr == 1'b1) ? org_wr_en : VFU_wr_en;
    assign ram_port_1_data  = (choice_wr == 1'b1) ? org_data : VFU_data;
    assign ram_port_1_addr  = addr_shif;
    assign ram_port_1_rd_en = (choice_wr == 1'b1) ? 1'b0 : VFU_re_en;






endmodule
