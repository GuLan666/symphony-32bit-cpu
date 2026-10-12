module TC_SplitterBit4 (in, out0, out1, out2, out3);
    parameter UUID = 0;
    parameter NAME = "";
    input [3:0] in;
    output out0;
    output out1;
    output out2;
    output out3;
    
    assign {out3, out2, out1, out0} = in;
endmodule
