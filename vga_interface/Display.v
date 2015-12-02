module Display
(
  input       clka,
  input       clkb,

  input [9:0] pixel_count,  // V_count
  input [9:0] line_count,   // H_count

  input [12:0] mem_waddr, 
  input [23:0] mem_wdata, 
  input        mem_web, 

  output [7:0] red,
  output [7:0] green,
  output [7:0] blue
);

wire [23:0] mem_rdata;
wire [12:0] mem_raddr;

assign mem_raddr = {line_count[8:3], pixel_count[9:3]};

vmem8192x24 myvmem8192x24 (
   .clka  (clka),
   .addra (mem_raddr),
   .dataa (mem_rdata),
   .clkb  (clkb),
   .addrb (mem_waddr),
   .datab (mem_wdata),
   .web   (mem_web)
   );

assign red   = mem_rdata[23:16];
assign green = mem_rdata[15:8];
assign blue  = mem_rdata[7:0];

endmodule

