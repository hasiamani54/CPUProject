module Instru_Decode( 
  input wire [23:0] instr,
  output [15:0] cmd,
  output [23:0] ra,
  output [23:0] rb,
  output [23:0] d);
  always @(*) begin
    cmd = instr[23:20];
    dst= {16'b0, instru[19:12]};
    ra= (16'b0, instr[11:4]};
         rb= {16'b0, instr[3:0]};
         end 
         endmodule 
