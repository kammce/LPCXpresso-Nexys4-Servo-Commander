`timescale 1ns / 1ps
`default_nettype none

// module clk_gen(clk100MHz, rst, clk_4sec, clk_5KHz);
// input clk100MHz, rst; 
// output clk_4sec, clk_5KHz; 
// reg clk_4sec, clk_5KHz; 
// integer count, count1; 
// always@(posedge clk100MHz)
// begin
// 	if(rst) begin
// 		count = 0;   
// 		count1 = 0;
// 		clk_4sec = 0;
// 		clk_5KHz  =0;
// 	end
// 	else begin
// 		if(count == 200000000) begin
// 			clk_4sec = ~clk_4sec;
// 			count = 0;
// 	  	end
// 	  	if(count1 == 10000) begin
// 			clk_5KHz = ~clk_5KHz;
// 			count1 = 0;
// 		end   
// 		count = count + 1;
// 		count1 = count1 + 1;         
// 	end
// end 
// endmodule // end clk_gen


module clk_gen(
    input wire clk100MHz,
    input wire rst,
    output reg clk1MHz,
    output reg clk5KHz,
    output reg clk200Hz
);

integer count;
integer ledmux;
integer highspeed;

always@(posedge clk100MHz or posedge rst)
begin
	if(rst) begin
		count = 0;   
		highspeed = 0;
		ledmux = 0;
		clk1MHz = 0;
		clk5KHz = 0;
		clk200Hz = 0;
	end
	else begin
	  	if(count == 250000) begin //125000 @ 100MHz
			clk200Hz = ~clk200Hz;
			count = 0;
		end
	  	if(ledmux == 5000) begin //10000 @ 1KHz
			clk5KHz = ~clk5KHz;
			ledmux = 0;
		end
	  	if(highspeed == 50) begin //125000 @ 100MHz
			clk1MHz = ~clk1MHz;
			highspeed = 0;
		end
		count = count + 1;
		highspeed = highspeed + 1;
		ledmux = ledmux + 1;  
	end
end 
endmodule // end clk_gen