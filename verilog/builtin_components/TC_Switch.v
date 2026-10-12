module TC_Switch(enable, in, out);
    parameter UUID = 0;
    parameter NAME = "";
    parameter WORD_WIDTH = 1;
    input enable;
    input [WORD_WIDTH-1:0] in;
    output [WORD_WIDTH-1:0] out;
    
	assign out = (enable == 1'b1) ? in : {WORD_WIDTH{1'b0}};
endmodule
