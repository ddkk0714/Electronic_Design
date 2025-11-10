
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/10/09 23:51:57
// Design Name: 
// Module Name: piezo_simulation
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


`timescale 1us / 1ns

module piezo_simulation();

reg clk, rst;
reg [7:0] btn;
wire piezo;

piezo_basic PI(clk, rst, btn, piezo);

initial begin
    clk <= 0;
    rst <= 1;
    btn <= 8'b00000000;
    #1e+6; rst <= 0;
    #1e+6; rst <= 1;
    #1e+6; btn <= 8'b00000010; // '饭' 家府
    #1e+6; btn <= 8'b00100000; // '扼' 家府
end

always begin
    #0.5 clk <= ~clk;
end

endmodule

