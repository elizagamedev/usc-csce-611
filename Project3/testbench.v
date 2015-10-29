module testbench();
    reg [31:0] vectornum, errors; // bookkeeping variables
    reg [51:0] testvectors[10000:0]; // array of testvectors

    reg clk;
    reg rst;

    // inputs
    reg [3:0] pc_src_EX;
    reg [3:0] stall_EX;

    // outputs
    wire [31:0] instruction_EX;
    wire [9:0] PC_FETCH;

    // expected
    reg [31:0] instruction_EX_expect;
    reg [11:0] PC_FETCH_expect;

    fetch fe(clk, rst, stall_EX[0], instruction_EX[9:0] + PC_FETCH, instruction_EX[9:0], 10'd1, pc_src_EX[1:0], instruction_EX, PC_FETCH);

    always begin
        clk = 0; #5; clk = 1; #5;
    end

    initial begin
        $readmemh("fetch.tv", testvectors);
        vectornum = 0; errors = 0;
        rst = 1; #2 rst = 0;
    end

    always @(negedge clk) begin
        {PC_FETCH_expect, instruction_EX_expect, pc_src_EX, stall_EX} = testvectors[vectornum];

        if (instruction_EX_expect[9:0] != instruction_EX && PC_FETCH_expect[9:0] != PC_FETCH) begin
            $display("error: vector %d (expected instruction %08x, PC_FETCH %03x; got instruction %08x, PC_FETCH %03x)", vectornum, instruction_EX_expect, PC_FETCH_expect, instruction_EX, PC_FETCH);
        end

        // check for end
        vectornum = vectornum + 1;
        if (testvectors[vectornum] === 52'bx) begin
            $display("%d tests completed with %d errors", vectornum, errors);
            $finish;
        end
    end
endmodule
