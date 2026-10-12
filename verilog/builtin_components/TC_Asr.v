module TC_Asr (in, amount, out);
    parameter UUID = 0;
    parameter NAME = "";
    parameter WORD_WIDTH = 1;
    input [WORD_WIDTH-1:0] in;
    input [7:0] amount;
    output [WORD_WIDTH-1:0] out;

    wire signed [WORD_WIDTH-1:0] s_in = in;
    assign out = (amount < WORD_WIDTH) ? (s_in >>> amount) : {WORD_WIDTH{in[WORD_WIDTH-1]}};
endmodule
