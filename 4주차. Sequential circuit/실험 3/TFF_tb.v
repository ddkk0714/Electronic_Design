`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/09/20 20:28:01
// Design Name: 
// Module Name: TFF_tb
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

module TFF_tb;

    reg CLK;
    reg RST;
    reg T;
    wire Q;

    TFF UUT (
        .CLK(CLK),
        .RST(RST),
        .T(T),
        .Q(Q)
    );
    always #5 CLK = ~CLK;

    initial begin
        CLK = 0;
        RST = 1;
        T   = 0;

        #10 RST = 0;
        #10 RST = 1;

        #100 T = 1;
        #100  T = 0;

        #100 T = 1;
        #100 T = 0;

        #20 T = 1; 
        #8  T = 0;

        #50 $stop;
    end

endmodule

