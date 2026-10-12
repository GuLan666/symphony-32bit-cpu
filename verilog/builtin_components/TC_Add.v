module TC_Add (cin, in0, in1, out, cout);
    parameter UUID = 0;
    parameter NAME = "";
    parameter WORD_WIDTH = 1;
    input cin;
    input [WORD_WIDTH-1:0] in0;
    input [WORD_WIDTH-1:0] in1;
    output [WORD_WIDTH-1:0] out;
    output cout;

    assign {cout, out} = in0 + in1 + cin;
endmodule
