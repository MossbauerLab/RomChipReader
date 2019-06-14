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

    reg [31:0] counter;
    reg [11:0] tubes_bcd_values;
	 reg [2:0] digit_counter;
    
    always @(posedge clk)
    begin
        if (~reset)
        begin
            counter <= 0;
            digits <= 4'b1111;
            tubes_bcd_values <= 0;
            sseg_indicator <= 255;
				digit_counter <= 0;
        end
        else
            counter <= counter + 1;
            if (counter == 4)
            begin
                tubes_bcd_values <= //12'b001101011001; // 359
					                     encode_to_bcd(address_line);
                case (digit_counter)
                3'b000:
					 begin
                    sseg_indicator <= encode_to_sseg(tubes_bcd_values[11:8]);
						  digits <= 4'b1011;
					 end
                3'b001:
					 begin
                    sseg_indicator <= encode_to_sseg(tubes_bcd_values[7:4]);
						  digits <= 4'b1101;
					 end
                3'b010:
					 begin               
						  sseg_indicator <= encode_to_sseg(tubes_bcd_values[3:0]);
						  digits <= 4'b1110;
					 end
                default:
					 begin
					 end
                endcase  
            end
            if (counter == 100000)
				begin
				    counter <= 0;
					 digit_counter <= digit_counter + 1;
					 if (digit_counter == 3'b010)
				        digit_counter <= 0;			  
			   end
        begin
        end
    end
    
function [11:0] encode_to_bcd;
    input wire [8:0] binary_code;
    reg [3:0] hundreds;
    reg [3:0] tens;
    reg [3:0] ones;
    integer i;
	 begin
        hundreds = 0;
        tens = 0;
        ones = 0;
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
            ones = ones << 1;
            ones[0] = binary_code[i];
        end
        $display("Encode to bcd, hundreds : %d", hundreds);
        $display("Encode to bcd, tens : %d", tens);
        $display("Encode to bcd, ones : %d", ones);
        encode_to_bcd[3:0] = ones[3:0];
        encode_to_bcd[7:4] = tens[3:0];
        encode_to_bcd[11:8] = hundreds[3:0];
	 end
endfunction

function [7:0] encode_to_sseg;
input [3:0] bcd;
    case (bcd)
    4'b0000: encode_to_sseg = 8'b11000000; // 0
    4'b0001: encode_to_sseg = 8'b11111001; // 1
    4'b0010: encode_to_sseg = 8'b10100100; // 2
    4'b0011: encode_to_sseg = 8'b10110000; // 3
    4'b0100: encode_to_sseg = 8'b10011001; // 4
    4'b0101: encode_to_sseg = 8'b10010010; // 5
    4'b0110: encode_to_sseg = 8'b10000010; // 6
    4'b0111: encode_to_sseg = 8'b11111000; // 7
    4'b1000: encode_to_sseg = 8'b10000000; // 8
    4'b1001: encode_to_sseg = 8'b10010000; // 9
    default: encode_to_sseg = 8'b11000000; // 0
    endcase
endfunction


endmodule
