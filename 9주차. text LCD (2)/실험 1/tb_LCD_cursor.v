`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/02 23:00:53
// Design Name: 
// Module Name: tb_LCD_cursor
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


`timescale 1ns/1ps

module tb_LCD_cursor;
    reg         clk;
    reg         rst;
    reg  [9:0]  number_btn;
    reg  [1:0]  control_btn;

    wire        LCD_E;
    wire        LCD_RS;
    wire        LCD_RW;
    wire [7:0]  LCD_DATA;
    wire [7:0]  LED_out;

    LCD_cursor dut (
        .rst         (rst),
        .clk         (clk),
        .number_btn  (number_btn),
        .control_btn (control_btn),
        .LCD_E       (LCD_E),
        .LCD_RS      (LCD_RS),
        .LCD_RW      (LCD_RW),
        .LCD_DATA    (LCD_DATA),
        .LED_out     (LED_out)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst         = 1'b0;
        number_btn  = 10'b0;
        control_btn = 2'b0;

        // 리셋 해제
        #20;
        rst = 1'b1;

        wait (dut.state == dut.DELAY_T);
        #20;

        number_btn[9] = 1'b1;
        #10;
        number_btn[9] = 1'b0;
        #200;

        wait (dut.state == dut.DELAY_T);

        #10;
        number_btn[4] = 1'b1;
        #10;
        number_btn[4] = 1'b0;
        #200;

        wait (dut.state == dut.DELAY_T);

        #10;
        control_btn = 2'b10;   // left
        #10;
        control_btn = 2'b00;
        #200;

        wait (dut.state == dut.DELAY_T);

        #10;
        control_btn = 2'b01;   // right
        #10;
        control_btn = 2'b00;
        #300;

        $finish;
    end

endmodule

