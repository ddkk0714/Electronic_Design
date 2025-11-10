`timescale 1ns/1ps

module tb_text_LCD_basic;

    reg  rst = 0;
    reg  clk = 0;
    wire LCD_E;
    wire LCD_RS;
    wire LCD_RW;
    wire [7:0] LCD_DATA;
    wire [7:0] LED_out;

    text_LCD_basic2 dut (
        .rst(rst),
        .clk(clk),
        .LCD_E(LCD_E),
        .LCD_RS(LCD_RS),
        .LCD_RW(LCD_RW),
        .LCD_DATA(LCD_DATA),
        .LED_out(LED_out)
    );

    always #5 clk = ~clk;

    initial begin
        rst = 0;
        #20 rst = 1;

        #20000 $stop;
    end

endmodule
