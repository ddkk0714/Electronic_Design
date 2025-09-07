`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/09/07 16:27:16
// Design Name: 
// Module Name: Half_Adder_case
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


module Half_Adder_case(A, B, S, C);
    input wire A, B;
    output reg S, C;
    
    always @(A, B, S, C) 
        begin
            case ({A, B})
                2'b00 : begin S = 0; C = 0; end
                2'b01 : begin S = 1; C = 0; end
                2'b10 : begin S = 1; C = 0; end
                2'b11 : begin S = 0; C = 1; end
                default: begin S = 0; C = 0; end
            endcase
        end
endmodule
