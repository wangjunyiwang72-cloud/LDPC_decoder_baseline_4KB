module combine_ram_ctrl (
        input wire sys_clk,
        input wire sys_rst_n,
        input wire flag_first_store,   // ? 控制信号给的

        // 初始写入 LLR 数据
        input wire [ 7:0] org_addr,    // org 的存储地�?，org 就是�? ram_llr 对应的地�?，也就是 org_data �?应该对应的地�?
        input wire [3:0] org_data,    // org 的数�?
        input wire        org_wr_en,   // org 的写使能

        // 变量节点更新
        input wire [ 7:0] VFU_addr,    // VFU 的写地址
        input wire [3:0] VFU_data,    // VFU 写入 ram 的数�?
        input wire        VFU_wr_en,   // VFU 的写使能
        input wire        VFU_re_en,   // VFU 的读使能
        input wire [ 7:0] cyclic_shif, // 循环移位数，即扩�? H 矩阵中对应的扩展因子

        // 校验节点更新
        input wire [3:0] ram_port_2_data,   //CFU写入rom的数�?
        input wire        ram_port_2_wr_en,  //rom的写使能CFU
        input wire [ 7:0] ram_port_2_addr,   //rom的地�?CFU
        input wire        ram_port_2_rd_en,  //rom的读使能CFU

        output wire [3:0] q_a_data,  // VFU数据
        output wire [3:0] q_b_data   // CFU数据
    );

    // * 本模块用来存储变量节点的�?
    // * 主要由读写控制模块和 RAM 存储模块组成

    wire [3:0] ram_port_1_data;
    wire        ram_port_1_wr_en;
    wire [ 7:0] ram_port_1_addr;
    wire        ram_port_1_rd_en;

    ram_port_1_ctrl ram_port_1_ctrl_inst_0  //选择初始数据还是VFU数据
                    (
                        .sys_clk         (sys_clk),
                        .sys_rst_n       (sys_rst_n),
                        .flag_first_store(flag_first_store),

                        .org_addr   (org_addr),
                        .org_data   (org_data),
                        .org_wr_en  (org_wr_en),
                        .VFU_addr   (VFU_addr),
                        .VFU_data   (VFU_data),
                        .VFU_wr_en  (VFU_wr_en),
                        .VFU_re_en  (VFU_re_en),
                        .cyclic_shif(cyclic_shif),

                        .ram_port_1_data (ram_port_1_data),
                        .ram_port_1_wr_en(ram_port_1_wr_en),
                        .ram_port_1_addr (ram_port_1_addr),
                        .ram_port_1_rd_en(ram_port_1_rd_en)

                    );

    /* ram_16_32_port2	ram_VFU_CFU_0
    (
    .aclr ( ~sys_rst_n ),
    .address_a ( ram_port_1_addr ),
    .address_b ( ram_port_2_addr ),
    .clock ( sys_clk ),
    .data_a ( ram_port_1_data ),
    .data_b ( ram_port_2_data ),
    .rden_a ( ram_port_1_rd_en),
    .rden_b ( ram_port_2_rd_en ),
    .wren_a ( ram_port_1_wr_en),
    .wren_b ( ram_port_2_wr_en ),
    .q_a (q_a_data),
    .q_b ( q_b_data )
    ); */



    //-----------------------------------------------------------------------------
    // Dual-Port RAM Instance
    // This instance represents a dual-port RAM module with independent access
    // for both Port A and Port B. Each port can be used to read or write data
    // independently, based on the control signals.
    //
    // Port A: Connected to sys_clk, ena, wea, addra, dina, and douta
    // Port B: Connected to sys_clk, enb, web, addrb, dinb, and doutb
    //-----------------------------------------------------------------------------
    dual_port_bram_16x32_write_first ram_ip_itdata (
                 .clk (sys_clk),                              // input wire clka
                 .ena  (ram_port_1_rd_en | ram_port_1_wr_en),  // input wire ena
                 .wea  (ram_port_1_wr_en),                     // input wire [0 : 0] wea
                 .addra(ram_port_1_addr),                      // input wire [6 : 0] addra
                 .dina (ram_port_1_data),                      // input wire [2 : 0] dina
                 .douta(q_a_data),                             // output wire [2 : 0] douta


                                              // input wire clkb
                 .enb  (ram_port_2_rd_en | ram_port_2_wr_en),  // input wire enb
                 .web  (ram_port_2_wr_en),                     // input wire [0 : 0] web
                 .addrb(ram_port_2_addr),                      // input wire [6 : 0] addrb
                 .dinb (ram_port_2_data),                      // input wire [2 : 0] dinb
                 .doutb(q_b_data)                              // output wire [2 : 0] doutb
             );
    //-----------------------------------------------------------------------------
    // Port Descriptions:
    // -----------------
    // clka  : Clock signal for Port A
    // ena   : Enable signal for Port A (active high)
    // wea   : Write enable for Port A (active high)
    // addra : Address input for Port A
    // dina  : Data input for Port A
    // douta : Data output from Port A
    //
    // clkb  : Clock signal for Port B
    // enb   : Enable signal for Port B (active high)
    // web   : Write enable for Port B (active high)
    // addrb : Address input for Port B
    // dinb  : Data input for Port B
    // doutb : Data output from Port B
    //-----------------------------------------------------------------------------
endmodule
