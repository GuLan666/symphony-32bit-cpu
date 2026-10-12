module TC_MakerBit4 (in0, in1, in2, in3, out);
    parameter UUID = 0;
    parameter NAME = "";
    input in0;
    input in1;
    input in2;
    input in3;
    output [3:0] out;
    
    assign out = {in3, in2, in1, in0};
endmodule
