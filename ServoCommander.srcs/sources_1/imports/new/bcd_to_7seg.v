module bcd_to_7seg(BCD, pattern);
output reg [6:0] pattern; 
input wire [3:0] BCD; 
always @ (BCD) 
begin // BCD to 7-segment decoding 
case (BCD) // s0 - s6 are active low
	4'b0000: pattern = 7'b000_1000;
	4'b0001: pattern = 7'b110_1101;
	4'b0010: pattern = 7'b010_0010;
	4'b0011: pattern = 7'b010_0100;
	4'b0100: pattern = 7'b100_0101;
	4'b0101: pattern = 7'b001_0100;
	4'b0110: pattern = 7'b001_0000;
	4'b0111: pattern = 7'b010_1101;
	4'b1000: pattern = 7'b000_0000;
	4'b1001: pattern = 7'b000_0100;
	default: pattern = 7'b111_1111;
endcase
end
endmodule 