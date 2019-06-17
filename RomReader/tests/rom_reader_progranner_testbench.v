`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:32:42 06/17/2019
// Design Name:   rom_reader_programmer
// Module Name:   E:/PLD/RomChipReader/RomReader/tests/rom_reader_progranner_testbench.v
// Project Name:  RomReader
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: rom_reader_programmer
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module rom_reader_progranner_testbench;

	// Inputs
	reg chip_selection_button;
	reg increment_address_button;
	reg decrement_address_button;
	reg reset_button;
	reg clk;
	reg [7:0] chip_data_port;

	// Outputs
	wire [8:0] chip_address_port;
	wire [3:0] ip3604_selection_port;
	wire [1:0] ip3601_selection_port;
	wire [7:0] data_output_port;
	wire [7:0] sseg_tube_port;
	wire [3:0] sseg_selected_digit;
	wire ip3601_selection_led;
	wire ip3604_selection_led;

	// Instantiate the Unit Under Test (UUT)
	rom_reader_programmer programmer (
		.chip_selection_button(chip_selection_button), 
		.increment_address_button(increment_address_button), 
		.decrement_address_button(decrement_address_button), 
		.reset_button(reset_button), 
		.clk(clk), 
		.chip_data_port(chip_data_port), 
		.chip_address_port(chip_address_port), 
		.ip3604_selection_port(ip3604_selection_port), 
		.ip3601_selection_port(ip3601_selection_port), 
		.data_output_port(data_output_port), 
		.sseg_tube_port(sseg_tube_port), 
		.sseg_selected_digit(sseg_selected_digit), 
		.ip3601_selection_led(ip3601_selection_led), 
		.ip3604_selection_led(ip3604_selection_led)
	);
	
	reg [31:0] counter;

	initial begin
		// Initialize Inputs
		chip_selection_button = 0;
		increment_address_button = 1;
		decrement_address_button = 1;
		reset_button = 1;
		clk = 0;
		chip_data_port = 0;
      counter = 0;
		// Wait 100 ns for global reset to finish
		#200;
      reset_button = 0; 
		// Add stimulus here
		#200;
      reset_button = 1;
	end
	
	always
	begin
	#10 clk <= ~clk;
   counter <= counter + 1;
	if (counter == 1000)
	    increment_address_button <= 0;
	if (counter == 4000)
       increment_address_button <= 1;
	end
   
endmodule

