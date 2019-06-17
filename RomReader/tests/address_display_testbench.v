`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:38:52 06/12/2019
// Design Name:   address_display
// Module Name:   E:/PLD/RomChipReader/RomReader/tests/address_display_testbench.v
// Project Name:  RomReader
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: address_display
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module address_display_testbench;

    // Inputs
    reg [8:0] address_line;
    reg clk;
    reg reset;

    // Outputs
    wire [7:0] sseg_indicator;
    wire [3:0] digits;
    reg [9:0] counter;

    // Instantiate the Unit Under Test (UUT)
    address_display uut (
        .address_line(address_line), 
        .clk(clk), 
        .reset(reset), 
        .sseg_indicator(sseg_indicator), 
        .digits(digits)
    );

    initial begin
          clk = 0;
        reset = 1;
        counter = 0;
          address_line = 0;

        // Wait 200 ns for pulse reset
        #200 reset = 0;
        // Add stimulus here
        #200 reset = 1;
    end
    
    always 
    begin
        #10 clk <= ~clk;
        counter <= counter + 1;
          if(counter == 70)
              address_line <= 1;
          if(counter == 90)
              address_line <= 124;
          if(counter == 110)
              address_line <= 279;
    end
      
endmodule

