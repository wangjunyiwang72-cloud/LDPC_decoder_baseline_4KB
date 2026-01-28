module combine_ram_llr (
        input wire        sys_clk,
        input wire        sys_rst_n,
        input wire        flag_org_read_start,  // ? 控制信号给的
        input wire [ 6:0] buffer_addr,          // buffer 给的存储模块内部地址索引
        input wire [3:0] rr_data,
        input wire        buffer_wr_en,         // buffer 给的写入 ram 有效信号

        output wire [3:0] org_data,
        output wire [6:0] org_addr,
        output wire        org_wr_en,
        output wire        flag_org_read_end    // 读取完成

    );

    // * 本模块主要实现 LLR 原始数据的存储
    // * 主要由读写控制模块和 RAM 存储模块组成


    /* ram_16_32_port2	ram_llr_data_0
    (
    	.aclr ( ~sys_rst_n ),
    	.address_a ( buffer_addr ),
    	.address_b ( org_addr ),
    	.clock ( sys_clk ),
    	.data_a ( rr_data ),
    	.data_b (  ),
    	.rden_a ( 1'b0 ),
    	.rden_b ( org_wr_en ),
    	.wren_a ( buffer_wr_en ),
    	.wren_b ( 1'b0 ),
    	.q_a (),
    	.q_b ( org_data )
    );
     */

    // RAM_IP
    dual_port_bram_16x32_write_first ram_org (
                 .clk (sys_clk),       // input wire clka
                 .ena  (buffer_wr_en),  // input wire ena
                 .wea  (buffer_wr_en),  // input wire [0 : 0] wea
                 .addra(buffer_addr),   // input wire [6 : 0] addra
                 .dina (rr_data),       // input wire [2 : 0] dina
                 .douta(),              // output wire [2 : 0] douta


                    // input wire clkb
                 .enb  (org_wr_en),  // input wire enb
                 .web  (1'b0),       // input wire [0 : 0] web
                 .addrb(org_addr),   // input wire [6 : 0] addrb
                 .dinb (),           // input wire [2 : 0] dinb
                 .doutb(org_data)    // output wire [2 : 0] doutb
             );

    // 读写控制模块
    org_read org_read_inst_0 (
                 .sys_clk            (sys_clk),
                 .sys_rst_n          (sys_rst_n),
                 .flag_org_read_start(flag_org_read_start),

                 .org_addr         (org_addr),
                 .org_rd_en        (org_wr_en),
                 .flag_org_read_end(flag_org_read_end)
             );

endmodule
