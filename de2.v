module de2(input CLOCK_27,
           input [3:0] KEY,
           input [17:0] SW,
           output [6:0] HEX0,
           output [6:0] HEX1,
           output [6:0] HEX2,
           output [6:0] HEX3,
           output [6:0] HEX4,
           output [6:0] HEX5,
           output [6:0] HEX6,
           output [6:0] HEX7,
           output [17:0] LEDR,
           output [9:0] VGA_R,
           output [9:0] VGA_G,
           output [9:0] VGA_B,
           output VGA_SYNC,
           output VGA_BLANK,
           output VGA_CLK,
           output VGA_HS,
           output VGA_VS);

    wire [31:0] reg30;

    wire [12:0] display_waddr;
    wire [23:0] display_wdata;
    wire display_web;

    sevenseg dig0(reg30[3:0], HEX0);
    sevenseg dig1(reg30[7:4], HEX1);
    sevenseg dig2(reg30[11:8], HEX2);
    sevenseg dig3(reg30[15:12], HEX3);
    sevenseg dig4(reg30[19:16], HEX4);
    sevenseg dig5(reg30[23:20], HEX5);
    sevenseg dig6(reg30[27:24], HEX6);
    sevenseg dig7(reg30[31:28], HEX7);

    cpu cpu(.clk(CLOCK_27), .rst(~KEY[0]), .reg29({30'b0, KEY[3:2]}), .reg30(reg30),
            .display_waddr(display_waddr),
            .display_wdata(display_wdata),
            .display_web(display_web));
    display_if mydisplay(
        .clk(CLOCK_27),
        .rst(1'd0),
        .mem_waddr(display_waddr),
        .mem_wdata(display_wdata),
        .mem_web(display_web),

        .VGA_R(VGA_R),
        .VGA_G(VGA_G),
        .VGA_B(VGA_B),
        .VGA_SYNC(VGA_SYNC),
        .VGA_BLANK(VGA_BLANK),
        .VGA_CLK(VGA_CLK),
        .VGA_HS(VGA_HS),
        .VGA_VS(VGA_VS));

    reg [31:0] timer;
    assign LEDR = timer[31:14];
    always @(posedge CLOCK_27) begin
        timer <= timer + 1;
    end
endmodule
