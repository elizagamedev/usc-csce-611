module fetch(input clk, rst, stall_EX,
             input [9:0] branch_addr_EX, jtype_addr_EX, reg_addr_EX,
             input [1:0] pc_src_EX,
             output reg [31:0] instruction_EX,
             output reg [9:0] PC_FETCH);
    // instruction memory
    reg [31:0] mem [1023:0];
    initial begin
        $readmemh("hexcode.txt", mem, 0, 1023);
    end
    
    reg [9:0] PC;
    
    always @(posedge rst) begin
        PC <= 0;
    end
    
    always @(posedge clk) begin
        if (stall_EX || rst) begin
            instruction_EX = 32'b0;
        end else begin
            // send the new instruction
            instruction_EX = mem[PC];
        end

        // set the new PC
        case (pc_src_EX)
        0: PC = PC + 1;
        1: PC = branch_addr_EX;
        2: PC = jtype_addr_EX; //TODO: ask dr bakos
        3: PC = reg_addr_EX; //TODO: as above
        endcase
        PC_FETCH = PC;
    end
endmodule
