`timescale 1ns / 1ps
module RegisterFile(
    input clk, 
    input rst, 
    input [15:0] iaddr,
    input [23:0] data_in,
    input data_wr,
    output reg [23:0] data_out
);
    reg [23:0] registers [15:0]; 

    integer i;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Clear all registers on reset
            for (i = 0; i < 16; i = i + 1) begin
                registers[i] <= 24'b0;
            end
        end else if (data_wr) begin
            registers[iaddr] <= data_in; 
        end
    end

    always @(*) begin
        data_out = registers[iaddr]; 
    end
endmodule


module RegisterFile_tb;

    // Inputs
    reg clk;
    reg rst;
    reg [15:0] iaddr;
    reg [23:0] data_in;
    reg data_wr;

    // Outputs
    wire [23:0] data_out;

    // Instantiate the Unit Under Test (UUT)
    RegisterFile uut (
        .clk(clk),
        .rst(rst),
        .iaddr(iaddr),
        .data_in(data_in),
        .data_wr(data_wr),
        .data_out(data_out)
    );

    // Clock generation with a shorter period
    always #5 clk = ~clk;  // Clock with a period of 10ns

    // Initialize Inputs and run tests
    initial begin
        // VCD file generation for waveform analysis
        $dumpfile("register_file.vcd");
        $dumpvars(0, RegisterFile_tb);

        // Initialize Inputs
        clk = 0;
        rst = 1;
        iaddr = 0;
        data_in = 0;
        data_wr = 0;

        // Wait 20 ns for global reset to finish
        #20;
        rst = 0;  // Release reset

        // Test 1: Write and read back from register 0
        iaddr = 0;
        data_in = 16'hAAAA;  // Test data
        data_wr = 1;  // Enable write
        #10;
        data_wr = 0;  // Disable write
        #10;

        // Test 2: Quick follow-up with write and read back from register 1
        iaddr = 1;
        data_in = 16'hBBBB;
        data_wr = 1;
        #10;
        data_wr = 0;
        #10;

        // Test 3: Read back from register 0 and 1 without delay
        iaddr = 0;  // Switch back to register 0
        #10;
        iaddr = 1;  // Switch to register 1
        #10;

        // Test 4: Write to register 2 with different data pattern
        iaddr = 2;
        data_in = 16'hCCCC;
        data_wr = 1;
        #10;
        data_wr = 0;
        #10;

        // Test 5: Check rapid successive accesses
        iaddr = 0;
        #5;
        iaddr = 1;
        #5;
        iaddr = 2;
        #5;

        // Test 6: Reset the system and verify zero initialization
        rst = 1;  // Assert reset again
        #10;
        rst = 0;  
        iaddr = 0;  // Read register 0 after reset to verify it's cleared
        #10;
        iaddr = 1;  // Read register 1
        #10;
        iaddr = 2;  // Read register 2
        #10;


        #50;
        $finish;
    end
      
endmodule
