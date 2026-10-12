module TC_Decoder2 (sel, out0, out1, out2, out3);
    parameter UUID = 0;
    parameter NAME = "";
    input [1:0] sel;
    output out0;
    output out1;
    output out2;
    output out3;

    assign {out3, out2, out1, out0} = 4'h01 << sel;
endmodule
