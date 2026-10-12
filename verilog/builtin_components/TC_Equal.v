module TC_Equal(in0, in1, out);
    parameter UUID = 0;
    parameter NAME = "";
    parameter WORD_WIDTH = 1;
    input [WORD_WIDTH-1:0] in0;
    input [WORD_WIDTH-1:0] in1;
    output out;
    
    assign out = (in0 ^ in1) == {WORD_WIDTH{1'b0}};
endmodule
