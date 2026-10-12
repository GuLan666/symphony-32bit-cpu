module TC_Or3(in0, in1, in2, out);
    parameter UUID = 0;
    parameter NAME = "";
    parameter WORD_WIDTH = 1;
    input [WORD_WIDTH-1:0] in0;
    input [WORD_WIDTH-1:0] in1;
    input [WORD_WIDTH-1:0] in2;
    output [WORD_WIDTH-1:0] out;
    
    assign out = in0 | in1 | in2;
endmodule
