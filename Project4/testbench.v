module testbench();
    reg clk;
    reg rst;

    cpu cpu(clk, rest)

    always begin
        clk = 0; #5; clk = 1; #5;
    end
endmodule
