`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  MossbauerLab
// Engineer: Ushakov M.V. (EvilLord666)
// 
// Create Date:    00:36:08 02/10/2019 
// Design Name: 
// Module Name:    rom_reader_programmer
// Project Name:   RomReader
// Target Devices: Any
// Tool versions: 
// Description:    An integration of sets of rom_reader (one for IP3601 and one for IP3604)
//                 with peripheria of EazyFPGA board (TOP module)
// Dependencies:   
//
// Revision: 
// Revision 1.0
// Additional Comments: selected_chip (0 - IP3601, 1 - IP3604)
//
//////////////////////////////////////////////////////////////////////////////////
module rom_reader_programmer(
    input wire selected_chip,
    input wire increment_address_button,
    input wire decrement_address_button,
    input wire reset_button,                // NOT REAL RESET
    input wire clk,
    input wire [7:0] chip_data_port,
    output wire [9:0] chip_address_port,
    output wire [3:0] chip_selection_port,
    output wire [7:0] data_output_led_port
    // todo: add 7seg port
);

//todo: make different resets ....
wire[9:0] address_seven_seg;

rom_reader #(.DATA_WIDTH(8), .ADDRESS_WIDTH(9)) 
    ip3604_reader(.clk(clk), .reset_n(reset_button), 
                  .increment_address(increment_address_button),
                  .decrement_address(decrement_address_button),
                  .data_line_in(chip_data_port),
                  .operation(chip_selection_port),
                  .address_line(address_seven_seg),
                  .data_line(data_output_led_port));

rom_reader #(.DATA_WIDTH(4), .ADDRESS_WIDTH(8)) 
    ip3601_reader(.clk(clk), .reset_n(reset_button), 
                  .increment_address(increment_address_button),
                  .decrement_address(decrement_address_button),
                  .data_line_in(chip_data_port),
                  .operation(chip_selection_port),
                  .address_line(address_seven_seg),
                  .data_line(data_output_led_port));

endmodule
