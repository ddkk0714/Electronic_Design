`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/09/13 14:48:45
// Design Name: 
// Module Name: MUX2_tb
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


module MUX2_tb;
    reg [1:0] D0, D1, D2, D3;
    reg [1:0] sel;
    wire [1:0] Y;

    MUX2 uut (
        .D0(D0), .D1(D1), .D2(D2), .D3(D3),
        .sel(sel), .Y(Y)
    );
    
        initial begin
        // 입력값 설정
        D0 = 2'b00; // 0
        D1 = 2'b10; // 2
        D2 = 2'b01; // 1
        D3 = 2'b11; // 3

        sel = 2'b00; #10;
        sel = 2'b01; #10;
        sel = 2'b10; #10;
        sel = 2'b11; #10;

        $finish;
    end
endmodule
