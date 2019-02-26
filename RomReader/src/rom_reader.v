`timescale 1ns / 1ps
`define IP3604 1
`define IP3601 2
`define IP3604_DATA_WIDTH 8
`define IP3601_DATA_WIDTH 4
`define IP3604_ADDR_WIDTH 9
`define IP3601_ADDR_WIDTH 8
`define IP3604_MAX_COUNT 512
//////////////////////////////////////////////////////////////////////////////////
// Company:  MossbauerLab
// Engineer: Ushakov M.V. (EvilLord666)
// 
// Create Date:    00:36:08 02/10/2019 
// Design Name: 
// Module Name:    rom_reader 
// Project Name:   RomReader
// Target Devices: Any
// Tool versions: 
// Description:    A ROM reader module for reading 556PT5 (3604) and 556PT4 (3601)
//                 operation is a bus operation[0] is V1, operation[1] - V2, 
//                 operation[2] - V3, operation[3] - V4.
// Dependencies:   
//
// Revision: 
// Revision 1.0
// Additional Comments: reset_n shoul be pulsed like --___----------
//
//////////////////////////////////////////////////////////////////////////////////
module rom_reader #
(
     DATA_WIDTH = `IP3604_DATA_WIDTH,
     ADDRESS_WIDTH = `IP3604_ADDR_WIDTH
     // SELECTED_CHIP = `IP3604
)
(
     input wire clk,                                     // clock, we should select source in top level : auto or manual via pushing a button
     input wire increment_address,
     input wire decrement_address,
     input wire reset_n,
     input wire [DATA_WIDTH-1:0] data_line_in,           // data line from chip, pass through
     output wire [3:0] operation,                        // operation read or write (see datasheets in docs)
     output wire [ADDRESS_WIDTH-1:0] address_line,
     output wire [DATA_WIDTH-1:0] data_line
);

reg [ADDRESS_WIDTH-1:0] address_counter;
reg [3:0] operation_code;
reg [DATA_WIDTH-1:0] data_line_value;
reg state;

assign address_line = address_counter;
assign operation = operation_code;
assign data_line = data_line_value;

always @(posedge clk)
begin
    if (reset_n)
     begin
          operation_code <= 4'b1100;           // universal solution for both chips (IP3604 and 3601)
          state <= 0;
     end
     else
     begin
          data_line_value <= data_line_in;
          state <= 1;
     end
end

always @(negedge state or posedge increment_address or posedge decrement_address)
begin
    if(!state)
    begin
	     address_counter = 0;
    end
    else
    begin
        if (increment_address)
         begin
             address_counter = address_counter + 1;
              if (address_counter == 512)
                  address_counter = 0;
         end
         if (decrement_address)
         begin
             if (address_counter == 0)
                 address_counter = address_counter - 1;      
         end
     end
end

endmodule
