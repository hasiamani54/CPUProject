module IF (
input wire clk,
  input wire reset,
  input wire [8:0] iaddr,
  output [23:0] instr);

  reg [23:0] instruction_mem;
  always @(posedge clk) begin
    instr <= 24'b0;
    else begin 
      instr<= instruction_mem[iaddr];
    end 
    endmodule 
