module vmem8192x24 (
	input clka,clkb,web,
	input [12:0] addra,addrb,
	input [14:0] datab,
	output reg [23:0] dataa
	);
	
reg [23:0] mem[8191:0];

always @(posedge clka) dataa <= mem[addra];

always @(posedge clkb) if (web) mem[addrb] <= datab;

endmodule
