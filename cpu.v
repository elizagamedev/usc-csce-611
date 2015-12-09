module cpu(input clk, input rst,
           input [31:0] reg29,
           output [31:0] reg30,
           output [12:0] display_waddr,
           output [23:0] display_wdata,
           output display_web);

    // fetch inputs
    wire [9:0] PC_FETCH;

    // execute inputs
    wire [31:0] instruction_EX;

    // execute outputs
    wire stall_EX;
    wire [9:0] branch_addr_EX, jtype_addr_EX, reg_addr_EX;
    wire [1:0] pc_src_EX;

    fetch fetch(.clk(clk), .rst(rst), .stall_EX(stall_EX),
                .branch_addr_EX(branch_addr_EX),
                .jtype_addr_EX(jtype_addr_EX),
                .reg_addr_EX(reg_addr_EX),
                .pc_src_EX(pc_src_EX),
                .instruction_EX(instruction_EX),
                .PC_FETCH(PC_FETCH));
    execute execute(.clk(clk), .rst(rst),
                    .PC_FETCH(PC_FETCH),
                    .instruction_EX(instruction_EX),
                    .stall_EX(stall_EX),
                    .branch_addr_EX(branch_addr_EX),
                    .jtype_addr_EX(jtype_addr_EX),
                    .reg_addr_EX(reg_addr_EX),
                    .pc_src_EX(pc_src_EX),
                    .reg29(reg29), .reg30(reg30),
                    .display_waddr(display_waddr),
                    .display_wdata(display_wdata),
                    .display_web(display_web));
endmodule
