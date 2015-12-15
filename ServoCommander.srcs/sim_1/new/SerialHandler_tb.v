














`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2015 07:58:09 AM
// Design Name: 
// Module Name: SerialServo_tb
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

module SerialHandler_tb;

parameter POSITION_WIDTH = 11;

reg clk;
reg rst;
reg ext_clk;
reg ext_flush;
reg serial;
wire [POSITION_WIDTH-1:0] position_output;

reg [7:0] data_in [1:0];

SerialHandler U0(
    .clk100MHz(clk),
    .rst(rst),
    .ext_clk(ext_clk),
    .ext_flush(ext_flush),
    .serial(serial),
    .ser_pos(position_output)
);

integer i = 0;
integer state = 0;
initial
begin
    ext_clk = 0;
    rst = 1;
    ext_flush = 0;
    serial = 0;
    //serial_register[0] = 16'b0_00000_1111111111;
    data_in[0] = 8'b11111_111;
    data_in[1] = 8'b1111_1111;
    #5 
    ext_flush = 1;
    rst = 0;
    #5
    ext_flush = 0;
    state = 1;
    for(i = 0; i < 7; i=i+1) begin
        #5
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
        #1
        clk = 0;
    end
    
    state = 2;
    for(i = 0; i < 7; i=i+1) begin
        #5
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
        #1
        clk = 0;
    end
    state = 3;
    for(i = 0; i < 7; i=i+1) begin
        #5
        clk = 0;
        ext_clk = 0;
        #1
        clk = 1;
        #1
        clk = 0;
        serial = data_in[1][i]; 
        #5
        ext_clk = 1;
        #1
        clk = 1;
        #1
        clk = 0;
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
