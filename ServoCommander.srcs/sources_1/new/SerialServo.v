`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2015 08:47:07 AM
// Design Name: 
// Module Name: SerialServo
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


/*
	input wire clk100MHz,
	input wire clk1MHz,
	input wire rst,
	input wire ext_clk,
	input wire ext_flush,
	input wire serial,
	input wire [CHANNEL_WIDTH-1:0] channel,
	output wire pwm
*/

module SerialServo(
	input wire clk100MHz,
	input wire clk1MHz,
	input wire rst,
	input wire ext_clk,
	input wire ext_flush,
	input wire serial,
	input wire [CHANNEL_WIDTH-1:0] channel,
	output reg pwm
);

parameter POSITION_WIDTH = 11;
parameter CHANNEL_WIDTH = 5;
parameter BUFFER_LENGTH = 16;

reg [BUFFER_LENGTH-1:0] buffer;
reg [CHANNEL_WIDTH-1:0] channel_select;
reg [POSITION_WIDTH-1:0] position;

reg [CHANNEL_WIDTH-1:0] ser_channel;
reg [POSITION_WIDTH-1:0] ser_pos;

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

AngleToPWM U2 (
	.pos(position),
	.clk1MHz(clk1MHz),
	.rst(rst),
	.pwm(empty)
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
			ser_pos = position;
			pwm = ext_clk;
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



/*
parameter POSITION_WIDTH = 11;
parameter CHANNEL_WIDTH = 5;
parameter BUFFER_LENGTH = 16;

reg [BUFFER_LENGTH-1:0] buffer;
reg [CHANNEL_WIDTH-1:0] channel_select;
reg [POSITION_WIDTH-1:0] position;

wire clk;
wire flush;
wire empty;

assign pwm = position[0];

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

AngleToPWM U2 (
	.pos(position),
	.clk1MHz(clk1MHz),
	.rst(rst),
	.pwm(empty)
);

integer ptr;
//reg [2:0] state;

// parameter LISTENING = 0;
// parameter READING_SERIAL = 1;
// parameter SKIP = 2;

always @(posedge clk or posedge rst) begin
	if(rst) begin
		position = 1500;
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
			if(channel_select == channel) begin
				position = buffer[BUFFER_LENGTH-6:0]; 
			end
			// Reset buffer and ptr
			buffer = 0;
			ptr = 0;
		end
	end
	else begin
        position = 1500;
        buffer = 0;
        ptr = 0;
	end
end
*/

	// if(rst) begin
	// 	position = 1500;
	//  buffer = 0;
	//  ptr = 0;
	//  state = 0;
	// end
	// else if(!flush) begin
	// 	case(state)
	// 		LISTENING: begin
	// 			if(ptr < 5) begin
	// 				buffer[(BUFFER_LENGTH-1)-ptr] = serial;
	// 			end
	// 			else begin
 //                    buffer[(BUFFER_LENGTH-1)-ptr] = serial;
	// 				// Channel Select: 15th-11th bit (5 bit width)
	// 				channel_select = buffer[BUFFER_LENGTH-1:BUFFER_LENGTH-5]; 
	// 				if(channel_select == channel) begin 
	// 					state = READING_SERIAL;
	// 				end
	// 				else begin
	// 			        state = SKIP;
	// 				end
	// 			end
	// 			ptr = ptr + 1;
	// 		end
	// 		READING_SERIAL: begin
	// 			if(ptr < 15) begin
	// 				buffer[(BUFFER_LENGTH-1)-ptr] = serial;
	// 				ptr = ptr + 1;
	// 			end
	// 			else begin
	// 			    buffer[(BUFFER_LENGTH-1)-ptr] = serial;
	// 				// Position: 11th-0th bit (11 bit width)
	// 				position = buffer[BUFFER_LENGTH-6:0]; 
	// 				// Reset buffer and ptr
	// 				buffer = 0;
	// 				ptr = 0;
	// 				state = LISTENING;
	// 			end
	// 		end
	// 		SKIP: begin
	// 			if(ptr == 15) begin
	// 		        buffer = 0;
	// 		        ptr = 0;
	// 				state = LISTENING;
	// 			end
	// 			else begin
	// 			    ptr = ptr + 1;
	// 			end
	// 		end
	// 		default: state = LISTENING;
	// 	endcase
	// end
	// else begin
	//        position = 0;
	//        buffer = 0;
	//        ptr = 0;
	// end