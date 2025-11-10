`timescale 1ns / 1ps

module DAC_tb;

    reg         clk;
    reg         rst;
    reg  [5:0]  btn;
    reg         add_sel;

    wire        dac_csn;
    wire        dac_ldacn;
    wire        dac_wrn;
    wire        dac_a_b;
    wire [7:0]  dac_d;
    wire [7:0]  led_out;

    DAC uut (
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

    always #5 clk = ~clk;

    initial begin
        // 초기값
        clk     = 0;
        rst     = 0;
        btn     = 6'b000000;
        add_sel = 1'b0;       // 채널 A 선택

        // 리셋 해제
        #20;
        rst = 1;

        #3500;

        // 1번 버튼: 1 감소
        btn = 6'b100000;
        #20;
        btn = 6'b000000;
        #5000;

        // 3번 버튼: 1 증가
        btn = 6'b010000;
        #20;
        btn = 6'b000000;
        #5000;

        // 4번 버튼: 2 감소
        btn = 6'b001000;
        #20;
        btn = 6'b000000;
        #5000;

        // 6번 버튼: 2 증가
        btn = 6'b000100;
        #20;
        btn = 6'b000000;
        #5000;

        // 7번 버튼: 8 감소
        btn = 6'b000010;
        #20;
        btn = 6'b000000;
        #5000;

        // 9번 버튼: 8 증가
        btn = 6'b000001;
        #20;
        btn = 6'b000000;
        #5000;

        $finish;
    end
endmodule
