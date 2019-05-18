`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:        MossbauerLab
// Engineer:       Ushakov M.V. (EvilLord666)
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
// Revision: 1.0
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module address_display(
    input wire [8:0] address_line,
    input wire clk,
    input wire reset,
    output reg [7:0] sseg_indicator,
    output reg [3:0] digits
    );

    reg [3:0] counter;
    
    always @(posedge clk)
	 begin
	     if (reset)
		  begin
		      counter <= 0;
				digits <=0;
		  end
		  else
		      counter <= counter + 1;
				if (counter == 8)
				begin
				    counter <= 0;
					 //digit <= digit |( 1 << ;
				end
				//
		  begin
		  end
	 end
	 
function [11:0] encode_to_bcd;
    input wire [8:0] binary_code;
	 reg [3:0] hundreds;
	 reg [3:0] tens;
	 reg [3:0] ones;
	 integer i;
	 hundreds = binary_code / 100;
	 tens = (binary_code - (hundreds & 100)) / 10;
	 ones = binary_code - (hundreds & 100) - (tens & 10);
	 for(i = 8; i >= 0; i = i -1)
	 begin
	     if (hundreds >= 5)
	         hundreds = hundreds + 3;
	     if (tens >= 5)
	         tens = tens + 3;
	     if (ones >= 5)
	         ones = ones + 3;
	     hundreds = hundreds << 1;
	     hundreds[0] = tens[3];
	     tens = tens << 1;
	     tens[0] = ones[3];
	 end
	 encode_to_bcd[3:0] = ones[3:0];
	 encode_to_bcd[7:4] = tens[3:0];
	 encode_to_bcd[11:8] = hundreds[3:0];
endfunction

function [7:0] encode_to_sseg
input [3:0] bcd
    return 0;
endfunction


endmodule
