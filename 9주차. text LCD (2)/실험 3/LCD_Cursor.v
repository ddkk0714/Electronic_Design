`timescale 1ns / 1ps

module LCD_cursor(
    input rst,
    input clk,
    input [9:0] number_btn,
    input [1:0] control_btn,
    input [1:0] SW,              // DIP 스위치 입력 
    output LCD_E,
    output reg LCD_RS,
    output reg LCD_RW,
    output reg [7:0] LCD_DATA,
    output reg [7:0] LED_out
);

    reg [9:0] number_btn_reg, number_btn_t;
    reg [1:0] control_btn_reg, control_btn_t;

    reg [1:0] SW_reg;           // 이전 상태 저장
    wire SW_changed = (SW_reg != SW);

    reg [7:0] cnt;
    reg [2:0] state;

    reg [7:0] cur_addr;         // 현재 커서 주소

    parameter 
        DELAY        = 3'b000,
        FUNCTION_SET = 3'b001,
        DISP_ONOFF   = 3'b010,
        ENTRY_MODE   = 3'b011,
        SET_ADDRESS  = 3'b100,
        DELAY_T      = 3'b101,
        WRITE        = 3'b110,
        CURSOR       = 3'b111;

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            number_btn_reg <= 10'b0;
            control_btn_reg <= 2'b0;
            number_btn_t <= 10'b0;
            control_btn_t <= 2'b0;
        end else begin
            number_btn_t <= number_btn & ~number_btn_reg;
            control_btn_t <= control_btn & ~control_btn_reg;
            number_btn_reg <= number_btn;
            control_btn_reg <= control_btn;
        end
    end

    always @(posedge clk or negedge rst) begin
        if (!rst)
            SW_reg <= 2'b00;
        else
            SW_reg <= SW;
    end

    // 상태 전이 FSM
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            state <= DELAY;
            LED_out <= 8'b0000_0000;
        end else begin
            case (state)
                DELAY: begin
                    if (cnt == 70) state <= FUNCTION_SET;
                    LED_out <= 8'b1000_0000;
                end

                FUNCTION_SET: begin
                    if (cnt == 30) state <= DISP_ONOFF;
                    LED_out <= 8'b0100_0000;
                end

                DISP_ONOFF: begin
                    if (cnt == 30) state <= ENTRY_MODE;
                    LED_out <= 8'b0010_0000;
                end

                ENTRY_MODE: begin
                    if (cnt == 30) state <= SET_ADDRESS;
                    LED_out <= 8'b0001_0000;
                end

                SET_ADDRESS: begin
                    if (cnt == 100) state <= DELAY_T;
                    LED_out <= 8'b0000_1000;
                end

                DELAY_T: begin
                    if (|number_btn_t)
                        state <= WRITE;
                    else if (|control_btn_t)
                        state <= CURSOR;
                    else if (SW_changed)
                        state <= SET_ADDRESS; //DIP 전환 시 라인 변경
                    else
                        state <= DELAY_T;
                    LED_out <= 8'b0000_0100;
                end

                WRITE: begin
                    if (cnt == 30) state <= DELAY_T;
                    LED_out <= 8'b0000_0010;
                end

                CURSOR: begin
                    if (cnt == 30) state <= DELAY_T;
                    LED_out <= 8'b0000_0001;
                end
            endcase
        end
    end

    always @(posedge clk or negedge rst) begin
        if (!rst)
            cnt <= 0;
        else begin
            case (state)
                DELAY:        cnt <= (cnt >= 70) ? 0 : cnt + 1;
                FUNCTION_SET: cnt <= (cnt >= 30) ? 0 : cnt + 1;
                DISP_ONOFF:   cnt <= (cnt >= 30) ? 0 : cnt + 1;
                ENTRY_MODE:   cnt <= (cnt >= 30) ? 0 : cnt + 1;
                SET_ADDRESS:  cnt <= (cnt >= 100)? 0 : cnt + 1;
                DELAY_T:      cnt <= 0;
                WRITE:        cnt <= (cnt >= 30) ? 0 : cnt + 1;
                CURSOR:       cnt <= (cnt >= 30) ? 0 : cnt + 1;
            endcase
        end
    end

    // LCD 출력 및 커서 제어
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0000_0001;
            cur_addr <= 8'h00; // 초기 커서 위치 1행
        end else begin
            case (state)
                FUNCTION_SET: {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0011_1000;
                DISP_ONOFF:   {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0000_1111;
                ENTRY_MODE:   {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0000_0110;

                // DIP 스위치 변경 시 라인 전환
                SET_ADDRESS: begin
                    if (SW[1] == 1'b0) begin
                        {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_1000_0000; // 1행
                        cur_addr <= 8'h00;
                    end else begin
                        {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_1100_0000; // 2행
                        cur_addr <= 8'h40;
                    end
                end

                DELAY_T:      {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0000_1111;

                WRITE: begin
                    if (cnt == 20) begin
                        case (number_btn)
                            10'b1000_0000_00: {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0001; // 1
                            10'b0100_0000_00: {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0010; // 2
                            10'b0010_0000_00: {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0011; // 3
                            10'b0001_0000_00: {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0100; // 4
                            10'b0000_1000_00: {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0101; // 5
                            10'b0000_0100_00: {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0110; // 6
                            10'b0000_0010_00: {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0111; // 7
                            10'b0000_0001_00: {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_1000; // 8
                            10'b0000_0000_10: {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_1001; // 9
                            10'b0000_0000_01: {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0000; // 0
                        endcase
                    end else
                        {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0000_1111;
                end

                // 커서 이동 제어
                CURSOR: begin
                    if (cnt == 20) begin
                        case (control_btn)
                            // 왼쪽 이동
                            2'b10: begin
                                {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0001_0000;
                                cur_addr <= (cur_addr == 8'h00) ? 8'h0F :
                                            (cur_addr == 8'h40) ? 8'h55 : cur_addr - 1;
                            end

                            // 오른쪽 이동
                            2'b01: begin
                                if (cur_addr == 8'h0F) begin
                                    {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_1000_0000; // line1 wrap
                                    cur_addr <= 8'h00;
                                end
                                else if (cur_addr == 8'h55) begin
                                    {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_1100_0000; // line2 wrap
                                    cur_addr <= 8'h40;
                                end
                                else begin
                                    {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0001_0100; // Shift Right
                                    cur_addr <= cur_addr + 1;
                                end
                            end
                        endcase
                    end else
                        {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0000_1111;
                end
            endcase
        end
    end
    assign LCD_E = clk;

endmodule
