`timescale 500ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2015 01:48:32 PM
// Design Name: 
// Module Name: pwm_tb
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


module pwm_tb;

reg clk1MHz, rst;
wire pwm; 
//reg clk200Hz;
//reg clk1MHz;
wire clk200Hz;
//wire clk1MHz;
//reg [9:0] pos;
wire [9:0] pos;

clk_gen U0 (
   .clk1MHz(clk1MHz), 
   .rst(rst),
   .clk200Hz(clk200Hz)
);

SweepPosition U1 (
   .pos(pos),
   .clk200Hz(clk200Hz),
   .rst(rst)
);

AngleToPWM U2 (
     .pos(pos),
     .clk1MHz(clk1MHz),
     .rst(rst),
     .pwm(pwm)
);

integer i;
reg success_flag;

initial begin
    success_flag = 1;
    rst = 0;
    #5
    rst = 1;
    #5
    rst = 0;

   for(i = 0; i < 32'd30_000_000; i=i+1) 
   begin
       #1
       clk1MHz = 0;
       #1
       clk1MHz = 1;
   end

    /* Simple Position Testing 
    pos = 0;
    #10
    for(i = 0; i < 32'd100_000; i=i+1) 
    begin
        #1
        clk1MHz = 0;
        #1
        clk1MHz = 1;
    end

    pos = 250;
    #10
    for(i = 0; i < 32'd100_000; i=i+1) 
    begin
        #1
        clk1MHz = 0;
        #1
        clk1MHz = 1;
    end
    pos = 500;
    #10
    for(i = 0; i < 32'd100_000; i=i+1) 
    begin
        #1
        clk1MHz = 0;
        #1
        clk1MHz = 1;
    end
    pos = 750;
    #10
    for(i = 0; i < 32'd100_000; i=i+1) 
    begin
        #1
        clk1MHz = 0;
        #1
        clk1MHz = 1;
    end
    pos = 1000;
    #10
    for(i = 0; i < 32'd100_000; i=i+1) 
    begin
        #1
        clk1MHz = 0;
        #1
        clk1MHz = 1;
    end
    */

    // for(i = 0; i < 32'd2000; i=i+1) 
    // begin
    //     #2
    //     clk200Hz = 0;
    //     #2
    //     clk200Hz = 1;
    // end
    
    // pos = 10'd500;
    // for(i = 0; i < 32'd25_000; i=i+1) 
    // begin
    //     #2
    //     clk1MHz = 0;
    //     #2
    //     clk1MHz = 1;
    // end

    // pos = 10'd100;
    // for(i = 0; i < 32'd25_000; i=i+1) 
    // begin
    //     #2
    //     clk1MHz = 0;
    //     #2
    //     clk1MHz = 1;
    // end

    // pos = 10'd1000;
    // for(i = 0; i < 32'd25_000; i=i+1) 
    // begin
    //     #2
    //     clk1MHz = 0;
    //     #2
    //     clk1MHz = 1;
    // end
    
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