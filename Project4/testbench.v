module testbench();
    reg clk;
    reg rst;

    reg [31:0] reg29;
    wire [31:0] reg30;

    cpu cpu(.clk(clk), .rst(rst), .reg29(reg29), .reg30(reg30));

    always begin
        clk = 1; #5; clk = 0; #5;
    end

    initial begin
        reg29 <= 0;
        rst = 1; #5 rst = 0;
    end
endmodule
