`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/09/07 15:31:25
// Design Name: 
// Module Name: Logic_Gate
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


module Logic_Gate(DIP1, DIP2, LED1, LED2, LED3, LED4, LED5);
    input DIP1, DIP2;
    output LED1, LED2, LED3, LED4, LED5;
    
    assign LED1 = DIP1 &  DIP2; //AND
    assign LED2 = DIP1 |  DIP2; //OR
    assign LED3 = DIP1 ^  DIP2; //XOR
    assign LED4 = ~(DIP1 | DIP2); //NOR
    assign LED5 = ~(DIP1 & DIP2); //NAND
    
endmodule
