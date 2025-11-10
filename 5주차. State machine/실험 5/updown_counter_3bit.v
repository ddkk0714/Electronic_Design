`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/09/28 21:50:35
// Design Name: 
// Module Name: updown_counter_3bit
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


module updown_counter_3bit (
    input clk,
    input rst_n,
    input updown,
    output reg [2:0] q
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q <= 3'b000;   // reset -> 0
        end else begin
            if (updown)
                q <= q + 1'b1;  // up counter
            else
                q <= q - 1'b1;  // down counter
        end
    end

endmodule

