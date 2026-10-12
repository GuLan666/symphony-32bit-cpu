module TC_Mux(select, in0, in1, out);
    parameter UUID = 0;
    parameter NAME = "";
    parameter WORD_WIDTH = 1;
    input select;
    input [WORD_WIDTH-1:0] in0;
    input [WORD_WIDTH-1:0] in1;
    output reg [WORD_WIDTH-1:0] out;
    
    always @ (select or in0 or in1) begin
        case(select)
        1'b0 : out = in0;
        1'b1 : out = in1;
        endcase
    end
endmodule
