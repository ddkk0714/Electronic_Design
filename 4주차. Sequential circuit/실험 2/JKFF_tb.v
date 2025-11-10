`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/09/20 20:15:46
// Design Name: 
// Module Name: JKFF_tb
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


module JKFF_tb;

reg CLK;
reg J;
reg K;
wire Q;

JKFF uut (
    .CLK(CLK),
    .J(J),
    .K(K),
    .Q(Q)
);

always #5 CLK = ~CLK;

initial begin
    CLK = 0;
    J = 0;
    K = 0;

    #10 {J,K} = 2'b01;
    #20 {J,K} = 2'b00;
    #20 {J,K} = 2'b10;
    #20 {J,K} = 2'b00;
    #20 {J,K} = 2'b11;
    #20 {J,K} = 2'b00;

    #50 $stop;
end

endmodule
