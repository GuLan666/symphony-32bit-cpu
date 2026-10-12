module TC_RAM_BE_L32_L32_S32 #(
    parameter ADDR_WIDTH = 8
) (
    input clk,
    input rst,
    input en0,
    input [ADDR_WIDTH-1:0] addr0,
    output [32-1:0] out0,
    input en1,
    input [ADDR_WIDTH-1:0] addr1,
    output [32-1:0] out1,
    input en2,
    input [ADDR_WIDTH-1:0] addr2,
    input [32-1:0] in2
);
    reg [7:0] ram [0:(1<<ADDR_WIDTH)-1];
    integer rst_i;

    initial begin
        for (rst_i = 0; rst_i < (1 << ADDR_WIDTH); rst_i = rst_i + 1)
            ram[rst_i] = 8'h0;
    end

    assign out0 = en0 ? {(ram[addr0 + 0]), (ram[addr0 + 1]), (ram[addr0 + 2]), (ram[addr0 + 3])} : 32'b0;
    assign out1 = en1 ? {(ram[addr1 + 0]), (ram[addr1 + 1]), (ram[addr1 + 2]), (ram[addr1 + 3])} : 32'b0;

    always @(posedge clk) begin
        if (rst) begin
            for (rst_i = 0; rst_i < (1<<ADDR_WIDTH); rst_i = rst_i + 1)
                ram[rst_i] <= 8'h0;
        end else begin
            if (en2) begin
                ram[addr2 + 0] <= in2[24 +: 8];
                ram[addr2 + 1] <= in2[16 +: 8];
                ram[addr2 + 2] <= in2[8 +: 8];
                ram[addr2 + 3] <= in2[0 +: 8];
            end
        end
    end
endmodule
