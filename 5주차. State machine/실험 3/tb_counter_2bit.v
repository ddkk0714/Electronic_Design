`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/09/28 21:47:37
// Design Name: 
// Module Name: tb_counter_2bit
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



module tb_counter_2bit;

    reg clk;
    reg rst;
    reg x;
    wire [1:0] state;

    counter_2bit uut (
        .clk(clk),
        .rst(rst),
        .x(x),
        .state(state)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        rst = 0; x = 0;
        #12; //타이밍 약간 어긋나게
        rst = 1;

        #10 x = 1; #10 x = 0;
        #20 x = 1; #10 x = 0;
        #20 x = 1; #10 x = 0;
        #20 x = 1; #10 x = 0;

        #30 rst = 0; 
        #10 rst = 1;

        // 다시 x 토글
        #20 x = 1; #10 x = 0;
        #20 x = 1; #10 x = 0;

        #50;
        $finish;
    end

endmodule

