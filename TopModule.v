`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2024 02:07:13 PM
// Design Name: 
// Module Name: TopModule
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
module TopModule (
    input wire clk,              // Input clock
    input wire reset,            // Reset signal
    output wire [6:0] segments,  // Seven-segment display segments (A-G)
    output wire [3:0] anodes     // Anode signals for digit selection
);
    wire [11:0] count;           // Binary count from UpCounter
    wire [15:0] bcd;             // BCD output from BinaryToBCD
    wire ready;                  // Ready signal from BinaryToBCD

    // Instantiate the UpCounter
    UpCounter counter (
        .clk(clk),
        .reset(reset),
        .count(count)
    );

    // Instantiate the BinaryToBCD converter
    BinaryToBCD converter (
        .clk(clk),
        .reset(reset),
        .start(1'b1), // Always start the conversion in this example
        .binary(count),
        .bcd(bcd),
        .ready(ready)
    );

    // Instantiate the DisplayDriver
    DisplayDriver display (
        .clk(clk),
        .reset(reset),
        .bcd(bcd),
        .segments(segments),
        .anodes(anodes)
    );
endmodule


