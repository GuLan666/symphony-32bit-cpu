module TC_StaticIndexer #(
    parameter INPUT_WIDTH = 8,
    parameter OUTPUT_WIDTH = 8,
    parameter integer SHIFT = 0
) (
    input [INPUT_WIDTH-1:0] in,
    output [OUTPUT_WIDTH-1:0] out
);
    // Positive SHIFT = right shift, negative SHIFT = left shift
    assign out = (SHIFT >= 0) ? (in >> SHIFT) : (in << (-SHIFT));
endmodule
