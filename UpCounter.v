`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2024 01:55:17 PM
// Design Name: 
// Module Name: UpCounter
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


module UpCounter #(parameter MAX_COUNT = 4095)(clk, reset, count);
    input wire clk;
    input wire reset;
    output reg [11:0] count;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 12'd0;
        end else if (count < MAX_COUNT) begin
            count <= count + 1;
        end else begin
            count <= 12'd0;
        end
    end
endmodule
