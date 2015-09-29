module regfile32x32(input clk, we,
                    input [4:0] readaddr1, readaddr2, writeaddr,
                    input [31:0] writedata,// reg30,
                    output reg [31:0] readdata1, readdata2;
    reg [31:0] registers [30:0];

    always @(posedge clk) begin
        if (readaddr1 == 0)
            readdata1 = 32'b0;
        else
            readdata1 = registers[readaddr1-1];
        if (readaddr2 == 0)
            readdata2 = 32'b0;
        else
            readdata2 = registers[readaddr2-1];
        if (we) begin
            if (writeaddr > 0 && writeaddr < 32) begin
                registers[writeaddr-1] = writedata;
                if (readaddr1 == writeaddr)
                    readdata1 = writedata;
                if (readaddr2 == writeaddr)
                    readdata2 = writedata;
            end
        end
        //registers[30] = reg30;
    end
endmodule
