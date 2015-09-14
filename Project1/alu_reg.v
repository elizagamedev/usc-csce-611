module alu_reg (input clk, input [31:0] a, b, input[3:0] op, input [4:0] shamt,
                output [31:0] hi, lo, output zero);

    wire [31:0] a_reg, b_reg, hi_comb, lo_comb;
    wire [3:0] op_reg;
    wire [4:0] shamt_reg;
    wire zero_comb;

    regn #(32) input_reg_a(clk, a, a_reg);
    regn #(32) input_reg_b(clk, b, b_reg);
    regn #(4) input_reg_op(clk, op, op_reg);
    regn #(5) input_reg_shamt(clk, shamt, shamt_reg);

    alu my_alu(.a(a_reg), .b(b_reg), .shamt(shamt_reg), .op(op_reg), .hi(hi_comb), .lo(lo_comb), .zero(zero_comb));

    regn #(32) output_reg_hi(clk, hi_comb, hi);
    regn #(32) output_reg_lo(clk, lo_comb, lo);
    regn #(1) output_reg_zero(clk, zero_comb, zero);
endmodule
