module control_rtype(input [5:0] function_code, input [5:0] shamt,
                     output reg regwrite_EX,
                     output reg [1:0] regsel_EX,
                     output reg [3:0] op_EX,
                     output reg [4:0] shamt_EX,
                     output reg enhilo_EX,

                     output reg stall_EX,
                     output reg [9:0] branch_addr_EX, jtype_addr_EX, reg_addr_EX,
                     output reg [1:0] pcsrc_EX);

    always @(*) begin
        if ((function_code == 6’b100000) || (function_code == 6’b100001)) begin // add, addu
            op_EX = 4’b0100;
            shamt_EX = 5’bX;
            enhilo_EX = 1’b0;
            regsel_EX = 2’b00;
            regwrite_EX = 1’b1;
        end else if ((function_code == 6’b100010) || (function_code == 6’b100011)) begin // sub, subu
            op_EX = 4’b0101;
            shamt_EX = 5b’X;
            enhilo_EX = 1’b0;
            regsel_EX = 2’b00;
            regwrite_EX = 1’b1;
        end else if (function_code == 6’b011000) begin // mult (not multu)
            op_EX = 4’b0110;
            shamt_EX = 5b’X;
            enhilo_EX = 1’b1;
            regsel_EX = 2’b00;
            regwrite_EX = 1’b0;
        end

        stall_EX <= 0;
        branch_addr_EX <= 0;
        jtype_addr_EX <= 0;
        reg_addr_EX <= 0;
        pcsrc_EX <= 0;
    end

endmodule
