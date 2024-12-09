`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2024 01:58:38 PM
// Design Name: 
// Module Name: UpCounter_tb
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
module tb_UpCounter;

    // Inputs
    reg clk;
    reg reset;

    // Outputs
    wire [11:0] count;

    // Instantiate the Unit Under Test (UUT)
    UpCounter #(.MAX_COUNT(12'd15)) uut ( // Set MAX_COUNT to 15 for testing purposes
        .clk(clk),
        .reset(reset),
        .count(count)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Test sequence
    initial begin
        // Initialize inputs
        reset = 1;

        // Apply reset
        #20;
        reset = 0;

        // Wait for several clock cycles to observe counting
        #200;

        // Apply reset again during counting
        reset = 1;
        #10;
        reset = 0;

        // Wait and observe counter behavior
        #100;

        // End simulation
        $stop;
    end

    // Monitor output
    initial begin
        $monitor("Time: %0t | Reset: %b | Count: %d", $time, reset, count);
    end

endmodule
