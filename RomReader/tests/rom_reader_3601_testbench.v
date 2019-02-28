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
    reg [3:0] data_line_in;

    reg [9:0] counter;

    // Outputs
    wire [3:0] operation;
    wire [7:0] address_line;
    wire [3:0] data_line;
     
     localparam reg [3:0] A0 = 4'b1111;
     localparam reg [3:0] A1 = 4'b1110;
     localparam reg [3:0] A2 = 4'b1100;
     localparam reg [3:0] A3 = 4'b1000;

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
        reset_n = 0;
        data_line_in = 0;
        counter = 0;

        // Wait 200 ns for pulse reset
        #200;
      reset_n = 1;
        // Add stimulus here
      #200;
        reset_n = 0;
    end
    
    always
    begin
        #100 clk <= ~clk;
        counter <= counter + 1;
          
        if(counter == 6)   // A + 1
        begin
            data_line_in <= A0;
            increment_address <= 1;
        end
        if(counter == 7)
        begin
            increment_address <= 0;
        end
        if(counter == 10)  // A + 1
        begin
            data_line_in <= A1;
            increment_address <= 1;
        end
        if(counter == 11)
        begin
            increment_address <= 0;
        end
          if(counter == 15)   // A - 1
        begin
            data_line_in <= A0;
            decrement_address <= 1;
        end
        if(counter == 16)
        begin
            decrement_address <= 0;
        end
          if(counter == 20)  // A + 1
        begin
            data_line_in <= A1;
            increment_address <= 1;
        end
        if(counter == 21)
        begin
            increment_address <= 0;
        end
        if(counter == 25)
        begin
            data_line_in <= A2;
            increment_address <= 1;
        end
        if(counter == 26)
        begin
            increment_address <= 0;
        end
        if(counter == 30)
        begin
            data_line_in <= A3;
            increment_address <= 1;
        end
        if(counter == 31)
        begin
            counter <= 0;
            data_line_in <= 0;
            increment_address <= 0;
        end
    end
      
endmodule

