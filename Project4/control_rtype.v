module control_rtype(input [5:0] function_code, input [4:0] shamt,
                     output reg regwrite_EX,
                     output reg [1:0] regsel_EX,
                     output reg [3:0] op_EX,
                     output reg [4:0] shamt_EX,
                     output reg enhilo_EX);

    always @(*) begin
        if ((function_code == 6'b100000) || (function_code == 6'b100001)) begin // add, addu
            op_EX = 4'b0100;
            shamt_EX = 5'bX;
            enhilo_EX = 1'b0;
            regsel_EX = 2'b00;
            regwrite_EX = 1'b1;
        end else if ((function_code == 6'b100010) || (function_code == 6'b100011)) begin // sub, subu
            op_EX = 4'b0101;
            shamt_EX = 5'bX;
            enhilo_EX = 1'b0;
            regsel_EX = 2'b00;
            regwrite_EX = 1'b1;
        end else if (function_code == 6'b011000) begin // mult (not multu)
            op_EX = 4'b0110;
            shamt_EX = 5'bX;
            enhilo_EX = 1'b1;
            regsel_EX = 2'b00;
            regwrite_EX = 1'b0;
        end
    end

endmodule
