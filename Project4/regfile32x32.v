module regfile32x32(input [4:0] readaddr1, readaddr2, writeaddr,
                    input clk, we,
                    input [31:0] writedata,
                    output reg [31:0] readdata1, readdata2);
    reg [31:0] mem[30:0];

    initial begin
        mem[1-1] <= 11;
        mem[2-1] <= 17;
    end

    always @(posedge clk) begin
        if (we) begin
            if (writeaddr > 0 && writeaddr < 32)
                mem[writeaddr-1] = writedata;
        end
    end

    always @(*) begin
        if (readaddr1 == 0)
            readdata1 <= 32'b0;
        else if (we && readaddr1 == writeaddr)
            readdata1 <= writedata;
        else
            readdata1 <= mem[readaddr1-1];

        if (readaddr2 == 0)
            readdata2 <= 32'b0;
        else if (we && readaddr2 == writeaddr)
            readdata2 <= writedata;
        else
            readdata2 <= mem[readaddr2-1];
    end
endmodule
