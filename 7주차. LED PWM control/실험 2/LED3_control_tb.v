`timescale 1ns / 1ps

module LED3_control_tb;
    reg clk;
    reg rst;
    reg [7:0] btn;
    wire [3:0] led_R, led_G, led_B;

    LED3_control uut (
        .clk(clk),
        .rst(rst),
        .btn(btn),
        .led_signal_R(led_R),
        .led_signal_G(led_G),
        .led_signal_B(led_B)
    );

    // 내부 관찰용
    wire [7:0] cnt     = uut.c1.cnt;
    wire [23:0] state  = uut.state;

    wire [7:0] ref_R   = state[23:16];
    wire [7:0] ref_G   = state[15:8];
    wire [7:0] ref_B   = state[7:0];

    initial clk = 0;
    always #500 clk = ~clk;

    task wait_pwm_periods(input integer n); //주기 기다리는 모듈 설계
        integer i;
        begin
            for (i=0; i<n*256; i=i+1) @(posedge clk);
        end
    endtask

    initial begin
        clk = 0;
        rst = 1;
        btn = 8'b0;

        repeat (10) @(posedge clk);
        rst = 0;

        btn = 8'b00000001;   // 빨강 선택
        wait_pwm_periods(4);

        btn = 8'b00000010;   // 주황
        wait_pwm_periods(4);

        btn = 8'b00000100;   // 노랑
        wait_pwm_periods(4);

        btn = 8'b10000000;   // 백색
        wait_pwm_periods(4);

        $finish;
    end
endmodule
