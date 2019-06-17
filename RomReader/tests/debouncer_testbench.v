`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:25:51 06/17/2019
// Design Name:   debouncer
// Module Name:   E:/PLD/RomChipReader/RomReader/tests/debouncer_testbench.v
// Project Name:  RomReader
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: debouncer
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module debouncer_testbench;

	// Inputs
	reg clk;
	reg reset;
	reg line;

	// Outputs
	wire debounced_line;
	reg [31:0] counter;

	// Instantiate the Unit Under Test (UUT)
	debouncer uut (
		.clk(clk), 
		.reset(reset), 
		.line(line), 
		.debounced_line(debounced_line)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		line = 1;
		counter = 0;

		// Wait 100 ns for global reset to finish
		#200
      reset = 0;
		// Add stimulus here
		#200
      reset = 1;
	end
	
	always
	begin
	#10 clk <= ~clk;
   counter <= counter + 1;
	if (counter == 60)
	    line <= 0;
	if (counter == 360)
       line <= 1;
	end
      
endmodule

