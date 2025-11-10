`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/09/12 18:46:43
// Design Name: 
// Module Name: Encoder
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


module Encoder(
    input  [3:0] I,
    output reg [1:0] Y
);

    always @(*) begin
        casex (I)
            4'b1xxx: Y = 2'b11; // 출력 (011)
            4'b01xx: Y = 2'b10;
            4'b001x: Y = 2'b01;
            4'b0001: Y = 2'b00;
            default: Y = 2'b00; // 아무 입력도 없을 때
        endcase
    end
endmodule
