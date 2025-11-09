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
    input        clk,
    input        rst,
    input  [7:0] dac_val,    // 추가 <- DAC 디지털 값

    output reg [7:0] seg_sel,
    output reg [7:0] seg
);

    reg [32:0] clk_count;
    parameter COUNT_CLK = 32'd100000;  // 필요하면 조절

    reg [3:0] digit;

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            seg_sel   <= 8'b1111_1110; // 맨 오른쪽 자리부터
            clk_count <= 0;
        end else begin
            if (clk_count > COUNT_CLK) begin
                seg_sel   <= {seg_sel[6:0], seg_sel[7]};
                clk_count <= 0;
            end else begin
                clk_count <= clk_count + 1;
            end
        end
    end

    always @(*) begin
        case (seg_sel)
            8'b1111_1110: digit = dac_val[3:0];
            8'b1111_1101: digit = dac_val[7:4];
            default:      digit = 4'hF;
        endcase

        case (digit)
            4'h0: seg = 8'b1111_1100;
            4'h1: seg = 8'b0110_0000;
            4'h2: seg = 8'b1101_1010;
            4'h3: seg = 8'b1111_0010;
            4'h4: seg = 8'b0110_0110;
            4'h5: seg = 8'b1011_0110;
            4'h6: seg = 8'b1011_1110;
            4'h7: seg = 8'b1110_0100;
            4'h8: seg = 8'b1111_1110;
            4'h9: seg = 8'b1111_0110;
            4'hA: seg = 8'b1110_1110;
            4'hB: seg = 8'b0011_1110;
            4'hC: seg = 8'b1001_1100;
            4'hD: seg = 8'b0111_1010;
            4'hE: seg = 8'b1001_1110;
            4'hF: seg = 8'b1000_1110;
            default: seg = 8'b0000_0000;
        endcase
    end

endmodule
