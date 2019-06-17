`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:        MossbauerLab
// Engineer:       Ushakov M.V. (EvilLord666)
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
// Revision 1.0
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module debouncer #
(
    DEBOUNCE_VALUE = 100
)
(
    input wire clk,
    input wire reset,
    input wire line,
    output reg debounced_line
);

// localparam integer DEBOUNCE_VALUE = 10;

reg [31:0] debounce_counter;

always @(posedge clk)
begin
    if (~reset)
    begin
        debounced_line <= line == 1 ? 1 : 0;
        debounce_counter <= 0;
    end
    else
    begin
        if (~line) // if line is 0
        begin
            // if debounced_line was 1, falling edge
            if (debounced_line == 1)
            begin
                $display("falling edge detected");
                debounce_counter <= debounce_counter + 1;
                if (debounce_counter == DEBOUNCE_VALUE)
                begin
                    debounced_line <= 0;
                    debounce_counter <= 0;
                end
            end
            // line and debounced_line have the same values = 0
            else
            begin
                // $display("repeating 0 value");
                debounced_line <= 0;
            end
        end
        else // line is 1
        begin
            // if debounced_value was 0, rising edge
            if (debounced_line == 0)
            begin
                $display("rising edge detected");
                debounce_counter <= debounce_counter + 1;
                if (debounce_counter == DEBOUNCE_VALUE)
                begin
                    debounced_line <= 1;
                    debounce_counter <= 0;
                end
            end
            // line and debounced_line have the same values = 1
            else 
            begin
                // $display("repeating 1 value");
                debounced_line <= 1;
            end
        end
    end
end

endmodule
