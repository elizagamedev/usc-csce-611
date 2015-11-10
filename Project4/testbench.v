module testbench();
    reg clk;
    reg rst;

    cpu cpu(clk, rst);

    always begin
        clk = 0; #5; clk = 1; #5;
    end

    initial begin
        rst = 1; #2 rst = 0;
    end
endmodule
