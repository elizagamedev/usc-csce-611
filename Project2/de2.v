module de2(input CLOCK_50,
           output reg [6:0] HEX0,
           output reg [6:0] HEX1,
           output reg [6:0] HEX2,
           output reg [6:0] HEX3,
           output reg [6:0] HEX4,
           output reg [6:0] HEX5,
           output reg [6:0] HEX6,
           output reg [6:0] HEX7,
           output reg [17:0] LEDR);
    reg [25:0] clk_div;

    sevenseg dig0(0, HEX0);
    sevenseg dig1(1, HEX1);
    sevenseg dig2(2, HEX2);
    sevenseg dig3(3, HEX3);
    sevenseg dig4(4, HEX4);
    sevenseg dig5(5, HEX5);
    sevenseg dig6(6, HEX6);
    sevenseg dig7(7, HEX7);

    initial begin
        LEDR <= 0;
        clk_div <= 0;
    end
    always @(posedge clk_div[22]) begin
        LEDR <= LEDR + 18'b1;
    end
    always @(posedge CLOCK_50) begin
        // divide 50 MHz clock by 2^26 (64 million)
        clk_div <= clk_div + 26'b1;
    end
endmodule
