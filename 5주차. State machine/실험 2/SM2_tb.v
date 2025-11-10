`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/09/28 21:40:22
// Design Name: 
// Module Name: SM2_tb
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


module SM2_tb;

    reg clk, rst;
    reg A, B, C;
    wire [2:0] state;
    wire y;

    SM2 dut (
        .clk(clk),
        .rst(rst),
        .A(A),
        .B(B),
        .C(C),
        .state(state),
        .y(y)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0; rst = 0; A = 0; B = 0; C = 0;
        #12 rst = 1;   // reset release

        #10 A = 1; #10 A = 0;
        #10 B = 1; #10 B = 0;
        #10 A = 1; #10 A = 0;
        #10 B = 1; #10 B = 0;
        #10 C = 1; #10 C = 0;

        #10 rst = 0; 
        #10 rst = 1;

        #10 A = 1; #10 A = 0;
        #10 B = 1; #10 B = 0;
        #10 C = 1; #10 C = 0;

        #50 $finish;
    end
endmodule

