`timescale 1ns / 1ps

module tb_SM1;

    reg clk, rst, x;
    wire [1:0] state;
    wire y;

    SM1 uut (
        .clk(clk),
        .rst(rst),
        .x(x),
        .y(y),
        .state(state)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;  
    end

    initial begin
        rst = 0; x = 0;
        #20;
        rst = 1;
        #20;

        x = 1;
        #20;

        x = 0;
        #20;

        x = 1;
        #10;

        x = 0;
        #20;

        x = 1;
        #50;

        x = 0;
        #20;

        $stop;
    end
    
endmodule
