module display_if (
	input clk,
	input rst,
	input [12:0] mem_waddr,
	input [23:0] mem_wdata,
	input mem_web,
	
	output [7:0] VGA_R,
	output [7:0] VGA_G,
	output [7:0] VGA_B,
	output VGA_SYNC,
	output VGA_BLANK,
	output VGA_CLK,
	output VGA_HS,
	output VGA_VS);
	
wire iCLK;
wire [9:0] px, py;
wire [7:0] red,green,blue;

Display mydisplay (
	.clka(iCLK),
	.clkb(clk),
	
	.pixel_count(px),
	.line_count(py),
	
	.mem_waddr(mem_waddr),
	.mem_wdata(mem_wdata),
	.mem_web(mem_web),
	
	.red(red),
	.green(green),
	.blue(blue)
	);

VGA_PLL mypll (
	.inclk0(clk),
	.c0(iCLK),
	.c1(VGA_CLK)
	);
	
VGA_Sync mysync (
	.iCLK(iCLK),
	.iRST_N(~rst),
	.iRed(red),
	.iGreen(green),
	.iBlue(blue),
	.px(px),
	.py(py),
	.VGA_R(VGA_R),
	.VGA_G(VGA_G),
	.VGA_B(VGA_B),
	.VGA_H_SYNC(VGA_HS),
	.VGA_V_SYNC(VGA_VS),
	.VGA_SYNC(VGA_SYNC),
	.VGA_BLANK(VGA_BLANK)
	);	
	
endmodule
