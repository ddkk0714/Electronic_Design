`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/09/22 10:29:47
// Design Name: 
// Module Name: TFF_ONESHOT_DEB
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


module TFF_ONESHOT_DEB #(
    parameter DB_CNT_MAX = 500_000   // 디바운스 카운터
)(
    input  wire CLK,
    input  wire RST,
    input  wire T,
    output reg  Q
);

    reg [$clog2(DB_CNT_MAX):0] db_cnt;
    reg T_DB;

    always @(posedge CLK or negedge RST) begin
        if(!RST) begin
            db_cnt <= 0;
            T_DB   <= 0;
        end else if (T != T_DB) begin
            db_cnt <= DB_CNT_MAX;
        end else if (db_cnt > 0) begin
            // 카운터 감소
            db_cnt <= db_cnt - 1;
            if (db_cnt == 1)
                T_DB <= T;
        end
    end

    //원샷
    reg T_REG; 
    wire T_TRIG;

    always @(posedge CLK or negedge RST) begin
        if(!RST)
            T_REG <= 1'b0;
        else
            T_REG <= T_DB;
    end

    assign T_TRIG = T_DB & ~T_REG;=

    always @(posedge CLK or negedge RST) begin
        if(!RST)
            Q <= 1'b0;
        else if(T_TRIG)
            Q <= ~Q;
    end

endmodule

