module TC_Not(in, out);
    parameter UUID = 0;
    parameter NAME = "";
    parameter WORD_WIDTH = 1;
    input [WORD_WIDTH-1:0] in;
    output [WORD_WIDTH-1:0] out;
    
    assign out = ~in;
endmodule
