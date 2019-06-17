`timescale 1ns / 1ps
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company:        MossbauerLab
// Engineer:       Ushakov M.V. (EvilLord666)
// 
// Create Date:    00:36:08 02/10/2019 
// Design Name: 
// Module Name:    rom_reader_programmer
// Project Name:   RomReader
// Target Devices: Any, but designed for Cyclone IV
// Tool versions: 
// Description:    An integration of sets of rom_reader (one for IP3601 and one for IP3604)
//                 with peripheria of EazyFPGA board, this module is a TOP module.
// Dependencies:   rom_reader, address_display
//
// Revision: 1.0
// Additional Comments: selected_chip (0 - IP3601, 1 - IP3604), output for 8-bit LED Port mith manual move by memory address
//                      via press buttons for increment and decrement
// Peripheria usage (In RZ-EasyFPGA A2.1 Board):
//                   Clock (23)
//                   S1 Button - Address decrement (88)
//                   S2 Button - Address increment (89)
//                   Reset Button - RESET (25)
//                   SW4 - Chip mode switch (IP3601, IP3604) - (91)
//                   LED1 - IP3601 (86)
//                   LED2 - IP3604 (87)
//                   7SEG TUBE - Address display Digits selection - 133 (LSB), 135, 136, 137 (MSB), 
//                             - digit value  128 (LSB), 121, 125, 129, 132, 126, 124, 127 (MSB)
// GPIO USAGE:       Address line  - 110 (LSB, 0 bit), 112, 114, 119, 66, 68, 70, 72, 74 (MSB, 8bit)
//                   IP3604 select - 138 (LSB), 142, 144, 2 (MSB)
//                   IP3601 select - 11 (LSB), 80 (MSB)
//                   Data line from IP3601/IP3604 - 64(LSB), 59, 55, 53, 51, 49, 44, 42 (MSB)
//                   Data output line 141 (LSB), 143, 1, 3, 10, 7, 77, 76
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module rom_reader_programmer(
    input wire chip_selection_button,
    input wire increment_address_button,              // button press means logical 1 on this line
    input wire decrement_address_button,              // button press means logical 1 on this line
    input wire reset_button,                          // todo:umv think about this button usage
    input wire clk,                                   // clock line from board
    input wire [7:0] chip_data_port,
    output wire [8:0] chip_address_port,
    output wire [3:0] ip3604_selection_port,
    output wire [1:0] ip3601_selection_port,
    output wire [7:0] data_output_port,
    output wire [7:0] sseg_tube_port,
    output wire [3:0] sseg_selected_digit,
    output wire ip3601_selection_led,
    output wire ip3604_selection_led
);

wire [7:0] ip3601_address_port;
wire [3:0] ip3601_output_port;

wire [8:0] ip3604_address_port;
wire [7:0] ip3604_output_port;


wire ip3604_reset;
wire ip3601_reset;

wire increment_debounced;
wire decrement_debounced;

assign chip_address_port = chip_selection_button == 1 ? ip3604_address_port : ip3601_address_port;
assign data_output_port = chip_selection_button == 1 ? ip3604_output_port : ip3601_output_port;

assign ip3601_selection_led = chip_selection_button == 0 ? 1'b1: 1'b0;
assign ip3604_selection_led = chip_selection_button == 1 ? 1'b1: 1'b0;

assign ip3604_reset = reset_button & ip3604_selection_led;
assign ip3601_reset = reset_button & ip3601_selection_led;

debouncer #(.DEBOUNCE_VALUE(1000))
    inc_debouncer(.clk(clk), .reset(reset_button), .line(increment_address_button), .debounced_line(increment_debounced));
debouncer #(.DEBOUNCE_VALUE(1000))
    dec_debouncer(.clk(clk), .reset(reset_button), .line(decrement_address_button), .debounced_line(decrement_debounced));

rom_reader #(.DATA_WIDTH(8), .ADDRESS_WIDTH(9)) 
    ip3604_reader(.clk(clk), .reset_n(ip3604_reset), 
                  .increment_address(~increment_debounced),
                  .decrement_address(~decrement_debounced),
                  .data_line_in(chip_data_port),
                  .operation(ip3604_selection_port),
                  .address_line(ip3604_address_port),
                  .data_line(ip3604_output_port));

rom_reader #(.DATA_WIDTH(4), .ADDRESS_WIDTH(8)) 
    ip3601_reader(.clk(clk), .reset_n(ip3601_reset), 
                  .increment_address(~increment_debounced),
                  .decrement_address(~decrement_debounced),
                  .data_line_in(chip_data_port[3:0]),
                  .operation(ip3601_selection_port),
                  .address_line(ip3601_address_port),
                  .data_line(ip3601_output_port));

// memory address
address_display ssegment_tube(.address_line(chip_address_port), .clk(clk), .reset(reset_button), 
                              .sseg_indicator(sseg_tube_port), .digits(sseg_selected_digit));

endmodule
