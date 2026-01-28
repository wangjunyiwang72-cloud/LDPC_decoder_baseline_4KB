module CFU_102_ctrl (
        input wire sys_clk,
        input wire sys_rst_n,
        input wire flag_CFU_start,		   // ? 控制信号给的

        input wire [3:0] ram_CFU_data_1 ,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_2 ,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_3 ,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_4 ,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_5 ,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_6 ,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_7 ,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_8 ,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_9 ,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_10,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_11,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_12,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_13,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_14,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_15,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_16,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_17,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_18,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_19,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_20,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_21,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_22,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_23,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_24,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_25,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_26,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_27,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_28,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_29,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_30,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_31,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_32,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_33,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_34,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_35,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_36,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_37,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_38,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_39,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_40,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_41,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_42,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_43,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_44,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_45,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_46,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_47,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_48,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_49,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_50,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_51,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_52,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_53,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_54,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_55,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_56,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_57,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_58,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_59,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_60,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_61,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_62,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_63,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_64,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_65,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_66,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_67,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_68,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_69,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_70,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_71,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_72,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_73,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_74,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_75,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_76,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_77,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_78,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_79,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_80,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_81,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_82,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_83,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_84,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_85,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_86,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_87,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_88,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_89,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_90,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_91,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_92,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_93,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_94,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_95,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_96,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_97,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_98,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_99,  //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_100, //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_101, //ram_port1的数据输�?
        input wire [3:0] ram_CFU_data_102, //ram_port1的数据输�?
           

        output reg  [7:0] CFU_addr,

        output wire [3:0] CFU_data_1 ,
        output wire [3:0] CFU_data_2 ,
        output wire [3:0] CFU_data_3 ,
        output wire [3:0] CFU_data_4 ,
        output wire [3:0] CFU_data_5 ,
        output wire [3:0] CFU_data_6 ,
        output wire [3:0] CFU_data_7 ,
        output wire [3:0] CFU_data_8 ,
        output wire [3:0] CFU_data_9 ,
        output wire [3:0] CFU_data_10,
        output wire [3:0] CFU_data_11,
        output wire [3:0] CFU_data_12,
        output wire [3:0] CFU_data_13,
        output wire [3:0] CFU_data_14,
        output wire [3:0] CFU_data_15,
        output wire [3:0] CFU_data_16,
        output wire [3:0] CFU_data_17,
        output wire [3:0] CFU_data_18,
        output wire [3:0] CFU_data_19,
        output wire [3:0] CFU_data_20,
        output wire [3:0] CFU_data_21,
        output wire [3:0] CFU_data_22,
        output wire [3:0] CFU_data_23,
        output wire [3:0] CFU_data_24,
        output wire [3:0] CFU_data_25,
        output wire [3:0] CFU_data_26,
        output wire [3:0] CFU_data_27,
        output wire [3:0] CFU_data_28,
        output wire [3:0] CFU_data_29,
        output wire [3:0] CFU_data_30,
        output wire [3:0] CFU_data_31,
        output wire [3:0] CFU_data_32,
        output wire [3:0] CFU_data_33,
        output wire [3:0] CFU_data_34,
        output wire [3:0] CFU_data_35,
        output wire [3:0] CFU_data_36,
        output wire [3:0] CFU_data_37,
        output wire [3:0] CFU_data_38,
        output wire [3:0] CFU_data_39,
        output wire [3:0] CFU_data_40,
        output wire [3:0] CFU_data_41,
        output wire [3:0] CFU_data_42,
        output wire [3:0] CFU_data_43,
        output wire [3:0] CFU_data_44,
        output wire [3:0] CFU_data_45,
        output wire [3:0] CFU_data_46,
        output wire [3:0] CFU_data_47,
        output wire [3:0] CFU_data_48,
        output wire [3:0] CFU_data_49,
        output wire [3:0] CFU_data_50,
        output wire [3:0] CFU_data_51,
        output wire [3:0] CFU_data_52,
        output wire [3:0] CFU_data_53,
        output wire [3:0] CFU_data_54,
        output wire [3:0] CFU_data_55,
        output wire [3:0] CFU_data_56,
        output wire [3:0] CFU_data_57,
        output wire [3:0] CFU_data_58,
        output wire [3:0] CFU_data_59,
        output wire [3:0] CFU_data_60,
        output wire [3:0] CFU_data_61,
        output wire [3:0] CFU_data_62,
        output wire [3:0] CFU_data_63,
        output wire [3:0] CFU_data_64,
        output wire [3:0] CFU_data_65,
        output wire [3:0] CFU_data_66,
        output wire [3:0] CFU_data_67,
        output wire [3:0] CFU_data_68,
        output wire [3:0] CFU_data_69,
        output wire [3:0] CFU_data_70,
        output wire [3:0] CFU_data_71,
        output wire [3:0] CFU_data_72,
        output wire [3:0] CFU_data_73,
        output wire [3:0] CFU_data_74,
        output wire [3:0] CFU_data_75,
        output wire [3:0] CFU_data_76,
        output wire [3:0] CFU_data_77,
        output wire [3:0] CFU_data_78,
        output wire [3:0] CFU_data_79,
        output wire [3:0] CFU_data_80,
        output wire [3:0] CFU_data_81,
        output wire [3:0] CFU_data_82,
        output wire [3:0] CFU_data_83,
        output wire [3:0] CFU_data_84,
        output wire [3:0] CFU_data_85,
        output wire [3:0] CFU_data_86,
        output wire [3:0] CFU_data_87,
        output wire [3:0] CFU_data_88,
        output wire [3:0] CFU_data_89,
        output wire [3:0] CFU_data_90,
        output wire [3:0] CFU_data_91,
        output wire [3:0] CFU_data_92,
        output wire [3:0] CFU_data_93,
        output wire [3:0] CFU_data_94,
        output wire [3:0] CFU_data_95,
        output wire [3:0] CFU_data_96,
        output wire [3:0] CFU_data_97,
        output wire [3:0] CFU_data_98,
        output wire [3:0] CFU_data_99,
        output wire [3:0] CFU_data_100,
        output wire [3:0] CFU_data_101,
        output wire [3:0] CFU_data_102,

        output wire        CFU_wr_en,    //CFU的写使能
        output wire        CFU_re_en,    //CFU的读使能
        output reg         flag_CFU_end  //CFU模块更新完成
    );

	// * 校验节点更新模块，一共实例化�?4 个，本模块行权重�?102
	// * 采用纯正的组合逻辑实现 MS 算法
	// * 一个周期从 combine_ram_ctrl 读，下一个周期再�?combine_ram_ctrl 的同一地址�?

    reg cnt_rd_wr;
    reg CFU_en;


	// 开始进�?CFU 操作
    always @(posedge sys_clk or negedge sys_rst_n)
        if (sys_rst_n == 1'b0)
            CFU_en <= 1'b0;
        else if (CFU_addr == 8'd63 && cnt_rd_wr == 1'b1)
            CFU_en <= 1'b0;
        else if (flag_CFU_start == 1'b1)
            CFU_en <= 1'b1;
        else
            CFU_en <= CFU_en;


	// 判断什么时候中�?
    always @(posedge sys_clk or negedge sys_rst_n)
        if (sys_rst_n == 1'b0)
            flag_CFU_end <= 1'b0;
        else if (CFU_addr == 8'd63 && cnt_rd_wr == 1'b1)
            flag_CFU_end <= 1'b1;
        else
            flag_CFU_end <= 1'b0;


	// 生成读写的地址
    always @(posedge sys_clk or negedge sys_rst_n)
        if (sys_rst_n == 1'b0)
            CFU_addr <= 8'd0;
        else if (flag_CFU_start == 1'b1 || (CFU_addr == 8'd63 && cnt_rd_wr == 1'b1))
            CFU_addr <= 8'd0;
        else if (cnt_rd_wr == 1'b1 && CFU_en == 1'b1)
            CFU_addr <= CFU_addr + 1'd1;
        else
            CFU_addr <= CFU_addr;


	// 奇偶实现一周期读，一周期�?
    always @(posedge sys_clk or negedge sys_rst_n)
        if (sys_rst_n == 1'b0)
            cnt_rd_wr <= 1'b0;
        else if (CFU_en == 1'b0)
            cnt_rd_wr <= 1'b0;
        else if (CFU_en == 1'b1)
            cnt_rd_wr <= cnt_rd_wr + 1'b1;
        else
            cnt_rd_wr <= cnt_rd_wr;


    assign CFU_re_en = (cnt_rd_wr == 1'b0 && CFU_en == 1'b1) ? 1'b1 : 1'b0;
    assign CFU_wr_en = (cnt_rd_wr == 1'b1 && CFU_en == 1'b1) ? 1'b1 : 1'b0;


	// 纯正组合逻辑实现 MS 算法
    min_least_102 min_least_102_inst1 (
                    .in_data_1 (ram_CFU_data_1 ),
                    .in_data_2 (ram_CFU_data_2 ),
                    .in_data_3 (ram_CFU_data_3 ),
                    .in_data_4 (ram_CFU_data_4 ),
                    .in_data_5 (ram_CFU_data_5 ),
                    .in_data_6 (ram_CFU_data_6 ),
                    .in_data_7 (ram_CFU_data_7 ),
                    .in_data_8 (ram_CFU_data_8 ),
                    .in_data_9 (ram_CFU_data_9 ),
                    .in_data_10(ram_CFU_data_10),
                    .in_data_11(ram_CFU_data_11),
                    .in_data_12(ram_CFU_data_12),
                    .in_data_13(ram_CFU_data_13),
                    .in_data_14(ram_CFU_data_14),
                    .in_data_15(ram_CFU_data_15),
                    .in_data_16(ram_CFU_data_16),
                    .in_data_17(ram_CFU_data_17),
                    .in_data_18(ram_CFU_data_18),
                    .in_data_19(ram_CFU_data_19),
                    .in_data_20(ram_CFU_data_20),
                    .in_data_21(ram_CFU_data_21),
                    .in_data_22(ram_CFU_data_22),
                    .in_data_23(ram_CFU_data_23),
                    .in_data_24(ram_CFU_data_24),
                    .in_data_25(ram_CFU_data_25),
                    .in_data_26(ram_CFU_data_26),
                    .in_data_27(ram_CFU_data_27),
                    .in_data_28(ram_CFU_data_28),
                    .in_data_29(ram_CFU_data_29),
                    .in_data_30(ram_CFU_data_30),
                    .in_data_31(ram_CFU_data_31),
                    .in_data_32(ram_CFU_data_32),
                    .in_data_33(ram_CFU_data_33),
                    .in_data_34(ram_CFU_data_34),
                    .in_data_35(ram_CFU_data_35),
                    .in_data_36(ram_CFU_data_36),
                    .in_data_37(ram_CFU_data_37),
                    .in_data_38(ram_CFU_data_38),
                    .in_data_39(ram_CFU_data_39),
                    .in_data_40(ram_CFU_data_40),
                    .in_data_41(ram_CFU_data_41),
                    .in_data_42(ram_CFU_data_42),
                    .in_data_43(ram_CFU_data_43),
                    .in_data_44(ram_CFU_data_44),
                    .in_data_45(ram_CFU_data_45),
                    .in_data_46(ram_CFU_data_46),
                    .in_data_47(ram_CFU_data_47),
                    .in_data_48(ram_CFU_data_48),
                    .in_data_49(ram_CFU_data_49),
                    .in_data_50(ram_CFU_data_50),
                    .in_data_51(ram_CFU_data_51),
                    .in_data_52(ram_CFU_data_52),
                    .in_data_53(ram_CFU_data_53),
                    .in_data_54(ram_CFU_data_54),
                    .in_data_55(ram_CFU_data_55),
                    .in_data_56(ram_CFU_data_56),
                    .in_data_57(ram_CFU_data_57),
                    .in_data_58(ram_CFU_data_58),
                    .in_data_59(ram_CFU_data_59),
                    .in_data_60(ram_CFU_data_60),
                    .in_data_61(ram_CFU_data_61),
                    .in_data_62(ram_CFU_data_62),
                    .in_data_63(ram_CFU_data_63),
                    .in_data_64(ram_CFU_data_64),
                    .in_data_65(ram_CFU_data_65),
                    .in_data_66(ram_CFU_data_66),
                    .in_data_67(ram_CFU_data_67),
                    .in_data_68(ram_CFU_data_68),
                    .in_data_69(ram_CFU_data_69),
                    .in_data_70(ram_CFU_data_70),
                    .in_data_71(ram_CFU_data_71),
                    .in_data_72(ram_CFU_data_72),
                    .in_data_73(ram_CFU_data_73),
                    .in_data_74(ram_CFU_data_74),
                    .in_data_75(ram_CFU_data_75),
                    .in_data_76(ram_CFU_data_76),
                    .in_data_77(ram_CFU_data_77),
                    .in_data_78(ram_CFU_data_78),
                    .in_data_79(ram_CFU_data_79),
                    .in_data_80(ram_CFU_data_80),
                    .in_data_81(ram_CFU_data_81),
                    .in_data_82(ram_CFU_data_82),
                    .in_data_83(ram_CFU_data_83),
                    .in_data_84(ram_CFU_data_84),
                    .in_data_85(ram_CFU_data_85),
                    .in_data_86(ram_CFU_data_86),
                    .in_data_87(ram_CFU_data_87),
                    .in_data_88(ram_CFU_data_88),
                    .in_data_89(ram_CFU_data_89),
                    .in_data_90(ram_CFU_data_90),
                    .in_data_91(ram_CFU_data_91),
                    .in_data_92(ram_CFU_data_92),
                    .in_data_93(ram_CFU_data_93),
                    .in_data_94(ram_CFU_data_94),
                    .in_data_95(ram_CFU_data_95),
                    .in_data_96(ram_CFU_data_96),
                    .in_data_97(ram_CFU_data_97),
                    .in_data_98(ram_CFU_data_98),
                    .in_data_99(ram_CFU_data_99),
                    .in_data_100(ram_CFU_data_100),
                    .in_data_101(ram_CFU_data_101),
                    .in_data_102(ram_CFU_data_102),

                    .out_data_1 (CFU_data_1 ),
                    .out_data_2 (CFU_data_2 ),
                    .out_data_3 (CFU_data_3 ),
                    .out_data_4 (CFU_data_4 ),
                    .out_data_5 (CFU_data_5 ),
                    .out_data_6 (CFU_data_6 ),
                    .out_data_7 (CFU_data_7 ),
                    .out_data_8 (CFU_data_8 ),
                    .out_data_9 (CFU_data_9 ),
                    .out_data_10(CFU_data_10),
                    .out_data_11(CFU_data_11),
                    .out_data_12(CFU_data_12),
                    .out_data_13(CFU_data_13),
                    .out_data_14(CFU_data_14),
                    .out_data_15(CFU_data_15),
                    .out_data_16(CFU_data_16),
                    .out_data_17(CFU_data_17),
                    .out_data_18(CFU_data_18),
                    .out_data_19(CFU_data_19),
                    .out_data_20(CFU_data_20),
                    .out_data_21(CFU_data_21),
                    .out_data_22(CFU_data_22),
                    .out_data_23(CFU_data_23),
                    .out_data_24(CFU_data_24),
                    .out_data_25(CFU_data_25),
                    .out_data_26(CFU_data_26),
                    .out_data_27(CFU_data_27),
                    .out_data_28(CFU_data_28),
                    .out_data_29(CFU_data_29),
                    .out_data_30(CFU_data_30),
                    .out_data_31(CFU_data_31),
                    .out_data_32(CFU_data_32),
                    .out_data_33(CFU_data_33),
                    .out_data_34(CFU_data_34),
                    .out_data_35(CFU_data_35),
                    .out_data_36(CFU_data_36),
                    .out_data_37(CFU_data_37),
                    .out_data_38(CFU_data_38),
                    .out_data_39(CFU_data_39),
                    .out_data_40(CFU_data_40),
                    .out_data_41(CFU_data_41),
                    .out_data_42(CFU_data_42),
                    .out_data_43(CFU_data_43),
                    .out_data_44(CFU_data_44),
                    .out_data_45(CFU_data_45),
                    .out_data_46(CFU_data_46),
                    .out_data_47(CFU_data_47),
                    .out_data_48(CFU_data_48),
                    .out_data_49(CFU_data_49),
                    .out_data_50(CFU_data_50),
                    .out_data_51(CFU_data_51),
                    .out_data_52(CFU_data_52),
                    .out_data_53(CFU_data_53),
                    .out_data_54(CFU_data_54),
                    .out_data_55(CFU_data_55),
                    .out_data_56(CFU_data_56),
                    .out_data_57(CFU_data_57),
                    .out_data_58(CFU_data_58),
                    .out_data_59(CFU_data_59),
                    .out_data_60(CFU_data_60),
                    .out_data_61(CFU_data_61),
                    .out_data_62(CFU_data_62),
                    .out_data_63(CFU_data_63),
                    .out_data_64(CFU_data_64),
                    .out_data_65(CFU_data_65),
                    .out_data_66(CFU_data_66),
                    .out_data_67(CFU_data_67),
                    .out_data_68(CFU_data_68),
                    .out_data_69(CFU_data_69),
                    .out_data_70(CFU_data_70),
                    .out_data_71(CFU_data_71),
                    .out_data_72(CFU_data_72),
                    .out_data_73(CFU_data_73),
                    .out_data_74(CFU_data_74),
                    .out_data_75(CFU_data_75),
                    .out_data_76(CFU_data_76),
                    .out_data_77(CFU_data_77),
                    .out_data_78(CFU_data_78),
                    .out_data_79(CFU_data_79),
                    .out_data_80(CFU_data_80),
                    .out_data_81(CFU_data_81),
                    .out_data_82(CFU_data_82),
                    .out_data_83(CFU_data_83),
                    .out_data_84(CFU_data_84),
                    .out_data_85(CFU_data_85),
                    .out_data_86(CFU_data_86),
                    .out_data_87(CFU_data_87),
                    .out_data_88(CFU_data_88),
                    .out_data_89(CFU_data_89),
                    .out_data_90(CFU_data_90),
                    .out_data_91(CFU_data_91),
                    .out_data_92(CFU_data_92),
                    .out_data_93(CFU_data_93),
                    .out_data_94(CFU_data_94),
                    .out_data_95(CFU_data_95),
                    .out_data_96(CFU_data_96),
                    .out_data_97(CFU_data_97),
                    .out_data_98(CFU_data_98),
                    .out_data_99(CFU_data_99),
                    .out_data_100(CFU_data_100),
                    .out_data_101(CFU_data_101),
                    .out_data_102(CFU_data_102)

                );




endmodule
