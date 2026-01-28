module dual_port_bram_16x32_write_first(
    input clk,       // 共享时钟
    input ena,      // 端口A的使能
    input enb,      // 端口B的使能
    input [3:0] dina, // 端口A的数据输入
    input [3:0] dinb, // 端口B的数据输入
    input [6:0] addra, // 端口A的地址输入
    input [6:0] addrb, // 端口B的地址输入
    input wea,        // 端口A的写使能
    input web,        // 端口B的写使能
    output reg [3:0] douta, // 端口A的数据输出
    output reg [3:0] doutb  // 端口B的数据输出
);

// BRAM声明
reg [3:0] mem [63:0]; // 128个4位宽的存储单元

// 同步读写操作
always @(posedge clk) begin
    // 端口A的读写操作
    if (ena) begin
        if (wea) begin
            // 写操作
            mem[addra] <= dina;
            douta <= dina; // 写操作的结果立即反映在输出上
        end else begin
            // 读操作
            douta <= mem[addra];
        end
    end

    // 端口B的读写操作
    if (enb) begin
        if (web) begin
            // 写操作
            mem[addrb] <= dinb;
            doutb <= dinb; // 写操作的结果立即反映在输出上
        end else begin
            // 读操作
            doutb <= mem[addrb];
        end
    end
end

endmodule