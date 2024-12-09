`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2024 02:09:09 PM
// Design Name: 
// Module Name: TopModule_tb
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

module TopModule_tb;
    reg clk;               // Clock signal
    reg reset;             // Reset signal
    wire [6:0] segments;   // Output: Seven-segment display segments (A-G)
    wire [3:0] anodes;     // Output: Anode signals for digit selection

    // Instantiate the TopModule
    TopModule uut (
        .clk(clk),
        .reset(reset),
        .segments(segments),
        .anodes(anodes)
    );

    // Generate a clock signal (100 MHz)
    always #5 clk = ~clk; // Clock period = 10ns

    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;

        // Apply reset
        #20 reset = 0;

        // Let the simulation run for a while
        #2000;

        // Apply reset again during operation
        reset = 1;
        #20 reset = 0;

        // End simulation
        #2000 $stop;
    end
endmodule


