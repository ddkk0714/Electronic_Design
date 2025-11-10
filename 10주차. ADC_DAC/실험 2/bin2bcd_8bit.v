`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/10/09 23:33:48
// Design Name: 
// Module Name: bin2bcd
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


module bin2bcd_8bit(
    input clk,
    input rst,
    input [7:0] bin,
    output reg [11:0] bcd
);

    integer i;
    reg [19:0] shift_reg; // 8-bit bin + 12-bit BCD = 20-bit

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            bcd <= 12'd0;
        end else begin
            shift_reg = 20'd0;
            shift_reg[7:0] = bin;  // 하위 8비트에 입력값 저장

            for (i = 0; i < 8; i = i + 1) begin
                // 상위 BCD 3자리 검사 후 5 이상이면 3 더하기
                if (shift_reg[11:8] >= 5) shift_reg[11:8] = shift_reg[11:8] + 3;
                if (shift_reg[7:4]  >= 5) shift_reg[7:4]  = shift_reg[7:4]  + 3;
                if (shift_reg[3:0]  >= 5) shift_reg[3:0]  = shift_reg[3:0]  + 3;

                // 왼쪽으로 1비트 시프트
                shift_reg = shift_reg << 1;
            end

            bcd <= shift_reg[19:8]; // 상위 12비트가 BCD
        end
    end

endmodule


