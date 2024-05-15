`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2024 07:32:23 PM
// Design Name: 
// Module Name: ir_sensor
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


`timescale 1ns / 1ps

module ir_sensor (
    input wire clk, reset,
    input wire ir_in, // Connect this to the output of the IR sensor
    input wire v17_pin, // Connect this to the V17 pin of the FPGA BASYS 3 board
    output wire fsm_input_user, fsm_reset
);
    // Declare variables
    reg [7:0] key;
    reg key_release;

    // Sequential logic
    always @(posedge clk)
    begin
        if (reset)
        begin 
            key <= 8'h00; // Clear the key on reset
            key_release <= 1'b0;
        end
        else if (~ir_in) // If the IR sensor is triggered (active low)
        begin 
            key <= 8'h29; // Set the key value to make the dino jump
            key_release <= 1'b0;
        end
        else begin 
            key<=8'h00;
            key_release<=1'b1;
        end
    end

    // Output control keys of interest
    assign fsm_input_user = (key == 8'h29) & !key_release; 
    assign fsm_reset = (key == 8'h5A) & !key_release;//     90
endmodule
