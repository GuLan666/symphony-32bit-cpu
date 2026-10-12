module TC_Buffer #(
    parameter WORD_WIDTH = 8
) (
    input [WORD_WIDTH-1:0] in,
    output [WORD_WIDTH-1:0] out
);
    assign out = in;
endmodule
