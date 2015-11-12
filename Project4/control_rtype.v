module control_rtype(input [5:0] function_code, input [4:0] shamt,
                     output reg regwrite_EX,
                     output reg [1:0] regsel_EX,
                     output reg [3:0] op_EX,
                     output reg [4:0] shamt_EX,
                     output reg enhilo_EX);

    always @(*) begin
        enhilo_EX = 1'b0;
        shamt_EX = 5'bX;
        regsel_EX = 2'b00;
        regwrite_EX = 1'b1;

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
            shamt_EX = shamt;
        end
        6'b000010: begin // srl
            op_EX = 4'b1001;
            shamt_EX = shamt;
        end
        6'b000011: begin // sra
            op_EX = 4'b1010;
            shamt_EX = shamt;
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
        endcase
    end

endmodule
