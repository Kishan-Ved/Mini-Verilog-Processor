`timescale 1ns / 1ps


module clock_divider(main_clk,slow_clk);
input main_clk;
output slow_clk;
reg[31:0]counter;
always@(posedge main_clk)begin
counter = counter + 1;
end
assign slow_clk = counter[27];
endmodule