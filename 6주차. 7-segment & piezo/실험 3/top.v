module top(
    input clk,           // 100MHz 입력 클럭
    input rst,
    input [7:0] btn,
    output piezo
);

    wire clk_1MHz;

    // 클럭 만드는 모듈
    clk_div_1MHz u_clk_div (
        .clk(clk),
        .rst(rst),
        .clk_1MHz(clk_1MHz)
    );

    // 피에조 모듈
    piezo_basic u_piezo (
        .clk(clk_1MHz),
        .rst(rst),
        .btn(btn),
        .piezo(piezo)
    );

endmodule
