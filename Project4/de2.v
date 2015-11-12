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
           output reg [17:0] LEDR);

    wire [31:0] reg30;

    sevenseg dig0(reg30[3:0], HEX0);
    sevenseg dig1(reg30[7:4], HEX1);
    sevenseg dig2(reg30[11:8], HEX2);
    sevenseg dig3(reg30[15:12], HEX3);
    sevenseg dig4(reg30[19:16], HEX4);
    sevenseg dig5(reg30[23:20], HEX5);
    sevenseg dig6(reg30[27:24], HEX6);
    sevenseg dig7(reg30[31:28], HEX7);

    cpu cpu(.clk(CLOCK_27), .rst(~KEY[0]), .reg29(SW), .reg30(reg30));

    always @(*) begin
        LEDR <= SW;
    end
endmodule
