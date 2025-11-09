`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/09 14:32:41
// Design Name: 
// Module Name: text_LCD_dac
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


module text_LCD_dac (
    input        rst,
    input        clk,
    input  [7:0] dac_val,      // 추가 -> DAC 디지털 값

    output       LCD_E,
    output reg   LCD_RS,
    output reg   LCD_RW,
    output reg [7:0] LCD_DATA
);


    reg [2:0] state;
    localparam
        DELAY        = 3'b000,
        FUNCTION_SET = 3'b001,
        ENTRY_MODE   = 3'b010,
        DISP_ONOFF   = 3'b011,
        LINE1        = 3'b100,
        LINE2        = 3'b101,
        DELAY_T      = 3'b110,
        CLEAR_DISP   = 3'b111;

    integer cnt;


    reg [3:0] hi_nib, lo_nib;
    reg [7:0] hex_hi, hex_lo;


    always @(*) begin
        hi_nib = dac_val[7:4];
        lo_nib = dac_val[3:0];

        if (hi_nib < 10)
            hex_hi = 8'h30 + hi_nib;
        else
            hex_hi = 8'h41 + (hi_nib - 10);
        if (lo_nib < 10)
            hex_lo = 8'h30 + lo_nib;
        else
            hex_lo = 8'h41 + (lo_nib - 10);
    end

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            state <= DELAY;
        end else begin
            case (state)
                DELAY:        if (cnt >= 70) state <= FUNCTION_SET;
                FUNCTION_SET: if (cnt >= 30) state <= DISP_ONOFF;
                DISP_ONOFF:   if (cnt >= 30) state <= ENTRY_MODE;
                ENTRY_MODE:   if (cnt >= 30) state <= LINE1;
                LINE1:        if (cnt >= 20) state <= LINE2;
                LINE2:        if (cnt >= 20) state <= DELAY_T;
                DELAY_T:      if (cnt >= 5)  state <= CLEAR_DISP;
                CLEAR_DISP:   if (cnt >= 5)  state <= LINE1;
                default:      state <= DELAY;
            endcase
        end
    end

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            cnt <= 0;
        end else begin
            case (state)
                DELAY:        cnt <= (cnt >= 70) ? 0 : cnt + 1;
                FUNCTION_SET: cnt <= (cnt >= 30) ? 0 : cnt + 1;
                DISP_ONOFF:   cnt <= (cnt >= 30) ? 0 : cnt + 1;
                ENTRY_MODE:   cnt <= (cnt >= 30) ? 0 : cnt + 1;
                LINE1:        cnt <= (cnt >= 20) ? 0 : cnt + 1;
                LINE2:        cnt <= (cnt >= 20) ? 0 : cnt + 1;
                DELAY_T:      cnt <= (cnt >= 5)  ? 0 : cnt + 1;
                CLEAR_DISP:   cnt <= (cnt >= 5)  ? 0 : cnt + 1;
                default:      cnt <= 0;
            endcase
        end
    end

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h00};
        end else begin
            case (state)
                FUNCTION_SET: {LCD_RS, LCD_RW, LCD_DATA} <= {1'b0, 1'b0, 8'h38};
                DISP_ONOFF:   {LCD_RS, LCD_RW, LCD_DATA} <= {1'b0, 1'b0, 8'h0C};
                ENTRY_MODE:   {LCD_RS, LCD_RW, LCD_DATA} <= {1'b0, 1'b0, 8'h06};

                LINE1: begin // 1행에 값 출력하기
                    case (cnt)
                        0:  {LCD_RS, LCD_RW, LCD_DATA} <= {1'b0, 1'b0, 8'h80};  // DDRAM=0x80
                        1:  {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h44};
                        2:  {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h41};
                        3:  {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h43};
                        4:  {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h3D};
                        5:  {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h30};
                        6:  {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h78};
                        7:  {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, hex_hi};
                        8:  {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, hex_lo};
                        9:  {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h20};
                        default:
                            {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h20};
                    endcase
                end

                LINE2: begin
                    case (cnt)
                        0:  {LCD_RS, LCD_RW, LCD_DATA} <= {1'b0, 1'b0, 8'hC0}; // DDRAM=0x40
                        1:  {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h20};
                        2:  {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h20};
                        3:  {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h20};
                        4:  {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h20};
                        5:  {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h20};
                        6:  {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h20};
                        7:  {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h20};
                        8:  {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h20};
                        default:
                            {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h20};
                    endcase
                end

                DELAY_T:    {LCD_RS, LCD_RW, LCD_DATA} <= {1'b0, 1'b0, 8'h02};
                CLEAR_DISP: {LCD_RS, LCD_RW, LCD_DATA} <= {1'b0, 1'b0, 8'h01};

                default:    {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h00};
            endcase
        end
    end
    assign LCD_E = clk;

endmodule
