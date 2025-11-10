`timescale 1us/1ns

module tb_seg_counter;
reg clk;
reg rst;
reg btn;
wire [7:0] seg;

seg_counter UUT (
    .clk(clk),
    .rst(rst),
    .btn(btn),
    .seg(seg)
);

always begin
    #1 clk = ~clk; // 500kHz 클록
end

initial begin
    clk = 0;
    rst = 1;
    btn = 0;

    // 리셋
    #10 rst = 0;
    #10 rst = 1;

    // 버튼 누름 테스트
    #20 btn = 1;
    #10 btn = 0;
    
    #20 btn = 1;
    #10 btn = 0;

    #20 btn = 1;
    #10 btn = 0;
    
    #20 btn = 1;
    #10 btn = 0;
    
    #20 btn = 1;
    #10 btn = 0;
    
    #20 btn = 1;
    #10 btn = 0;
    
    #20 btn = 1;
    #10 btn = 0;
    
    #20 btn = 1;
    #10 btn = 0;
    
    #20 btn = 1;
    #10 btn = 0;
    
    #20 btn = 1;
    #10 btn = 0;
    
    #20 btn = 1;
    #10 btn = 0;
    #100 $finish;
end

endmodule
