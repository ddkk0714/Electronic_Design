`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/09/11 22:33:21
// Design Name: 
// Module Name: 4BitComparator
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


module BitComparator(a, b, x, y, z);
input [3:0] a, b;
output x, y, z;

wire x, y, z;

assign x = (a > b) ? 1'b1 : 1'b0;//a>b
assign y = (a == b) ? 1'b1 : 1'b0;//a=b
assign z = (a < b) ? 1'b1 : 1'b0;//a<b

endmodule
