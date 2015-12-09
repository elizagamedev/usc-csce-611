module ram(input clk,
           input [15:0] addr, input [31:0] datain, input we,
           output [31:0] dataout,
           output reg [12:0] display_waddr,
           output reg [23:0] display_wdata,
           output reg display_web);

    reg [31:0] mem[1023:0];

    assign dataout = mem[addr];

    always @(posedge clk) begin
        if (we) begin
            if (addr >= 16'hC000 && addr <= 16'hF000) begin
                display_waddr <= addr - 16'hC000;
                display_wdata <= datain[23:0];
                display_web <= 1'b1;
            end else begin
                mem[addr] = datain;
                display_web <= 1'b0;
            end
        end else begin
            display_web <= 1'b0;
        end
    end
endmodule
