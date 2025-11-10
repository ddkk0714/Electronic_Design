`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/10/09 23:25:16
// Design Name: 
// Module Name: Binary_to_BCD
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


module Binary_to_BCD (
    input  [3:0] bin,
    output reg [3:0] tens,
    output reg [3:0] ones
);

    always @(*) begin
        if (bin < 10) begin
            tens = 4'd0;
            ones = bin;
        end else begin
            tens = 4'd1;
            ones = bin - 4'd10;
        end
    end

endmodule

