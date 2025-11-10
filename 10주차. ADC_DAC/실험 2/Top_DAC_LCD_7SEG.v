`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/09 09:37:11
// Design Name: 
// Module Name: Top_DAC_LCD_7SEG
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


module Top_DAC_LCD_7SEG(
    input        clk,
    input        rst,
    input  [5:0] btn,
    input        add_sel,

    // DAC
    output       dac_csn,
    output       dac_ldacn,
    output       dac_wrn,
    output       dac_a_b,
    output [7:0] dac_d,
    output [7:0] led_out,

    // 7-seg
    output [7:0] seg_sel,
    output [7:0] seg,

    // Text LCD
    output       LCD_E,
    output       LCD_RS,
    output       LCD_RW,
    output [7:0] LCD_DATA
);

    DAC u_dac (
        .clk      (clk),
        .rst      (rst),
        .btn      (btn),
        .add_sel  (add_sel),
        .dac_csn  (dac_csn),
        .dac_ldacn(dac_ldacn),
        .dac_wrn  (dac_wrn),
        .dac_a_b  (dac_a_b),
        .dac_d    (dac_d),
        .led_out  (led_out)
    );

    text_LCD_dac u_lcd (
        .rst      (rst),
        .clk      (clk),
        .dac_val  (dac_d),
        .LCD_E    (LCD_E),
        .LCD_RS   (LCD_RS),
        .LCD_RW   (LCD_RW),
        .LCD_DATA (LCD_DATA)
        
    );

    dac_7seg u_seg (
        .clk     (clk),
        .rst     (rst),
        .dac_val (dac_d),
        .seg_sel (seg_sel),
        .seg_data(seg)
    );

endmodule
