
module TC_Constant(out);
    parameter UUID = 0;
    parameter NAME = "";
    parameter WORD_WIDTH = 1;
    parameter value = {WORD_WIDTH{1'b0}};
    output [WORD_WIDTH-1:0] out;
    
    assign out = value;
endmodule
