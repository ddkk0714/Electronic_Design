`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/10/09 23:39:04
// Design Name: 
// Module Name: tb_seg_display
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

module seg_array_tb;

    // 입력
    reg clk = 0;
    reg rst = 0;
    reg btn = 0;

    // 출력
    wire [7:0] seg_data;
    wire [7:0] seg_sel;

    seg_array uut (
        .clk(clk),
        .rst(rst),
        .btn(btn),
        .seg_data(seg_data),
        .seg_sel(seg_sel)
    );

    // 클럭 생성 (10 Hz → 100 ms 주)기
    always #50000000 clk = ~clk;

    initial begin
        rst = 0;
        btn = 0;
        #20;
        rst = 1;

        // 버튼을 눌러 카운트 증가
        repeat(5) begin
            #50 btn = 1;
            #10 btn = 0;
        end

        #100 rst = 0;
        #20 rst = 1;

        repeat(3) begin
            #50 btn = 1;
            #10 btn = 0;
        end

        #500;
        $finish;
    end
endmodule
