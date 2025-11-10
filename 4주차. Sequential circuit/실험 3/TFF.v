`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/09/20 20:27:29
// Design Name: 
// Module Name: TFF
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


module TFF(CLK, RST, T, Q);

input T, CLK, RST;
output reg Q;

always @(posedge CLK or negedge RST)
begin
    if(!RST)
        Q <= 1'b0;
    else if(T)
        Q <= ~Q;
end

endmodule

