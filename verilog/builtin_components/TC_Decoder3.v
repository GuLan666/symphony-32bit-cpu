module TC_Decoder3 (dis, sel, out0, out1, out2, out3, out4, out5, out6, out7);
    parameter UUID = 0;
    parameter NAME = "";
    input dis;
    input [2:0] sel;
    output out0;
    output out1;
    output out2;
    output out3;
    output out4;
    output out5;
    output out6;
    output out7;

    wire [7:0] tmp_out = (!dis) ? (8'h01 << sel) : 8'h00;

    assign {out7, out6, out5, out4, out3, out2, out1, out0} = tmp_out;
endmodule
