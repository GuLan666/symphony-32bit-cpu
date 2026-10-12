module TC_BitMemory (clk, rst, save, in, out);
    parameter UUID = 0;
    parameter NAME = "";
    input clk;
    input rst;
    input save;
    input [0:0] in;
    output reg [0:0] out;

    reg [0:0] value;
    reg reset;
    
    always @ (posedge clk or posedge rst) begin
        if (rst) begin
        	out <= 1'b0;
        end else begin
        	out <= value;
        	if (save) begin
        		value <= in;
			end
        end
    end
endmodule
