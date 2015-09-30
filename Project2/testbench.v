module testbench();
    reg [31:0] vectornum, errors; // bookkeeping variables
    reg [51:0] testvectors[10000:0]; // array of testvectors

    reg clk;
    reg we;
    reg [4:0] readaddr1 = 0, readaddr2 = 0, writeaddr = 0;
    reg [31:0] writedata = 0, reg30_in;
    wire [31:0] readdata1, readdata2, reg30_out;

    regfile32x32 regfile(clk, we, readaddr1, readaddr2, writeaddr, writedata, reg30_in, readdata1, readdata2, reg30_out);

    reg [3:0] delay = 4'b0;
    reg [3:0] op;
    reg [7:0] address;
    reg [3:0] port;
    reg [31:0] result;

    always begin
        clk=1;#5;clk=0;#5;
    end

    initial begin
        $readmemh("regfile32x32.tv", testvectors);
        vectornum = 0; errors = 0;
    end

    always @(posedge clk) begin
        if (delay == 0) begin
            {delay, op, address, port, writedata} = testvectors[vectornum];

            // write
            we = 1;
            writeaddr = address[4:0];
            reg30_in = writedata;

            // read
            if (port == 0)
                readaddr1 = address[4:0];
            else
                readaddr2 = address[4:0];
        end else begin
            we = 0;
            delay = delay - 1;

            if (delay == 0) begin
                // read result
                if (port == 0)
                    result = readdata1;
                else
                    result = readdata2;

                // verify
                if (op == 0) begin
                    if (result === writedata) begin
                        errors = errors + 1;
                        $display("Error: expected NOT %08x (register %d, port %d)", writedata, address, port);
                    end
                end else begin
                    if (result !== writedata) begin
                        errors = errors + 1;
                        $display("Error: expected %08x, got %08x (register %d, port %d)", writedata, result, address, port);
                    end
                end

                // check for end
                vectornum = vectornum + 1;
                if (testvectors[vectornum] === 52'bx) begin
                    $display("%d tests completed with %d errors", vectornum, errors);
                    $finish;
                end
            end
        end
    end
endmodule
