`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/09 16:32:05
// Design Name: 
// Module Name: dac_7seg
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



module dac_7seg(
    input clk,
    input rst,
    input [7:0] dac_val,      // DAC 값 입력
    output reg [7:0] seg_data,
    output reg [7:0] seg_sel
);

    reg [9:0] clk_div_cnt;
    reg [1:0] digit_sel;      // 0: 일의 자리, 1: 십의 자리, 2: 백의 자리
    reg [3:0] bcd;            // 현재 자리 BCD
    wire [11:0] bcd_val;      // 8비트 DAC -> BCD 3자리 (0~255)

    bin2bcd_8bit BCD1(
        .clk(clk),
        .rst(rst),
        .bin(dac_val),
        .bcd(bcd_val)
    );

    always @(posedge clk or negedge rst) begin
        if(!rst) begin
            clk_div_cnt <= 0;
            digit_sel <= 0;
        end
        else if(clk_div_cnt >= 1000) begin  // 약 1ms마다 자릿수 전환
            clk_div_cnt <= 0;
            digit_sel <= (digit_sel == 2) ? 0 : digit_sel + 1;
        end
        else begin
            clk_div_cnt <= clk_div_cnt + 1;
        end
    end

    always @(*) begin
        case(digit_sel)
            2'd0: begin
                bcd = bcd_val[3:0];      // 일의 자리
                seg_sel = 8'b11111110;
            end
            2'd1: begin
                bcd = bcd_val[7:4];      // 십의 자리
                seg_sel = 8'b11111101;
            end
            2'd2: begin
                bcd = bcd_val[11:8];     // 백의 자리
                seg_sel = 8'b11111011;
            end
            default: begin
                bcd = 4'd0;
                seg_sel = 8'b11111111;
            end
        endcase
    end

    always @(*) begin
        case(bcd)
            4'd0 : seg_data = 8'b11111100;
            4'd1 : seg_data = 8'b01100000;
            4'd2 : seg_data = 8'b11011010;
            4'd3 : seg_data = 8'b11110010;
            4'd4 : seg_data = 8'b01100110;
            4'd5 : seg_data = 8'b10110110;
            4'd6 : seg_data = 8'b10111110;
            4'd7 : seg_data = 8'b11100000;
            4'd8 : seg_data = 8'b11111110;
            4'd9 : seg_data = 8'b11110110;
            default : seg_data = 8'b00000000;
        endcase
    end

endmodule
