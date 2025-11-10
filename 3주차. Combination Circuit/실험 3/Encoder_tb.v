`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/09/12 18:50:56
// Design Name: 
// Module Name: Encoder_tb
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


module Encoder_tb;
    reg  [3:0] I;
    wire [2:0] Y;

    Encoder dut (
        .I(I),
        .Y(Y)
    );

    initial begin
        I = 4'b0000; #10;
        I = 4'b1000; #10; 
        I = 4'b1011; #10;
        I = 4'b0101; #10; 
        I = 4'b0001; #10; 

        $finish;
    end
endmodule
