module testbench();
    reg clk;
    reg rst;

    reg [31:0] reg29;

    cpu cpu(.clk(clk), .rst(rst), .reg29(reg29));

    always begin
        clk = 0; #5; clk = 1; #5;
    end

    initial begin
        reg29 <= 0;
        rst = 1; #2 rst = 0;
    end
endmodule
