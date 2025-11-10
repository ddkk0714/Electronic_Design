`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/09/28 21:44:47
// Design Name: 
// Module Name: upcounter
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


module upcounter (
    input  wire clk,
    input  wire rst_n,
    output reg  [1:0] q
);

    always @(posedge clk) begin
        if (!rst_n)
            q <= 2'b00;
        else
            q <= q + 1'b1;
    end

endmodule

