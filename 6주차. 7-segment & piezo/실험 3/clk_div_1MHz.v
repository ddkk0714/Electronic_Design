module clk_div_1MHz(
    input clk,           // 입력: 100MHz 클럭
    input rst,
    output reg clk_1MHz  // 출력: 1MHz 클럭
);

    reg [7:0] cnt;  // 7비트면 0~127 가능 (100까지 충분)

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            cnt <= 0;
            clk_1MHz <= 0;
        end else if (cnt == 99) begin //1MHz일때 49, 5000KHz일때 99
            cnt <= 0;
            clk_1MHz <= ~clk_1MHz;  // 50 + 50 = 100 → 분주비 100
        end else begin
            cnt <= cnt + 1;
        end
    end
endmodule
