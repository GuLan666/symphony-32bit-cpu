module TC_RAM_BE_NRST_L8_L16_L32_L32_S8_S16_S32 #(
    parameter ADDR_WIDTH = 8,
    parameter MEM_FILE = ""
) (
    input clk,
    input rst,
    input en0,
    input [ADDR_WIDTH-1:0] addr0,
    output [8-1:0] out0,
    input en1,
    input [ADDR_WIDTH-1:0] addr1,
    output [16-1:0] out1,
    input en2,
    input [ADDR_WIDTH-1:0] addr2,
    output [32-1:0] out2,
    input en3,
    input [ADDR_WIDTH-1:0] addr3,
    output [32-1:0] out3,
    input en4,
    input [ADDR_WIDTH-1:0] addr4,
    input [8-1:0] in4,
    input en5,
    input [ADDR_WIDTH-1:0] addr5,
    input [16-1:0] in5,
    input en6,
    input [ADDR_WIDTH-1:0] addr6,
    input [32-1:0] in6
);
    reg [7:0] ram [0:(1<<ADDR_WIDTH)-1];

    initial $readmemh(MEM_FILE, ram);

    assign out0 = en0 ? {(ram[addr0 + 0])} : 8'b0;
    assign out1 = en1 ? {(ram[addr1 + 0]), (ram[addr1 + 1])} : 16'b0;
    assign out2 = en2 ? {(ram[addr2 + 0]), (ram[addr2 + 1]), (ram[addr2 + 2]), (ram[addr2 + 3])} : 32'b0;
    assign out3 = en3 ? {(ram[addr3 + 0]), (ram[addr3 + 1]), (ram[addr3 + 2]), (ram[addr3 + 3])} : 32'b0;

    always @(posedge clk) begin
        if (!rst) begin
            if (en4) begin
                ram[addr4 + 0] <= in4[0 +: 8];
            end
            if (en5) begin
                ram[addr5 + 0] <= in5[8 +: 8];
                ram[addr5 + 1] <= in5[0 +: 8];
            end
            if (en6) begin
                ram[addr6 + 0] <= in6[24 +: 8];
                ram[addr6 + 1] <= in6[16 +: 8];
                ram[addr6 + 2] <= in6[8 +: 8];
                ram[addr6 + 3] <= in6[0 +: 8];
            end
        end
    end
endmodule
