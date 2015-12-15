`timescale 500ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2015 11:27:42 AM
// Design Name: 
// Module Name: PWM_FPGA
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

module PWM_FPGA(
	input wire clk100MHz,
    input wire rst,
    input wire [1:0] ctrl,
    input wire [2:0] sweep_speed,
    input wire [9:0] pin_pos,
    input wire sclk,
    input wire serial,
    input wire flush,
    output wire [2:0] spi,
    output wire [PWMS-1:0] pwm,
    output wire clk1MHz,
    output wire clk200Hz, 
    output wire clk5KHz,
    output wire [7:0] LEDOUT,
    output wire [7:0] LEDSEL
);

	parameter RC_SIGNAL_WIDTH = 11;
	parameter PIN_POS_WIDTH = 10;
	parameter BCD_WIDTH = 4;

	parameter POSITION_FILE_WIDTH = 32;
	parameter POSITION_WIDTH = 11;
    parameter PWMS = 17;

	parameter CHANNEL_WIDTH = 5;

    assign spi = { sclk, flush, serial };

    wire [RC_SIGNAL_WIDTH-1:0] sweep_pos;
    wire [RC_SIGNAL_WIDTH-1:0] out_pos;
    wire [RC_SIGNAL_WIDTH-1:0] ser_pos;
    wire [CHANNEL_WIDTH-1:0] ser_channel;

    wire [15:0] pos [0:RC_SIGNAL_WIDTH-1];

    wire [BCD_WIDTH-1:0] ones;
    wire [BCD_WIDTH-1:0] tens;
    wire [BCD_WIDTH-1:0] hundreds;
    wire [BCD_WIDTH-1:0] thousands;

    wire [BCD_WIDTH-1:0] channel_ones;
    wire [BCD_WIDTH-1:0] channel_tens;
    wire [BCD_WIDTH-1:0] channel_hundreds;
    wire [BCD_WIDTH-1:0] channel_thousands;

    supply1 [7:0] vcc;

    wire [7:0] d5;
    wire [7:0] d4;

    wire [7:0] d3;
    wire [7:0] d2;
    wire [7:0] d1;
    wire [7:0] d0;

    assign d5[7] = 1'b1;
    assign d4[7] = 1'b1;

    assign d3[7] = 1'b1;
    assign d2[7] = 1'b1;
    assign d1[7] = 1'b1;
    assign d0[7] = 1'b1;

    clk_gen U0 (.clk100MHz(clk100MHz), 
        .rst(rst),
        .clk1MHz(clk1MHz),
        .clk200Hz(clk200Hz),
        .clk5KHz(clk5KHz)
    );

	SerialHandler SerH0 (
		.clk100MHz(clk100MHz),
		.rst(rst),
		.ext_clk(sclk),
		.ext_flush(flush),
		.serial(serial),
		.ser_pos(ser_pos),
		.ser_channel(ser_channel),
		.channel(5'h00)
	);

	SerialHandler SerH1 (
		.clk100MHz(clk100MHz),
		.rst(rst),
		.ext_clk(sclk),
		.ext_flush(flush),
		.serial(serial),
		.ser_pos(pos[1]),
		.channel(5'h01)
	);
    AngleToPWM ATP1 (
		.pos(pos[1]),
		.clk1MHz(clk1MHz),
		.rst(rst),
		.pwm(pwm[1])
   	);

	SerialHandler SerH2 (
		.clk100MHz(clk100MHz),
		.rst(rst),
		.ext_clk(sclk),
		.ext_flush(flush),
		.serial(serial),
		.ser_pos(pos[2]),
		.channel(5'h02)
	);
    AngleToPWM ATP2 (
		.pos(pos[2]),
		.clk1MHz(clk1MHz),
		.rst(rst),
		.pwm(pwm[2])
   	);

	SerialHandler SerH3 (
		.clk100MHz(clk100MHz),
		.rst(rst),
		.ext_clk(sclk),
		.ext_flush(flush),
		.serial(serial),
		.ser_pos(pos[3]),
		.channel(5'h03)
	);
    AngleToPWM ATP3 (
		.pos(pos[3]),
		.clk1MHz(clk1MHz),
		.rst(rst),
		.pwm(pwm[3])
   	);

	SerialHandler SerH4 (
		.clk100MHz(clk100MHz),
		.rst(rst),
		.ext_clk(sclk),
		.ext_flush(flush),
		.serial(serial),
		.ser_pos(pos[4]),
		.channel(5'h04)
	);
    AngleToPWM ATP4 (
		.pos(pos[4]),
		.clk1MHz(clk1MHz),
		.rst(rst),
		.pwm(pwm[4])
   	);

	SerialHandler SerH5 (
		.clk100MHz(clk100MHz),
		.rst(rst),
		.ext_clk(sclk),
		.ext_flush(flush),
		.serial(serial),
		.ser_pos(pos[5]),
		.channel(5'h05)
	);
    AngleToPWM ATP5 (
		.pos(pos[5]),
		.clk1MHz(clk1MHz),
		.rst(rst),
		.pwm(pwm[5])
   	);

	SerialHandler SerH6 (
		.clk100MHz(clk100MHz),
		.rst(rst),
		.ext_clk(sclk),
		.ext_flush(flush),
		.serial(serial),
		.ser_pos(pos[6]),
		.channel(5'h06)
	);
    AngleToPWM ATP6 (
		.pos(pos[6]),
		.clk1MHz(clk1MHz),
		.rst(rst),
		.pwm(pwm[6])
   	);

	SerialHandler SerH7 (
		.clk100MHz(clk100MHz),
		.rst(rst),
		.ext_clk(sclk),
		.ext_flush(flush),
		.serial(serial),
		.ser_pos(pos[7]),
		.channel(5'h07)
	);
    AngleToPWM ATP7 (
		.pos(pos[7]),
		.clk1MHz(clk1MHz),
		.rst(rst),
		.pwm(pwm[7])
   	);

	SerialHandler SerH8 (
		.clk100MHz(clk100MHz),
		.rst(rst),
		.ext_clk(sclk),
		.ext_flush(flush),
		.serial(serial),
		.ser_pos(pos[8]),
		.channel(5'h08)
	);
    AngleToPWM ATP8 (
		.pos(pos[8]),
		.clk1MHz(clk1MHz),
		.rst(rst),
		.pwm(pwm[8])
   	);

	SerialHandler SerH9 (
		.clk100MHz(clk100MHz),
		.rst(rst),
		.ext_clk(sclk),
		.ext_flush(flush),
		.serial(serial),
		.ser_pos(pos[9]),
		.channel(5'h09)
	);
    AngleToPWM ATP9 (
		.pos(pos[9]),
		.clk1MHz(clk1MHz),
		.rst(rst),
		.pwm(pwm[9])
   	);

	SerialHandler SerH10 (
		.clk100MHz(clk100MHz),
		.rst(rst),
		.ext_clk(sclk),
		.ext_flush(flush),
		.serial(serial),
		.ser_pos(pos[10]),
		.channel(5'h10)
	);
    AngleToPWM ATP10 (
		.pos(pos[10]),
		.clk1MHz(clk1MHz),
		.rst(rst),
		.pwm(pwm[10])
   	);

	SerialHandler SerH11 (
		.clk100MHz(clk100MHz),
		.rst(rst),
		.ext_clk(sclk),
		.ext_flush(flush),
		.serial(serial),
		.ser_pos(pos[12]),
		.channel(5'h11)
	);
    AngleToPWM ATP11 (
		.pos(pos[11]),
		.clk1MHz(clk1MHz),
		.rst(rst),
		.pwm(pwm[11])
   	);

	SerialHandler SerH12 (
		.clk100MHz(clk100MHz),
		.rst(rst),
		.ext_clk(sclk),
		.ext_flush(flush),
		.serial(serial),
		.ser_pos(pos[12]),
		.channel(5'h12)
	);
    AngleToPWM ATP12 (
		.pos(pos[12]),
		.clk1MHz(clk1MHz),
		.rst(rst),
		.pwm(pwm[12])
   	);

	SerialHandler SerH13 (
		.clk100MHz(clk100MHz),
		.rst(rst),
		.ext_clk(sclk),
		.ext_flush(flush),
		.serial(serial),
		.ser_pos(pos[13]),
		.channel(5'h13)
	);
    AngleToPWM ATP13 (
		.pos(pos[13]),
		.clk1MHz(clk1MHz),
		.rst(rst),
		.pwm(pwm[13])
   	);

	SerialHandler SerH14 (
		.clk100MHz(clk100MHz),
		.rst(rst),
		.ext_clk(sclk),
		.ext_flush(flush),
		.serial(serial),
		.ser_pos(pos[14]),
		.channel(5'h14)
	);
    AngleToPWM ATP14 (
		.pos(pos[14]),
		.clk1MHz(clk1MHz),
		.rst(rst),
		.pwm(pwm[14])
   	);

	SerialHandler SerH15 (
		.clk100MHz(clk100MHz),
		.rst(rst),
		.ext_clk(sclk),
		.ext_flush(flush),
		.serial(serial),
		.ser_pos(pos[15]),
		.channel(5'h15)
	);
    AngleToPWM ATP15 (
		.pos(pos[15]),
		.clk1MHz(clk1MHz),
		.rst(rst),
		.pwm(pwm[15])
   	);

    /********** Serial Servo **********/
	
	/******** Sweep ********/
    SweepPosition U1(
		.clk200Hz(clk200Hz),
        .rst(rst),
        .speed(sweep_speed),
		.pos(sweep_pos)
	);

	PositionMux U2(
		.ctrl(ctrl),
		.sweep_pos(sweep_pos),
		.pin_pos(pin_pos),
		.ser_pos(ser_pos),
		.out_pos(out_pos)
	);

    AngleToPWM ATP0 (
		.pos(out_pos),
		.clk1MHz(clk1MHz),
		.rst(rst),
		.pwm(pwm[0])
   	);

   	
    bin_to_bcd U4 (
	    .bin(out_pos),
	    .ones(ones),
	    .tens(tens),
	    .hundreds(hundreds),
	    .thousands(thousands)
    );


    bin_to_bcd binbcd_channel (
	    .bin(ser_channel),
	    .ones(channel_ones),
	    .tens(channel_tens),
	    .hundreds(channel_hundreds),
	    .thousands(channel_thousands)
    );

    bcd_to_7seg U5 (ones, d0[6:0]);
    bcd_to_7seg U6 (tens, d1[6:0]);
    bcd_to_7seg U7 (hundreds, d2[6:0]);
    bcd_to_7seg U8 (thousands, d3[6:0]);
    
    bcd_to_7seg bcd7seg_channel0 (channel_ones, d4[6:0]);
    bcd_to_7seg bcd7seg_channel1 (channel_tens, d5[6:0]);
    
    led_mux U9 (.clk(clk5KHz), 
        .rst(rst), 
        .LED0({ d5[7], d5[6], d5[5], d5[4], d5[3], d5[2], d5[1], d5[0] }), 
        .LED1({ d4[7], d4[6], d4[5], d4[4], d4[3], d4[2], d4[1], d4[0] }), 
        .LED2(vcc), 
        .LED3(vcc),
        .LED4({ d3[7], d3[6], d3[5], d3[4], d3[3], d3[2], d3[1], d3[0] }), 
        .LED5({ d2[7], d2[6], d2[5], d2[4], d2[3], d2[2], d2[1], d2[0] }), 
        .LED6({ d1[7], d1[6], d1[5], d1[4], d1[3], d1[2], d1[1], d1[0] }), 
        .LED7({ d0[7], d0[6], d0[5], d0[4], d0[3], d0[2], d0[1], d0[0] }), 
        .LEDSEL(LEDOUT), 
        .LEDOUT(LEDSEL)
    );
endmodule

/*
SerialServo Servo1 (
	    .clk100MHz(clk100MHz),
	    .clk1MHz(clk1MHz),
	    .rst(rst),
	    .ext_clk(sclk),
		.ext_flush(flush),
		.serial(serial),
	    .channel(5'h01),
	    .pwm(pwm[1])
	);

	SerialServo Servo2 (
	    .clk100MHz(clk100MHz),
	    .clk1MHz(clk1MHz),
	    .rst(rst),
	    .ext_clk(sclk),
		.ext_flush(flush),
		.serial(serial),
	    .channel(5'h01),
	    .pwm(pwm[2])
	);

	SerialServo Servo3 (
        .clk100MHz(clk100MHz),
        .clk1MHz(clk1MHz),
	    .rst(rst),
	    .ext_clk(sclk),
		.ext_flush(flush),
		.serial(serial),
	    .channel(5'h02),
	    .pwm(pwm[3])
	);

	SerialServo Servo4 (
        .clk100MHz(clk100MHz),
        .clk1MHz(clk1MHz),
	    .rst(rst),
	    .ext_clk(sclk),
		.ext_flush(flush),
		.serial(serial),
	    .channel(5'h03),
	    .pwm(pwm[4])
	);

	SerialServo Servo5 (
        .clk100MHz(clk100MHz),
        .clk1MHz(clk1MHz),
	    .rst(rst),
	    .ext_clk(sclk),
		.ext_flush(flush),
		.serial(serial),
	    .channel(5'h04),
	    .pwm(pwm[5])
	);

	SerialServo Servo6 (
        .clk100MHz(clk100MHz),
        .clk1MHz(clk1MHz),
	    .rst(rst),
	    .ext_clk(sclk),
		.ext_flush(flush),
		.serial(serial),
	    .channel(5'h05),
	    .pwm(pwm[6])
	);

	SerialServo Servo7 (
        .clk100MHz(clk100MHz),
        .clk1MHz(clk1MHz),
	    .rst(rst),
	    .ext_clk(sclk),
		.ext_flush(flush),
		.serial(serial),
	    .channel(5'h06),
	    .pwm(pwm[7])
	);

	SerialServo Servo8 (
        .clk100MHz(clk100MHz),
        .clk1MHz(clk1MHz),
	    .rst(rst),
	    .ext_clk(sclk),
		.ext_flush(flush),
		.serial(serial),
	    .channel(5'h07),
	    .pwm(pwm[8])
	);

	SerialServo Servo9 (
        .clk100MHz(clk100MHz),
        .clk1MHz(clk1MHz),
	    .rst(rst),
	    .ext_clk(sclk),
		.ext_flush(flush),
		.serial(serial),
	    .channel(5'h08),
	    .pwm(pwm[9])
	);

	SerialServo Servo10 (
        .clk100MHz(clk100MHz),
        .clk1MHz(clk1MHz),
	    .rst(rst),
	    .ext_clk(sclk),
		.ext_flush(flush),
		.serial(serial),
	    .channel(5'h09),
	    .pwm(pwm[10])
	);

	SerialServo Servo11 (
        .clk100MHz(clk100MHz),
        .clk1MHz(clk1MHz),
	    .rst(rst),
	    .ext_clk(sclk),
		.ext_flush(flush),
		.serial(serial),
	    .channel(5'h0A),
	    .pwm(pwm[11])
	);

	SerialServo Servo12 (
        .clk100MHz(clk100MHz),
        .clk1MHz(clk1MHz),
	    .rst(rst),
	    .ext_clk(sclk),
		.ext_flush(flush),
		.serial(serial),
	    .channel(5'h0B),
	    .pwm(pwm[12])
	);

	SerialServo Servo13 (
        .clk100MHz(clk100MHz),
        .clk1MHz(clk1MHz),
	    .rst(rst),
	    .ext_clk(sclk),
		.ext_flush(flush),
		.serial(serial),
	    .channel(5'h0C),
	    .pwm(pwm[13])
	);

	SerialServo Servo14 (
        .clk100MHz(clk100MHz),
        .clk1MHz(clk1MHz),
	    .rst(rst),
	    .ext_clk(sclk),
		.ext_flush(flush),
		.serial(serial),
	    .channel(5'h0D),
	    .pwm(pwm[14])
	);
	
	SerialServo Servo15 (
        .clk100MHz(clk100MHz),
        .clk1MHz(clk1MHz),
	    .rst(rst),
	    .ext_clk(sclk),
		.ext_flush(flush),
		.serial(serial),
	    .channel(5'h0E),
	    .pwm(pwm[15])
	);
	
	SerialServo Servo16 (
        .clk100MHz(clk100MHz),
        .clk1MHz(clk1MHz),
	    .rst(rst),
	    .ext_clk(sclk),
		.ext_flush(flush),
		.serial(serial),
	    .channel(5'h0F),
	    .pwm(pwm[16])
	);
*/