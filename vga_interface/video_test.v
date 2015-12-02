module video_test (input CLOCK_50,
				   output [9:0] VGA_R,
				   output [9:0] VGA_G,
				   output [9:0] VGA_B,
				   output VGA_SYNC,
				   output VGA_BLANK,
				   output VGA_CLK,
				   output VGA_HS,
				   output VGA_VS);
				   
reg [5:0] row;
reg [6:0] col;
wire [24:0] data;

assign data = (col > 7'd30) && (col < 7'd40) && (row > 6'd30) && (row < 6'd40) ? 24'hff00 : 24'd0;

always @(posedge CLOCK_50) begin

	if (col==7'd79) begin
		if (row==6'd59) row <= 6'd0; else row <= row + 6'd1;
		col <= 7'd0;
	end else col <= col + 7'd1;

end

display_if mydisplay (
	 .clk(CLOCK_27),
	 .rst(1'd0),
	 .mem_waddr({row,col}),
	 .mem_wdata(data),
	 .mem_web(1'd1),
	
	 .VGA_R(VGA_R),
	 .VGA_G(VGA_G),
	 .VGA_B(VGA_B),
	 .VGA_SYNC(VGA_SYNC),
	 .VGA_BLANK(VGA_BLANK),
	 .VGA_CLK(VGA_CLK),
	 .VGA_HS(VGA_HS),
	 .VGA_VS(VGA_VS));

endmodule
