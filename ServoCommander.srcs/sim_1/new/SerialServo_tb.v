`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2015 12:55:13 PM
// Design Name: 
// Module Name: SerialHandler_tb
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

module SerialServo_tb;

parameter CHANNEL_WIDTH = 5;
parameter POSITION_WIDTH = 11;

reg clk;
reg rst;
reg ext_clk;
reg ext_flush;
reg serial;
wire [1:0] pwm;

reg [7:0] data_in [3:0];

SerialServo U0 (
    .clk100MHz(clk),
    .clk1MHz(clk),
    .rst(rst),
    .ext_clk(ext_clk),
    .ext_flush(ext_flush),
    .serial(serial),
    .channel(5'h02),
    .pwm(pwm[0])
);

SerialServo U1 (
    .clk100MHz(clk),
    .clk1MHz(clk),
    .rst(rst),
    .ext_clk(ext_clk),
    .ext_flush(ext_flush),
    .serial(serial),
    .channel(5'h04),
    .pwm(pwm[1])
);

integer i = 0;
integer state = 0;
initial
begin
    ext_clk = 0;
    rst = 1;
    ext_flush = 0;
    serial = 0;
    data_in[0] = 8'b00010_111;
    data_in[1] = 8'b1111_1111;

    data_in[2] = 8'b00100_100;
    data_in[3] = 8'b0000_0000;
    #5
    ext_flush = 1;
    rst = 0;
    #5
    ext_flush = 0;
    
    state = 1;
    for(i = 0; i < 8; i=i+1) begin
        #1
        clk = 0;
        ext_clk = 0;
        #1
        clk = 1;
        #1
        clk = 0;
        serial = data_in[2][7-i]; 
        #5
        ext_clk = 1;
        #1
        clk = 1;
    end
    
    state = 2;
    for(i = 0; i < 8; i=i+1) begin
        #1
        clk = 0;
        ext_clk = 0;
        #1
        clk = 1;
        #1
        clk = 0;
        serial = data_in[3][7-i]; 
        #5
        ext_clk = 1;
        #1
        clk = 1;
    end

    state = 3;
    for(i = 0; i < 8; i=i+1) begin
        #1
        clk = 0;
        ext_clk = 0;
        #1
        clk = 1;
        #1
        clk = 0;
        serial = data_in[0][7-i]; 
        #5
        ext_clk = 1;
        #1
        clk = 1;
    end

    state = 4;
    for(i = 0; i < 8; i=i+1) begin
        #1
        clk = 0;
        ext_clk = 0;
        #1
        clk = 1;
        #1
        clk = 0;
        serial = data_in[1][7-i]; 
        #5
        ext_clk = 1;
        #1
        clk = 1;
    end

    state = 5;
    for(i = 0; i < 8; i=i+1) begin
        #1
        clk = 0;
        ext_clk = 0;
        #1
        clk = 1;
        #1
        clk = 0;
        serial = 1; 
        #5
        ext_clk = 1;
        #1
        clk = 1;
    end
    #5
    ext_flush = 1;
    #5
    ext_flush = 0;
    #50
    #10 $stop;   
    #5 $finish;
end

endmodule
