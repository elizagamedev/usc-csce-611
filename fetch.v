module fetch(input clk, rst, stall_EX,
             input [9:0] branch_addr_EX, jtype_addr_EX, reg_addr_EX,
             input [1:0] pc_src_EX,
             output reg [31:0] instruction_EX,
             output reg [9:0] PC_FETCH);
    // instruction memory
    reg [31:0] mem [1023:0];
    initial $readmemh("test_program6.txt", mem, 0, 1023);

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            instruction_EX <= 32'b0;
            PC_FETCH <= 9'b0;
        end else begin
            if (stall_EX)
                instruction_EX <= 32'b0;
            else
                instruction_EX <= mem[PC_FETCH];

            // set the new PC
            case (pc_src_EX)
            0: PC_FETCH <= PC_FETCH + 1;
            1: PC_FETCH <= branch_addr_EX;
            2: PC_FETCH <= jtype_addr_EX;
            3: PC_FETCH <= reg_addr_EX;
            endcase
        end
    end
endmodule
