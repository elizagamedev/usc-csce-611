module testbench();
    reg clk;
    reg [31:0] vectornum, errors; // bookkeeping variables
    reg [143:0] testvectors[10000:0]; // array of testvectors

    reg [31:0] a_0, a_1, a_2, b_0, b_1, b_2;
    reg [4:0] shamt_0, shamt_1;
    reg [7:0] shamt_2;
    reg [3:0] op_0, op_1, op_2;
    wire [31:0] hi, lo;
    wire zero;

    reg [31:0] hi_expected_0, hi_expected_1, hi_expected_2;
    reg [31:0] lo_expected_0, lo_expected_1, lo_expected_2;
    reg zero_expected_0, zero_expected_1;
    reg [3:0] zero_expected_2;

    alu_reg my_alu(clk, a_2, b_2, op_2, shamt_2, hi, lo, zero);

    always begin
        clk=1;#5;clk=0;#5;
    end

    initial begin
        $readmemh("alu.tv", testvectors);
        vectornum = 0; errors = 0;
    end

    always @(posedge clk) begin
        {a_2, b_2, shamt_2, op_2, hi_expected_2, lo_expected_2, zero_expected_2} <= testvectors[vectornum];
        hi_expected_0 <= hi_expected_1; hi_expected_1 <= hi_expected_2;
        lo_expected_0 <= lo_expected_1; lo_expected_1 <= lo_expected_2;
        zero_expected_0 <= zero_expected_1; zero_expected_1 <= zero_expected_2[0];
        a_0 <= a_1; a_1 <= a_2;
        b_0 <= b_1; b_1 <= b_2;
        shamt_0 <= shamt_1; shamt_1 <= shamt_2[4:0];
        op_0 <= op_1; op_1 <= op_2;
    end

    // check results on falling edge of clk
    always @(negedge clk) begin
        if (hi !== hi_expected_0 || lo !== lo_expected_0 || zero !== zero_expected_0) begin
            $display("Error: a = %08x, b = %08x, shamt = %d, op = %x : hi = %08x, lo = %08x, zero = %d : t = %d : entry = %d", a_0, b_0, shamt_0, op_0, hi, lo, zero, $time, ($time - 45) / 10);
            errors = errors + 1;
        end
        vectornum = vectornum + 1;
        if (testvectors[vectornum] === 144'bx) begin
            $display("%d tests completed with %d errors", vectornum, errors);
            $finish;
        end
    end
endmodule
