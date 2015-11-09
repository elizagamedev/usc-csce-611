module execute(input clk,
               input [31:0] instruction_EX);

    wire [31:0] readdata1_EX, readdata2_EX;
    reg regwrite_EX;
    reg [1:0] regsel_EX;
    reg [3:0] op_EX;
    reg [4:0] shamt_EX;
    reg enhilo_EX;

    reg [31:0] r_WB, hi_WB, lo_WB, regdata_WB;
    reg [4:0] regdest_WB;
    reg regwrite_WB;
    output reg [1:0] regsel_WB;

    regfile32x32 regs(.clk(clk),
                      .readaddr1(instruction_EX[25:21]), .readaddr2(instruction_EX[20:16]),
                      .writeaddr(regdest_WB), .we(regwrite_EX), .writedata(regdata_WB),
                      .readdata1(readdata1_EX), .readdata2(readdata2_EX));

    control_unit rtype(.function_code(instruction_EX[5:0]), .alu_shamt(instruction_EX[10:6]),
                       .regwrite_EX(regwrite_EX),
                       .regsel_EX(regsel_EX),
                       .op_EX(op_EX),
                       .shamt_EX(shamt_EX),
                       .enhilo_EX(enhilo_EX));

    alu alu(.op(op_EX), .shamt(shamt_EX), .a(readdata1_EX), .b(readdata2_EX),
            .lo(lo_EX), .hi(hi_EX));

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
