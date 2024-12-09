`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2024 02:03:30 PM
// Design Name: 
// Module Name: DisplayDriver
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


module DisplayDriver (
    input wire clk,               // Clock signal for multiplexing
    input wire reset,             // Reset signal
    input wire [15:0] bcd,        // 16-bit BCD input (4 digits)
    output reg [6:0] segments,    // Seven-segment display segments (A-G)
    output reg [3:0] anodes       // Anode signals for digit selection
);

    reg [1:0] digit_select;       // Counter for selecting the active digit
    reg [3:0] current_digit;      // Current 4-bit BCD digit to display
    reg [16:0] clk_divider;       // Clock divider for multiplexing

    // Clock divider to slow down multiplexing (adjust value for desired refresh rate)
    always @(posedge clk or posedge reset) begin
        if (reset)
            clk_divider <= 0;
        else
            clk_divider <= clk_divider + 1;
    end

    // Digit selector (cycling through 4 digits)
    always @(posedge clk_divider[16] or posedge reset) begin
        if (reset)
            digit_select <= 0;
        else
            digit_select <= digit_select + 1;
    end

    // Assign current digit and anode based on digit_select
    always @* begin
        case (digit_select)
            2'b00: begin
                anodes = 4'b1110;   // Activate digit 1
                current_digit = bcd[3:0];  // Least significant digit
            end
            2'b01: begin
                anodes = 4'b1101;   // Activate digit 2
                current_digit = bcd[7:4];
            end
            2'b10: begin
                anodes = 4'b1011;   // Activate digit 3
                current_digit = bcd[11:8];
            end
            2'b11: begin
                anodes = 4'b0111;   // Activate digit 4
                current_digit = bcd[15:12]; // Most significant digit
            end
            default: begin
                anodes = 4'b1111;   // Turn off all digits (should not occur)
                current_digit = 4'b0000;
            end
        endcase
    end

    // Segment decoder: Maps the current BCD digit to seven-segment display pattern
    always @* begin
        case (current_digit)
            4'd0: segments = 7'b1000000; // "0"
            4'd1: segments = 7'b1111001; // "1"
            4'd2: segments = 7'b0100100; // "2"
            4'd3: segments = 7'b0110000; // "3"
            4'd4: segments = 7'b0011001; // "4"
            4'd5: segments = 7'b0010010; // "5"
            4'd6: segments = 7'b0000010; // "6"
            4'd7: segments = 7'b1111000; // "7"
            4'd8: segments = 7'b0000000; // "8"
            4'd9: segments = 7'b0010000; // "9"
            default: segments = 7'b1111111; // Blank
        endcase
    end

endmodule


