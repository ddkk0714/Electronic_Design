`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/09/28 21:51:11
// Design Name: 
// Module Name: tb_updown_counter_3bit
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


module tb_updown_counter_3bit;

    reg clk;
    reg rst_n;
    reg updown;
    wire [2:0] q;

    updown_counter_3bit uut (
        .clk(clk),
        .rst_n(rst_n),
        .updown(updown),
        .q(q)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        rst_n = 0;
        updown = 1;
        #20;
        rst_n = 1;

        // 업카운트 10클럭
        repeat (10) @(posedge clk);
        
        updown = 0;

        repeat (10) @(posedge clk);

        $finish;
    end

endmodule


