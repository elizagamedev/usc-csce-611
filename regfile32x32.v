module regfile32x32(input clk, we,
                    input [4:0] readaddr1, readaddr2, writeaddr,
                    input [31:0] writedata,
                    input [31:0] reg29,
                    output reg [31:0] readdata1, readdata2,
                    output [31:0] reg30);

    reg [31:0] mem[30:0];
    assign reg30 = mem[30-1];

    always @(posedge clk) begin
        if (we) begin
            if (writeaddr != 0)
                mem[writeaddr-1] = writedata;
        end
    end

    always @(*) begin
        if (readaddr1 == 0)
            readdata1 <= 32'b0;
        else if (readaddr1 == 29)
            readdata1 <= reg29;
        else if (we && readaddr1 == writeaddr)
            readdata1 <= writedata;
        else
            readdata1 <= mem[readaddr1-1];

        if (readaddr2 == 0)
            readdata2 <= 32'b0;
        else if (readaddr2 == 29)
            readdata2 <= reg29;
        else if (we && readaddr2 == writeaddr)
            readdata2 <= writedata;
        else
            readdata2 <= mem[readaddr2-1];
    end
endmodule
