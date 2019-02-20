`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:40:06 02/20/2019
// Design Name:   rom_reader
// Module Name:   E:/PLD/RomChipReader/RomReader/tests/rom_reader_testbench.v
// Project Name:  RomReader
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: rom_reader
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module rom_reader_3601_testbench;

	// Inputs
	reg clk;
	reg increment_address;
	reg decrement_address;
	reg reset_n;
	reg [0:0] data_line_in;

   reg [9:0] counter;

	// Outputs
	wire [3:0] operation;
	wire [0:0] address_line;
	wire [0:0] data_line;

	// Instantiate the Unit Under Test (UUT) for testing 3601 (556PT4) chip
	rom_reader #
	(
	    .DATA_WIDTH(4),
		 .ADDRESS_WIDTH(8)
		 //.SELECTED_CHIP(`)
	)uut 
	(
		.clk(clk), 
		.increment_address(increment_address), 
		.decrement_address(decrement_address), 
		.reset_n(reset_n), 
		.data_line_in(data_line_in), 
		.operation(operation), 
		.address_line(address_line), 
		.data_line(data_line)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		increment_address = 0;
		decrement_address = 0;
		reset_n = 1;
		data_line_in = 0;

		// Wait 200 ns for pulse reset
		#200;
      reset_n = 0;
		// Add stimulus here
      #200;
		reset_n = 1;
	end
	
	always
	begin
	    #100 clk <= ~clk;
		 counter <= counter + 1;
	end
      
endmodule

