`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/09 09:41:04
// Design Name: 
// Module Name: oneshot_universal
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


module oneshot_universal #(
    parameter WIDTH = 1
)(
    input                  clk,
    input                  rst,             
    input  [WIDTH-1:0]     btn,              //벡터 포트로 수정
    output reg [WIDTH-1:0] btn_trig
);
    // 2-FF 동기화
    reg [WIDTH-1:0] sync0, sync1;
    // 직전 상태 저장(에지 검출 기준)
    reg [WIDTH-1:0] prev;

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            sync0    <= {WIDTH{1'b0}};
            sync1    <= {WIDTH{1'b0}};
            prev     <= {WIDTH{1'b0}};
            btn_trig <= {WIDTH{1'b0}};
        end else begin
            // 비동기 입력 동기화
            sync0 <= btn;
            sync1 <= sync0;

            // 상승엣지 검출 (1클럭 펄스)
            btn_trig <=  sync1 & ~prev;

            // 다음 사이클 비교 기준
            prev <= sync1;
        end
    end
endmodule

