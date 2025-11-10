`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/10/13 10:13:14
// Design Name: 
// Module Name: bcd_4_counter
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


module bcd_4_counter(input clk, rst, btn, output reg[7:0] seg_sel,output reg [7:0] seg);

     

    wire y;

    wire [3:0] q;

    wire btn_wire;

    reg [3:0] i;

    reg [32:0] clk_count;

    parameter COUNT_CLK = 32'd1000000;

    manager manager_inst(.clk(clk), .rst(rst), .btn(btn), .btn_trig(btn_wire));

    

    always@(negedge rst or posedge clk) begin

        if(!rst) i <= 4'b0000;

        else if(btn_wire) begin

            if(i == 4'b1111) i <=0000;

            else i <= i + 1;

        end

    end   

    

    always @(posedge clk or negedge rst) begin

        if(!rst) begin

            seg_sel <= 8'b11111110;

            clk_count<=0;

        end

        else begin

            if(clk_count > COUNT_CLK) begin

                seg_sel <= {seg_sel[6:0], seg_sel[7]};

                clk_count <= 0;

            end

        else clk_count <= clk_count +1;      

    end

    end

    

        assign y = i[3] & (i[2] | i[1]);

        assign q = {i[3] & ~i[2] & ~i[1], 

        (~i[3] & i[2]) | (i[3] & i[2] & i[1]),

        (~i[3] & i[1]) | (i[3] & i[2] & ~i[1]),  

         i[0]}; 



    

    always @(*) begin

        if (seg_sel == 8'b11111110)begin

            case(q)

                0 : seg = 8'b11111100;

                1 : seg = 8'b01100000;

                2 : seg = 8'b11011010;

                3 : seg = 8'b11110010;

                4 : seg = 8'b01100110;

                5 : seg = 8'b10110110;

                6 : seg = 8'b10111110;

                7 : seg = 8'b11100100;

                8 : seg = 8'b11111110;

                9 : seg = 8'b11110110;

                default seg = 8'b00000000;

            endcase

        end

        else if (seg_sel == 8'b11111101) begin

            case(y)

                0 : seg = 8'b11111100;

                1 : seg = 8'b01100000;

                default: seg = 0'b00000000;

            endcase

        end

        else begin seg = 0'b00000000; end

        end



endmodule
