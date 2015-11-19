module ram(input clk,
           input [9:0] addr, input [31:0] datain, input we,
           output [31:0] dataout);

    reg [31:0] mem[1023:0];

    assign dataout = mem[addr];

    always @(posedge clk) begin
        if (we)
            mem[addr] = datain;
    end
endmodule
