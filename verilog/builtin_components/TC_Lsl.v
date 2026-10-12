module TC_Lsl (in, amount, out);
    parameter UUID = 0;
    parameter NAME = "";
    parameter WORD_WIDTH = 1;
    input [WORD_WIDTH-1:0] in;
    input [7:0] amount;
    output [WORD_WIDTH-1:0] out;

    assign out = in << (amount % WORD_WIDTH);
endmodule
