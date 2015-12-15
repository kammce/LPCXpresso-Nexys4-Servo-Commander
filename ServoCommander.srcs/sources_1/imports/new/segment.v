`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/15/2015 08:10:18 AM
// Design Name: 
// Module Name: shifter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//// CaseX Priority Decoder
module Segment(
    input wire [9:0] in,
    output reg [10:0] out,
    output reg valid
);

always @(in) begin
	valid = 1;
	casex(in)
		11'b1xxxxxxxxx: out = 2000;
		11'b01xxxxxxxx: out = 1800;
		11'b001xxxxxxx: out = 1600;
		11'b0001xxxxxx: out = 1400;
		11'b00001xxxxx: out = 1200;
		11'b000001xxxx: out = 1000;
		11'b0000001xxx: out = 800;
		11'b00000001xx: out = 600;
		11'b000000001x: out = 400;
		11'b0000000001: out = 200;
		default: begin
			valid = 0;
			out = 11'b0;
		end
	endcase
end
endmodule
