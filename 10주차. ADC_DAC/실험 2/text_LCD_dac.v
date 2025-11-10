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


`timescale 1ns/1ps
module text_LCD_dac (
    input        rst,
    input        clk,
    input  [7:0] dac_val,
    output reg   LCD_E,
    output reg   LCD_RS,
    output reg   LCD_RW,
    output reg [7:0] LCD_DATA
);

    // 상태 정의
    reg [3:0] state;
    localparam
        INIT        = 4'd0,
        FUNCTION_SET= 4'd1,
        DISP_ONOFF  = 4'd2,
        ENTRY_MODE  = 4'd3,
        LINE1_SET   = 4'd4,
        LINE1_WRITE = 4'd5,
        LINE2_SET   = 4'd6,
        LINE2_WRITE = 4'd7,
        UPDATE_WAIT = 4'd8;

    reg [15:0] cnt;
    reg [3:0] char_idx;

    // bin to BCD for DAC value display
    wire [11:0] dac_bcd;
    bin2bcd_8bit U_BCD (
        .clk(clk),
        .rst(rst),
        .bin(dac_val),
        .bcd(dac_bcd)
    );

    // 상태 전이
    always @(posedge clk or negedge rst) begin
        if(!rst) begin
            state <= INIT;
            cnt <= 0;
            char_idx <= 0;
        end else begin
            if(cnt != 0)
                cnt <= cnt - 1;
            else begin
                case(state)
                    INIT:         begin state <= FUNCTION_SET; cnt <= 15000; end
                    FUNCTION_SET: begin state <= DISP_ONOFF;   cnt <= 2000;  end
                    DISP_ONOFF:   begin state <= ENTRY_MODE;   cnt <= 2000;  end
                    ENTRY_MODE:   begin state <= LINE1_SET;    cnt <= 40;    end
                    LINE1_SET:    begin state <= LINE1_WRITE;  cnt <= 40;    char_idx <= 0; end
                    LINE1_WRITE:  begin
                                      if(char_idx >= 9) state <= LINE2_SET;
                                      else char_idx <= char_idx + 1;
                                      cnt <= 40;
                                  end
                    LINE2_SET:    begin state <= LINE2_WRITE; char_idx <= 0; cnt <= 40; end
                    LINE2_WRITE:  begin
                                      if(char_idx >= 2) state <= UPDATE_WAIT;
                                      else char_idx <= char_idx + 1;
                                      cnt <= 40;
                                  end
                    UPDATE_WAIT:  begin state <= LINE2_SET; cnt <= 100000; end
                    default:      state <= INIT;
                endcase
            end
        end
    end

    // LCD 제어
    always @(posedge clk or negedge rst) begin
        if(!rst) begin
            {LCD_RS, LCD_RW, LCD_DATA} <= {1'b0,1'b0,8'h00};
            LCD_E <= 0;
        end else begin
            LCD_RW <= 0;                 // 항상 쓰기
            LCD_E  <= (cnt==1);

            case(state)
                FUNCTION_SET: {LCD_RS,LCD_DATA} <= {1'b0, 8'h38};
                DISP_ONOFF:   {LCD_RS,LCD_DATA} <= {1'b0, 8'h0C};
                ENTRY_MODE:   {LCD_RS,LCD_DATA} <= {1'b0, 8'h06};
                LINE1_SET:    {LCD_RS,LCD_DATA} <= {1'b0, 8'h80};
                LINE1_WRITE: begin
                    LCD_RS <= 1;
                    case(char_idx)
                        0: LCD_DATA <= "D";
                        1: LCD_DATA <= "A";
                        2: LCD_DATA <= "C";
                        3: LCD_DATA <= " ";
                        4: LCD_DATA <= "V";
                        5: LCD_DATA <= "a";
                        6: LCD_DATA <= "l";
                        7: LCD_DATA <= "u";
                        8: LCD_DATA <= "e";
                        default: LCD_DATA <= " ";
                    endcase
                end
                LINE2_SET: {LCD_RS,LCD_DATA} <= {1'b0, 8'hC0};
                LINE2_WRITE: begin
                    LCD_RS <= 1;
                    case(char_idx)
                        0: LCD_DATA <= 8'h30 + dac_bcd[11:8];
                        1: LCD_DATA <= 8'h30 + dac_bcd[7:4];
                        2: LCD_DATA <= 8'h30 + dac_bcd[3:0];
                        default: LCD_DATA <= " ";
                    endcase
                end
                default: begin LCD_RS<=0; LCD_DATA<=8'h00; end
            endcase
        end
    end

endmodule



