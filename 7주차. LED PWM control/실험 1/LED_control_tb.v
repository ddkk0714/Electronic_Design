`timescale 1ns/1ps

module LED_control_tb;

    reg clk;
    reg rst;
    reg [7:0] bin;

    wire [7:0] seg_data;
    wire [7:0] seg_sel;
    wire led_signal;

    LED_control uut (
        .clk(clk),
        .rst(rst),
        .bin(bin),
        .seg_data(seg_data),
        .seg_sel(seg_sel),
        .led_signal(led_signal)
    );

    initial begin
        clk = 0;
        forever #500 clk = ~clk;
    end

    initial begin
        rst = 1; bin = 8'd0;
        #2000; 
        rst = 0;

        #100000; bin = 8'd64;   // 25%
        #500000;
        #100000; bin = 8'd128;  // 50%
        #500000;
        #100000; bin = 8'd192;
        #500000;
        #100000; bin = 8'd255;
        #500000;

        $finish;
    end

endmodule
