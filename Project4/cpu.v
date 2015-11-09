module cpu(input clk, input rst);

    // inputs
    reg [3:0] pc_src_EX;
    reg stall_EX;

    // outputs
    wire [31:0] instruction_EX;
    wire [9:0] PC_FETCH;

    fetch fetch(.clk(clk), .rst(rst), .stall_EX(stall_EX),
                .branch_addr_EX(instruction_EX[9:0] + PC_FETCH),
                .jtype_addr_EX(instruction_EX[9:0]),
                .reg_addr_EX(10'd1),
                .pc_src_EX(pc_src_EX),
                .instruction_EX(instruction_EX),
                .PC_FETCH(PC_FETCH));
    execute execute(clk, instruction_EX);
endmodule
