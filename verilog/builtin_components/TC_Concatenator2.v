module TC_Concatenator2 #(
    parameter IN0_WIDTH = 1,
    parameter IN1_WIDTH = 1,
    parameter UUID = 0,
    parameter NAME = ""
) (
    input [IN0_WIDTH-1:0] in0,
    input [IN1_WIDTH-1:0] in1,
    output [IN0_WIDTH+IN1_WIDTH-1:0] out
);
    generate
        if (IN0_WIDTH > 0 && IN1_WIDTH > 0) begin
            assign out = {in1, in0};
        end else if (IN0_WIDTH > 0) begin
            assign out = in0;
        end else if (IN1_WIDTH > 0) begin
            assign out = in1;
        end else begin
            assign out = 1'b0; // Should not happen if output is > 0 width
        end
    endgenerate
endmodule
