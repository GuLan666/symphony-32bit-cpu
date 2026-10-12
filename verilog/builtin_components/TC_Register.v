module TC_Register (clk, rst, save, save_value, out);
    parameter UUID = 0;
    parameter NAME = "";
    parameter WORD_WIDTH = 1;
    input clk;
    input rst;
    input save;
    input [WORD_WIDTH-1:0] save_value;
    output reg [WORD_WIDTH-1:0] out;

    always @ (posedge clk or posedge rst) begin
        if (rst) begin
            out <= {WORD_WIDTH{1'b0}};
        end else begin
            if (save) begin
                out <= save_value;
            end
        end
    end
endmodule
