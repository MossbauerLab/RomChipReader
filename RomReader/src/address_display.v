`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:42:53 03/30/2019 
// Design Name: 
// Module Name:    address_display 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module address_display(
    input wire [8:0] address_line,
    input wire clk,
    input wire reset,
    output reg [7:0] sseg_indicator,
    output reg [3:0]digits
    );

    reg [3:0] counter;
    
    always @(posedge clk)
	 begin
	     if (reset)
		  begin
		       counter <= 0;
		  end
		  else
		      
		  begin
		  end
	 end

endmodule

// todo: umv: add function digit data selector