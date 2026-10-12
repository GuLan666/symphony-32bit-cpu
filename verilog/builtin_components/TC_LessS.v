module TC_LessS(in0, in1, out);
    parameter UUID = 0;
    parameter NAME = "";
    parameter WORD_WIDTH = 1;
    input signed [WORD_WIDTH-1:0] in0;
    input signed [WORD_WIDTH-1:0] in1;
    output out;
    
    assign out = in0 < in1;
endmodule
