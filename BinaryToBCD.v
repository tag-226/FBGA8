`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2024 02:00:59 PM
// Design Name: 
// Module Name: BinaryToBCD
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


module BinaryToBCD (
    input wire clk,                 // Clock signal
    input wire reset,               // Reset signal
    input wire start,               // Start conversion signal
    input wire [11:0] binary,       // 12-bit binary input
    output reg [15:0] bcd,          // 16-bit BCD output
    output reg ready                // Ready signal (conversion complete)
);

    // State encoding using parameters
    parameter IDLE = 3'b000;
    parameter LOAD = 3'b001;
    parameter ADD3 = 3'b010;
    parameter SHIFT = 3'b011;
    parameter DONE = 3'b100;

    reg [2:0] current_state, next_state; // Current and next state
    reg [27:0] shift_reg;                // Shift register for double-dabble
    reg [3:0] bit_counter;               // Counter for 12 shift operations
    integer i;

    // State transition logic (sequential)
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Next-state and output logic (combinational)
    always @* begin
        // Default assignments
        next_state = current_state;
        ready = 0;
        case (current_state)
            IDLE: begin
                if (start)
                    next_state = LOAD;
            end
            LOAD: begin
                next_state = ADD3;
            end
            ADD3: begin
                next_state = SHIFT;
            end
            SHIFT: begin
                if (bit_counter == 0)
                    next_state = DONE;
                else
                    next_state = ADD3;
            end
            DONE: begin
                ready = 1; // Signal that conversion is complete
                if (!start)
                    next_state = IDLE;
            end
        endcase
    end

    // Sequential logic for the conversion process
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg <= 0;
            bit_counter <= 0;
            bcd <= 0;
        end else begin
            case (current_state)
                IDLE: begin
                    // Initialize registers in IDLE
                    shift_reg <= 0;
                    bit_counter <= 0;
                    bcd <= 0;
                end
                LOAD: begin
                    // Load binary input into the shift register
                    shift_reg[11:0] <= binary;
                    shift_reg[27:12] <= 16'b0; // Initialize upper BCD digits
                    bit_counter <= 12;         // Set bit counter
                end
                ADD3: begin
                    // Perform add-3 adjustment where needed
                    for (i = 27; i >= 16; i = i - 4) begin
                        if (shift_reg[i -: 4] >= 5) begin
                            shift_reg[i -: 4] <= shift_reg[i -: 4] + 3;
                        end
                    end
                end
                SHIFT: begin
                    // Perform left shift
                    shift_reg <= shift_reg << 1;
                    bit_counter <= bit_counter - 1;
                end
                DONE: begin
                    // Output the BCD result
                    bcd <= shift_reg[27:12];
                end
            endcase
        end
    end
endmodule