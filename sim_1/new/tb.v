`timescale 1ns / 1ps
module tb();
reg clk,i1,i2,i3,i4,i5,i6;
wire [7:0]out1,out2;

final_lab uut(clk,i1,i2,i3,i4,i5,i6,out1,out2);


initial begin
clk=0;
forever #5 clk=~clk;
end

initial begin
#100;
$finish();
end

endmodule
