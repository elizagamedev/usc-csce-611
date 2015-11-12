module execute(input clk,
               input [31:0] instruction_EX,
               input [31:0] reg29,
               output reg stall_EX,
               output reg [9:0] branch_addr_EX, jtype_addr_EX, reg_addr_EX,
               output reg [1:0] pc_src_EX,
               output [31:0] reg30);

    wire [31:0] readdata1_EX, readdata2_EX;
    wire regwrite_EX;
    wire [1:0] regsel_EX;
    wire [3:0] op_EX;
    wire [4:0] shamt_EX;
    wire enhilo_EX;
    wire [31:0] hi_EX, lo_EX;

    reg [31:0] r_WB, hi_WB, lo_WB, regdata_WB;
    reg [4:0] regdest_WB;
    reg regwrite_WB;
    reg [1:0] regsel_WB;

    regfile32x32 regs(.clk(clk),
                      .readaddr1(instruction_EX[25:21]), .readaddr2(instruction_EX[20:16]),
                      .readdata1(readdata1_EX), .readdata2(readdata2_EX),
                      .we(regwrite_WB), .writeaddr(regdest_WB), .writedata(regdata_WB),
                      .reg29(reg29), .reg30(reg30));

    control_rtype rtype(.function_code(instruction_EX[5:0]), .shamt(instruction_EX[10:6]),
                        .regwrite_EX(regwrite_EX),
                        .regsel_EX(regsel_EX),
                        .op_EX(op_EX),
                        .shamt_EX(shamt_EX),
                        .enhilo_EX(enhilo_EX));

    alu alu(.op(op_EX), .shamt(shamt_EX), .a(readdata1_EX), .b(readdata2_EX),
            .lo(lo_EX), .hi(hi_EX));

    initial begin
        stall_EX <= 0;
        branch_addr_EX <= 10'bX;
        jtype_addr_EX <= 10'bX;
        reg_addr_EX <= 10'bX;
        pc_src_EX <= 0;
    end

    always @(posedge clk) begin
        regsel_WB = regsel_EX;
        r_WB = lo_EX;
        if (enhilo_EX) begin
            lo_WB = lo_EX;
            hi_WB = hi_EX;
        end
        // Pass the right data
        case (regsel_WB)
        0: regdata_WB = r_WB;
        1: regdata_WB = hi_WB;
        2: regdata_WB = lo_WB;
        endcase
        regwrite_WB = regwrite_EX;
        regdest_WB = instruction_EX[15:11];
    end

endmodule
