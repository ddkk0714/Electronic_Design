`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/09/20 19:52:55
// Design Name: 
// Module Name: DFF_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DFF_tb;

reg CLK;
reg D;
wire Q;

DFF uut (
    .CLK(CLK),
    .D(D),
    .Q(Q)
);

always #5 CLK = ~CLK;

initial begin
    CLK = 0;
    D = 0;

    #20 D = 1;
    #20 D = 0;

    #20 D = 1;
    #20 D = 0;

    #20 D = 1;
    #20 D = 0;

    #50 $stop;
end

endmodule
