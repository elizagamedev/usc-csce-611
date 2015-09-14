module regn #(parameter width=32) (input clk, input [width-1:0] d,
                                   output reg [width-1:0] q);
    always @(posedge clk)
    begin
        q <= d;
    end
endmodule
