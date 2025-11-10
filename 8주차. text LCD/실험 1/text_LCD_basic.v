    `timescale 1ns/1ps
    
    module text_LCD_basic (
        input        rst,
        input        clk,
        output       LCD_E,
        output reg   LCD_RS,
        output reg   LCD_RW,
        output reg [7:0] LCD_DATA,
        output reg [7:0] LED_out
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
    
        always @(posedge clk or negedge rst) begin
            if (!rst) begin
                state   <= DELAY;
                LED_out <= 8'b0;
            end else begin
                case (state)
                    DELAY:        begin LED_out <= 8'b1000_0000; if (cnt >= 70) state <= FUNCTION_SET; end
                    FUNCTION_SET: begin LED_out <= 8'b0100_0000; if (cnt >= 30) state <= DISP_ONOFF;   end
                    DISP_ONOFF:   begin LED_out <= 8'b0010_0000; if (cnt >= 30) state <= ENTRY_MODE;   end
                    ENTRY_MODE:   begin LED_out <= 8'b0001_0000; if (cnt >= 30) state <= LINE1;        end
                    LINE1:        begin LED_out <= 8'b0000_1000; if (cnt >= 20) state <= LINE2;        end
                    LINE2:        begin LED_out <= 8'b0000_0100; if (cnt >= 20) state <= DELAY_T;      end
                    DELAY_T:      begin LED_out <= 8'b0000_0010; if (cnt >= 5)  state <= DELAY_T;      end
                    CLEAR_DISP:   begin LED_out <= 8'b0000_0001; if (cnt >= 5)  state <= LINE1;        end
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
    
                    LINE1: begin
                        case (cnt)
                            0:  {LCD_RS, LCD_RW, LCD_DATA} <= {1'b0, 1'b0, 8'h80};
                            1:  {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h48}; // H
                            2:  {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h45}; // E
                            3:  {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h4C}; // L
                            4:  {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h4C}; // L
                            5:  {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h4F}; // O
                            6:  {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h20}; //  
                            7:  {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h57}; // W
                            8:  {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h4F}; // O
                            9:  {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h52}; // R
                            10: {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h4C}; // L
                            11: {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h44}; // D
                            12: {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h34}; // !
                            default:
                                {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h20};
                        endcase
                    end
    
                    LINE2: begin
                        case (cnt)
                            0:  {LCD_RS, LCD_RW, LCD_DATA} <= {1'b0, 1'b0, 8'hC0}; // DDRAM=0x40 <<
                            1:  {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h32}; // 2
                            2:  {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h30}; // 0
                            3:  {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h32}; // 2
                            4:  {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h32}; // 2
                            5:  {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h34}; // 4
                            6:  {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h34}; // 4
                            7:  {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h30}; // 0
                            8:  {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h31}; // 1
                            9:  {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h32}; // 2
                            10: {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h36}; // 6
                            11: {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h20}; //  
                            12: {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h4A}; // J
                            13: {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h4D}; // M
                            14: {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h48}; // H
                            default:
                                {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h20};
                        endcase
                    end
    
                    DELAY_T:    {LCD_RS, LCD_RW, LCD_DATA} <= {1'b0, 1'b0, 8'h18}; // Return Home
                    CLEAR_DISP: {LCD_RS, LCD_RW, LCD_DATA} <= {1'b0, 1'b0, 8'h01}; // Clear
    
                    default:    {LCD_RS, LCD_RW, LCD_DATA} <= {1'b1, 1'b0, 8'h00};
                endcase
            end
        end

        assign LCD_E = clk;
    
    endmodule
