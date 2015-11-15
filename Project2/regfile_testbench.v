//Lab 2 MIPS register file testbench

module regfile_testbench();

reg clk, reset;
reg [3:0] we;
reg [7:0] readaddr1, readaddr2, writeaddr;
reg [31:0] writedata, reg30_in;
wire [31:0] readdata1, readdata2, reg30_out;
reg [31:0] readdata1E, readdata2E, reg30_outE;
//book keeping variables
reg [31:0] vectornum, error;
//holds the test vectors after they are read from the input file
reg [47*4-1:0] testvectors[10:0];

//instance of register file
regfile32x32 rf (readaddr1[4:0], readaddr2[4:0], writeaddr[4:0],
                        clk, we[0], writedata, reg30_in, readdata1, readdata2, reg30_out);

//generate clk
always begin
    clk = 1; #5; clk = 0; #5;
end

//start of test, load vectors and pulse reset
//the file name of the register file is the only thing that should be changed in this testbench
initial begin
    $readmemh("regfile32x32.tv", testvectors); //readmemh reads hexadecimal
    vectornum = 0;
    error = 0;
    reset = 1;
    #27;
    reset = 0;
end

//apply test vectors on rising edge of clk
always @(posedge clk) begin
    #1;
    //seperate data from the testvectors into individual variables
    {we, readaddr1, readaddr2, writeaddr, writedata, reg30_in, readdata1E, readdata2E, reg30_outE} <= testvectors[vectornum];
    vectornum <= vectornum + 1;
end

//check results on falling edge
always @(negedge clk) begin
    if(~reset) begin
        //terminate when reach end of input
        if (readdata1E === 32'hx) begin
          $display("%d tests completed with %d errors", vectornum-32'd1, error);
        $finish;
      end
        //check the results
        if(readdata1 !== readdata1E || readdata2 !== readdata2E || reg30_out !== reg30_outE) begin
            $display("Error: inputs = %h", {we,readaddr1, readaddr2, writeaddr, writedata, reg30_in});
            $display(" Outputs = %h, %h, %h (%h, %h, %h expected)", readdata1, readdata2, reg30_out, readdata1E, readdata2E, reg30_outE);
            error = error + 1;
        end
    end
end

endmodule
