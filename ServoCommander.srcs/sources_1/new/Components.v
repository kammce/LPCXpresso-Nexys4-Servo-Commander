`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/13/2015 09:33:31 AM
// Design Name: 
// Module Name: Components
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



// module MicroToAngle(
// 	input wire [RC_SIGNAL_WIDTH-1:0] pos,
// 	output reg [RC_SIGNAL_WIDTH-1:0] out_pos
// );

// integer i;
// integer at5;

// always @(*) begin
// 	for(i = 0; i < 1000; i)
// end


module PositionMux(
	input wire [1:0] ctrl,
	input wire [RC_SIGNAL_WIDTH-1:0] sweep_pos,
	input wire [PIN_POS_WIDTH-1:0] pin_pos,
	input wire [RC_SIGNAL_WIDTH-1:0] ser_pos,
	output reg [RC_SIGNAL_WIDTH-1:0] out_pos
);


parameter RC_SIGNAL_WIDTH = 11;
parameter PIN_POS_WIDTH = 10;
parameter BCD_WIDTH = 4;

parameter POSITION_FILE_WIDTH = 32;
parameter POSITION_WIDTH = 11;
parameter PWMS = 4;

wire valid;
wire [RC_SIGNAL_WIDTH-1:0] segment_pos;

Segment U0 (
    .in(pin_pos),
    .out(segment_pos),
    .valid(valid)
);

always @(*) begin
	case(ctrl)
		0: out_pos = sweep_pos;
		1: out_pos = (pin_pos << 1) | 1'b1;
		2: out_pos = segment_pos;
		3: out_pos = ser_pos;
		default: out_pos = sweep_pos;
	endcase
end

endmodule

module SweepPosition(
	input wire clk200Hz,
	input wire rst,
    input wire [2:0] speed,
    output reg [RC_SIGNAL_WIDTH-1:0] pos
);


parameter RC_SIGNAL_WIDTH = 11;
parameter PIN_POS_WIDTH = 10;
parameter BCD_WIDTH = 4;

parameter POSITION_FILE_WIDTH = 32;
parameter POSITION_WIDTH = 11;
parameter PWMS = 4;

reg dir;

/* Will sweep from 0 degrees to 180 degrees and back with 1000 degrees of precision.
 * Will take 5 seconds to do one sweep.
 *
 */
 
always @(posedge clk200Hz or posedge rst) begin
	if (rst) begin
		pos = 10'd0;
		dir = 0;
	end
	else if(dir == 0) begin
		pos = pos + (speed << 1);
	    // max of 1000 positions
		if(pos >= 2000) begin 
			dir = 1;
		end
	end
	else if(dir == 1) begin
		pos = pos - (speed << 1);
		// Check Position to determine 
		if (pos <= 0) begin
	        dir = 0;
		end
	end
end

endmodule

module AngleToPWM(
	input wire [RC_SIGNAL_WIDTH-1:0] pos,
	input wire clk1MHz,
	input wire rst,
	output reg pwm
);

parameter RC_SIGNAL_WIDTH = 11;
parameter PIN_POS_WIDTH = 10;
parameter BCD_WIDTH = 4;

parameter POSITION_FILE_WIDTH = 32;
parameter POSITION_WIDTH = 11;
parameter PWMS = 4;

parameter time_width   = 20000; // 20 ms = 20000 us
parameter pos_time_min = 500; // 1 ms = 1000 us
parameter pos_time_max = 2500; // 2 ms = 2000 us
integer current_time;
reg [10:0] stored_pos;
reg [1:0] state;

always @(posedge clk1MHz or posedge rst) begin
	if (rst) begin
		pwm = 1'b1;
		state = 3'b0;
		current_time = 0;
		stored_pos = 0;
	end
	else if(pos > 2500 || pos < 0) begin
		pwm = 1'b1;
	end
	else begin
		case(state)
			// Set inital pulse
			// Set pulse high for 1ms
			0: begin 
				pwm = 1;
				//if (current_time >= pos_time_min) begin
				stored_pos = pos;
				state = 3'h1;
				//end
			end
			// Set Positive Angle portion of pulse 
			1: begin
				pwm = 1;
				if (current_time >= stored_pos) begin
					state = 3'h2;
				end
			end
			// Set Negative Angle portion of pulse 
			// Wait until 20ms is up!
			2: begin
				pwm = 0;
				if (current_time >= time_width) begin
					state = 3'h0;
					current_time = 0;
				end
			end
		endcase
		current_time = current_time + 1;
	end
end

endmodule
