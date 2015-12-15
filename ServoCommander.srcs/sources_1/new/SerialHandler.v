`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2015 12:22:18 PM
// Design Name: 
// Module Name: SerialHandler
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

module SerialHandler(
	input wire clk100MHz,
	input wire clk1MHz,
	input wire rst,
	input wire ext_clk,
	input wire ext_flush,
	input wire serial,
	input wire [CHANNEL_WIDTH-1:0] channel,
	output reg [CHANNEL_WIDTH-1:0] ser_channel,
	output reg [POSITION_WIDTH-1:0] ser_pos
);

parameter POSITION_WIDTH = 11;
parameter CHANNEL_WIDTH = 5;
parameter BUFFER_LENGTH = 16;

reg [BUFFER_LENGTH-1:0] buffer;
reg [CHANNEL_WIDTH-1:0] channel_select;
reg [POSITION_WIDTH-1:0] position;

wire clk;
wire flush;

ExtToIntSync U0(
	.clk(clk100MHz),
	.rst(rst),
	.ext_signal(ext_clk),
	.int_signal(clk)
);

ExtToIntSync U1(
	.clk(clk100MHz),
	.rst(rst),
	.ext_signal(ext_flush),
	.int_signal(flush)
);

integer ptr;

always @(posedge clk or posedge rst) begin
	if(rst) begin
		position = 0;
        buffer = 0;
        ptr = 0;
	end
	else if(!flush) begin
		if(ptr < 15) begin
			buffer[(BUFFER_LENGTH-1)-ptr] = serial;
			ptr = ptr + 1;
		end
		else begin
			// Channel Select: 15th-11th bit (5 bit width)
			channel_select = buffer[BUFFER_LENGTH-1:BUFFER_LENGTH-5]; 
			// Position: 11th-0th bit (11 bit width)
			position = buffer[BUFFER_LENGTH-6:0]; 
			// Write to position file @ channel select point
			// Make position a 11 bit signal and OR a 1 with it.
			//position_file[channel_select] = (position << 1) | 1'b1;
			if(channel_select == channel) begin 
			     ser_pos = position;
			end
			//ser_pos = position;
			ser_channel = channel_select;
			// Reset buffer and ptr
			buffer = 0;
			ptr = 0;
		end
	end
	else begin
        position = 0;
        buffer = 0;
        ptr = 0;
	end
end

endmodule