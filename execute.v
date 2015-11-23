module execute(input clk, input rst,
               input [9:0] PC_FETCH,
               input [31:0] instruction_EX,
               input [31:0] reg29,
               output reg stall_EX,
               output reg [9:0] branch_addr_EX, jtype_addr_EX, reg_addr_EX,
               output reg [1:0] pc_src_EX,
               output [31:0] reg30);

    // generic
    wire [5:0] function_code = instruction_EX[5:0];
    wire [5:0] opcode = instruction_EX[31:26];

    // r-type
    wire [4:0] r_shamt = instruction_EX[10:6];
    wire [4:0] r_readaddr1 = instruction_EX[25:21];
    wire [4:0] r_readaddr2 = instruction_EX[20:16];
    wire [4:0] r_regdest = instruction_EX[15:11];

    // i-type
    wire [4:0] i_rs = instruction_EX[25:21];
    wire [4:0] i_rt = instruction_EX[20:16];
    wire [15:0] i_imm = instruction_EX[15:0];

    // misc
    wire [31:0] readdata1_EX, readdata2_EX;
    wire [31:0] hi_EX, lo_EX;
    wire zero_EX;

    reg [4:0] readaddr1_EX, readaddr2_EX, regdest_EX;
    reg [31:0] a_EX, b_EX;
    reg regwrite_EX;
    reg [1:0] regsel_EX;
    reg [3:0] op_EX;
    reg [4:0] shamt_EX;
    reg enhilo_EX;
    reg memwrite_EX;
    wire [31:0] memdata_EX;

    reg regwrite_WB;
    reg [1:0] regsel_WB;
    reg [4:0] regdest_WB;
    reg [31:0] r_WB, hi_WB, lo_WB, regdata_WB;
    reg [31:0] memdata_WB;

    ram ram(.clk(clk),
            .addr(lo_EX[9:0]), .datain(readdata2_EX), .we(memwrite_EX),
            .dataout(memdata_EX));

    regfile32x32 regs(.clk(clk),
                      .readaddr1(readaddr1_EX), .readaddr2(readaddr2_EX),
                      .readdata1(readdata1_EX), .readdata2(readdata2_EX),
                      .we(regwrite_WB), .writeaddr(regdest_WB), .writedata(regdata_WB),
                      .reg29(reg29), .reg30(reg30));

    alu alu(.op(op_EX), .shamt(shamt_EX), .a(a_EX), .b(b_EX),
            .lo(lo_EX), .hi(hi_EX), .zero(zero_EX));

    always @(*) begin
        enhilo_EX = 1'b0;
        shamt_EX = 5'bX;
        regsel_EX = 2'b00;
        regwrite_EX = 1'b1;
        memwrite_EX = 1'b0;
        pc_src_EX = 2'b00;
        stall_EX = 0;

        if (opcode == 6'b000000) begin
            // r-type
            readaddr1_EX = r_readaddr1;
            readaddr2_EX = r_readaddr2;
            a_EX = readdata1_EX;
            b_EX = readdata2_EX;
            regdest_EX = r_regdest;

            casez (function_code)
            6'b10000?: begin //add, addu
                op_EX = 4'b0100;
            end
            6'b10001?: begin // sub, subu
                op_EX = 4'b0101;
            end
            6'b011000: begin // mult
                op_EX = 4'b0110;
                regwrite_EX = 1'b0;
                enhilo_EX = 1'b1;
            end
            6'b011001: begin // multu
                op_EX = 4'b0111;
                regwrite_EX = 1'b0;
                enhilo_EX = 1'b1;
            end
            6'b100100: begin // and
                op_EX = 4'b0000;
            end
            6'b100101: begin // or
                op_EX = 4'b0001;
            end
            6'b100110: begin // xor
                op_EX = 4'b0011;
            end
            6'b100111: begin // nor
                op_EX = 4'b0010;
            end
            6'b000000: begin // sll
                op_EX = 4'b1000;
                shamt_EX = r_shamt;
            end
            6'b000010: begin // srl
                op_EX = 4'b1001;
                shamt_EX = r_shamt;
            end
            6'b000011: begin // sra
                op_EX = 4'b1010;
                shamt_EX = r_shamt;
            end
            6'b101010: begin // slt
                op_EX = 4'b1100;
            end
            6'b101011: begin // sltu
                op_EX = 4'b1111;
            end
            6'b010000: begin // mfhi
                op_EX = 4'b0000;
                regsel_EX = 1;
            end
            6'b010010: begin // mflo
                op_EX = 4'b0000;
                regsel_EX = 2;
            end
            6'b001000: begin // jr
                regwrite_EX = 0;
                jtype_addr_EX = PC_FETCH + $signed(readdata1_EX);
                pc_src_EX = 2;
                stall_EX = 1;
            end
            endcase
        end else begin
            readaddr1_EX = i_rs;
            a_EX = readdata1_EX;
            regdest_EX = i_rt;

            casez (opcode)
            6'b00100?: begin // addi, addiu
                op_EX = 4'b0100;
                b_EX = { {16{i_imm[15]}}, i_imm };
            end
            6'b001100: begin // andi
                op_EX = 4'b0000;
                b_EX = { 16'b0, i_imm };
            end
            6'b001101: begin // ori
                op_EX = 4'b0001;
                b_EX = { 16'b0, i_imm };
            end
            6'b001110: begin // xori
                op_EX = 4'b0011;
                b_EX = { 16'b0, i_imm };
            end
            6'b001010: begin // slti
                op_EX = 4'b1100;
                b_EX = { {16{i_imm[15]}}, i_imm };
            end
            6'b100011: begin // lw
                op_EX = 4'b0100;
                b_EX = { {16{i_imm[15]}}, i_imm };
                regsel_EX = 3;
            end
            6'b101011: begin // sw
                op_EX = 4'b0100;
                b_EX = { {16{i_imm[15]}}, i_imm };
                readaddr2_EX = i_rt;
                memwrite_EX = 1'b1;
                regwrite_EX = 1'b0;
            end
            6'b001111: begin // lui
                op_EX = 4'b1000;
                b_EX = { 16'b0, i_imm };
                shamt_EX = 16;
            end
            6'b000100: begin // beq
                regwrite_EX = 0;
                readaddr1_EX = i_rs;
                readaddr2_EX = i_rt;
                if (readdata1_EX == readdata2_EX) begin
                    branch_addr_EX = PC_FETCH + $signed(i_imm);
                    pc_src_EX = 1;
                    stall_EX = 1;
                end
            end
            6'b000101: begin // bne
                regwrite_EX = 0;
                readaddr1_EX = i_rs;
                readaddr2_EX = i_rt;
                if (readdata1_EX != readdata2_EX) begin
                    branch_addr_EX = PC_FETCH + $signed(i_imm);
                    pc_src_EX = 1;
                    stall_EX = 1;
                end
            end
            6'b000001: begin // bgez
                regwrite_EX = 0;
                op_EX = 4'b1100;
                readaddr1_EX = i_rs;
                if ($signed(readdata1_EX) >= $signed(0)) begin
                    branch_addr_EX = PC_FETCH + $signed(i_imm);
                    pc_src_EX = 1;
                    stall_EX = 1;
                end
            end
            6'b000010: begin // j
                regwrite_EX = 0;
                jtype_addr_EX = instruction_EX[25:0];
                pc_src_EX = 2;
                stall_EX = 1;
            end
            6'b000011: begin // jal
                jtype_addr_EX = instruction_EX[25:0];
                pc_src_EX = 2;
                regdest_EX = 31;
                op_EX = 4'b0100;
                a_EX = PC_FETCH;
                b_EX = 0;
                stall_EX = 1;
            end
            endcase
        end
    end

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            regwrite_WB <= 0;
            regdest_WB <= 0;
            memdata_WB <= 0;
        end else begin
            regdest_WB <= regdest_EX;
            regwrite_WB <= regwrite_EX;
            regsel_WB <= regsel_EX;
            memdata_WB <= memdata_EX;
            r_WB <= lo_EX;
            if (enhilo_EX) begin
                lo_WB <= lo_EX;
                hi_WB <= hi_EX;
            end
        end
    end

    always @(*) begin
        case (regsel_WB)
        0: regdata_WB <= r_WB;
        1: regdata_WB <= hi_WB;
        2: regdata_WB <= lo_WB;
        3: regdata_WB <= memdata_WB;
        endcase
    end
endmodule
