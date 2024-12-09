`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2024 02:02:29 PM
// Design Name: 
// Module Name: BinaryToBCD_tb
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
module BinaryToBCD_tb;
    reg clk;
    reg reset;
    reg start;
    reg [11:0] binary;
    wire [15:0] bcd;
    wire ready;

    // Instantiate the BinaryToBCD module
    BinaryToBCD uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .binary(binary),
        .bcd(bcd),
        .ready(ready)
    );

    // Clock generation
    always #5 clk = ~clk; // 10ns clock period

    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        start = 0;
        binary = 0;

        // Apply reset
        #10;
        reset = 0;

        // Test Case 1: Convert 12-bit binary number to BCD
        binary = 12'b000100110011; // Binary for decimal 307
        start = 1;
        #10;
        start = 0;

        // Wait for conversion to complete
        wait (ready);
        $display("Test Case 1: Binary: %d, BCD: %h", binary, bcd);

        // Test Case 2: Convert another 12-bit binary number
        #20;
        binary = 12'b100000000000; // Binary for decimal 2048
        start = 1;
        #10;
        start = 0;

        // Wait for conversion to complete
        wait (ready);
        $display("Test Case 2: Binary: %d, BCD: %h", binary, bcd);

        // Test Case 3: Edge case for 0
        #20;
        binary = 12'b000000000000; // Binary for decimal 0
        start = 1;
        #10;
        start = 0;

        // Wait for conversion to complete
        wait (ready);
        $display("Test Case 3: Binary: %d, BCD: %h", binary, bcd);

        // Test Case 4: Edge case for maximum input
        #20;
        binary = 12'b111111111111; // Binary for decimal 4095
        start = 1;
        #10;
        start = 0;

        // Wait for conversion to complete
        wait (ready);
        $display("Test Case 4: Binary: %d, BCD: %h", binary, bcd);

        // Additional Test Case 5: Random middle-range binary input
        #20;
        binary = 12'b010101010101; // Binary for decimal 1365
        start = 1;
        #10;
        start = 0;

        // Wait for conversion to complete
        wait (ready);
        $display("Test Case 5: Binary: %d, BCD: %h", binary, bcd);

        // Additional Test Case 6: Check behavior with quick successive starts
        #20;
        binary = 12'b001100110011; // Binary for decimal 819
        start = 1;
        #5;
        start = 0;

        // Wait for conversion to complete
        wait (ready);
        $display("Test Case 6: Binary: %d, BCD: %h", binary, bcd);

        $stop;
    end
endmodule
