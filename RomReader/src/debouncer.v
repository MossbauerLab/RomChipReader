`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:56:29 06/17/2019 
// Design Name: 
// Module Name:    debouncer 
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
module debouncer(
    input wire clk,
    input wire reset,
    input wire line,
    output reg debounced_line
    );

localparam integer DEBOUNCE_VALUE = 100;

reg [31:0] debounce_counter;

always @(posedge clk)
begin
    if (reset)
    begin
        debounced_line <= 0;
        debounce_counter <= 0;
    end
    else
    begin
        if (~line)
        begin
		      // if there was changes from previous value
            if (debounced_line == 1)
            begin
                debounce_counter <= debounce_counter + 1;
                if (debounce_counter == DEBOUNCE_VALUE)
                begin
                    debounced_line <= 0;
                    debounce_counter <= 0;
                end
            end
				else debounced_line <= line;
        end
        else
        begin
            if (debounced_line == 0)
            begin
                debounce_counter <= debounce_counter + 1;
                if (debounce_counter == DEBOUNCE_VALUE)
                begin
                    debounced_line <= 1;
                    debounce_counter <= 0;
                end
            end
				else debounced_line <= line;
        end
    end
end

endmodule
