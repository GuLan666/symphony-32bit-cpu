module TC_RAM_BE_NRST_L32_S32 #(
    parameter ADDR_WIDTH = 8,
    parameter MEM_FILE = ""
) (
    input clk,
    input rst,
    input en0,
    input [ADDR_WIDTH-1:0] addr0,
    output [32-1:0] out0,
    input en1,
    input [ADDR_WIDTH-1:0] addr1,
    input [32-1:0] in1
);
    reg [7:0] ram [0:(1<<ADDR_WIDTH)-1];

    initial $readmemh(MEM_FILE, ram);

    assign out0 = en0 ? {(ram[addr0 + 0]), (ram[addr0 + 1]), (ram[addr0 + 2]), (ram[addr0 + 3])} : 32'b0;

    always @(posedge clk) begin
        if (!rst) begin
            if (en1) begin
                ram[addr1 + 0] <= in1[24 +: 8];
                ram[addr1 + 1] <= in1[16 +: 8];
                ram[addr1 + 2] <= in1[8 +: 8];
                ram[addr1 + 3] <= in1[0 +: 8];
            end
        end
    end
endmodule
