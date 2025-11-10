`timescale 1ns / 1ps

module piezo_basic(
    input clk,         // 1MHz 클럭 입력
    input rst,
    input [7:0] btn,
    output reg piezo
);


    parameter C2 = 12'd3824;
    parameter D2 = 12'd3406;
    parameter E2 = 12'd3034;
    parameter F2 = 12'd2863;
    parameter G2 = 12'd2551;
    parameter A2 = 12'd2273;
    parameter B2 = 12'd2025;
    parameter C3 = 12'd1911;

    reg [11:0] cnt;
    reg [11:0] cnt_limit;

    always @(*) begin
        if (!rst)
            cnt_limit = 0;
        else begin
            case(btn)
                8'b00000001 : cnt_limit = C2;
                8'b00000010 : cnt_limit = D2;
                8'b00000100 : cnt_limit = E2;
                8'b00001000 : cnt_limit = F2;
                8'b00010000 : cnt_limit = G2;
                8'b00100000 : cnt_limit = A2;
                8'b01000000 : cnt_limit = B2;
                8'b10000000 : cnt_limit = C3;
                default     : cnt_limit = 0;
            endcase
        end
    end

    // 피에조 출력
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            cnt <= 0;
            piezo <= 0;
        end else if (cnt_limit == 0) begin
            cnt <= 0;
            piezo <= 0;
        end else if (cnt >= cnt_limit / 2) begin
            cnt <= 0;
            piezo <= ~piezo;
        end else begin
            cnt <= cnt + 1;
        end
    end

endmodule
