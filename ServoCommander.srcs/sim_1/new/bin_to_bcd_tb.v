`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2015 11:20:11 PM
// Design Name: 
// Module Name: bin_to_bcd_tb
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


module bin_to_bcd_tb;

reg [10:0] bin;
wire [3:0] ones;
wire [3:0] tens;
wire [3:0] hundreds;
wire [3:0] thousands;

bin_to_bcd U0(
    .bin(bin),
    .ones(ones),
    .tens(tens),
    .hundreds(hundreds),
    .thousands(thousands)
);

integer i;
reg success_flag;

initial begin
    #10
	bin = 0;
	#10
	bin = 321;
	#10
	bin = 2020;
	#10
	bin = 1234;
	#10
	// Print out Success/Failure message
	if (success_flag == 0) begin
		$display("*FAILED** TEST!");
	end 
	else begin
		$display("**PASSED** TEST!");
	end
            #10 $stop;   
            #5 $finish;
end

endmodule