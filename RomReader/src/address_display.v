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
    reg [11:0] tubes_bcd_values;
    reg [6:0] sseg_value;
    
    always @(posedge clk)
    begin
        if (reset)
        begin
            counter <= 0;
            digits <= 1;
            tubes_bcd_values <= 0;
            sseg_value <= 0;
        end
        else
            counter <= counter + 1;
            if (counter == 8)
            begin
                counter <= 0;
                digits <= digits << 1;
                tubes_bcd_values <= encode_to_bcd(address_line);
                case (digits)
                4'b0001:
                    sseg_value <= encode_to_sseg(tubes_bcd_values[3:0]);
                4'b0010:
                    sseg_value <= encode_to_sseg(tubes_bcd_values[7:4]);
                4'b0100:
                    sseg_value <= encode_to_sseg(tubes_bcd_values[11:8]);
                default:
                    sseg_value <= 0;
                endcase  
                sseg_indicator <= sseg_value;					 
            end
            if (digits == 0)
                digits <= 1;
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

function [6:0] encode_to_sseg;
input [3:0] bcd;
    case (bcd)
    4'b0000: encode_to_sseg = 7'b1111110;
    4'b0001: encode_to_sseg = 7'b0110000;
    4'b0010: encode_to_sseg = 7'b1101101;
    4'b0011: encode_to_sseg = 7'b1111001;
    4'b0100: encode_to_sseg = 7'b0110011;
    4'b0101: encode_to_sseg = 7'b1011011;
    4'b0110: encode_to_sseg = 7'b1011111;
    4'b0111: encode_to_sseg = 7'b1110000;
    4'b1000: encode_to_sseg = 7'b1111111;
    4'b1001: encode_to_sseg = 7'b1111011;
    default: encode_to_sseg = 7'b1111110;
    endcase
endfunction


endmodule
