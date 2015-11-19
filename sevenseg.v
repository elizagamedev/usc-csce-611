module sevenseg(input [3:0] digit,
                output reg [6:0] segments);
    always @(*) begin
        case (digit)
            4'h0: segments = 7'b1_00_0_00_0;
            4'h1: segments = 7'b1_11_1_00_1;
            4'h2: segments = 7'b0_10_0_10_0;
            4'h3: segments = 7'b0_11_0_00_0;
            4'h4: segments = 7'b0_01_1_00_1;
            4'h5: segments = 7'b0_01_0_01_0;
            4'h6: segments = 7'b0_00_0_01_0;
            4'h7: segments = 7'b1_11_1_00_0;
            4'h8: segments = 7'b0_00_0_00_0;
            4'h9: segments = 7'b0_01_0_00_0;
            4'hA: segments = 7'b0_00_1_00_0;
            4'hB: segments = 7'b0_00_0_01_1;
            4'hC: segments = 7'b1_00_0_11_0;
            4'hD: segments = 7'b0_10_0_00_1;
            4'hE: segments = 7'b0_00_0_11_0;
            4'hF: segments = 7'b0_00_1_11_0;
            default: segments = 7'b1_11_1_11_1;
        endcase
    end
endmodule
