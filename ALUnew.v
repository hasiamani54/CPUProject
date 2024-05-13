
	module ALU (
		input [23:0] operandA,
		input [23:0] operandB,
		input [3:0] opcode,
		output reg [23:0] result);
		always @(*) begin 
			case (opcode) // using the opcodes bits to determine which operation to execute
				4'b0000: operandA + operandB; //add
				4'b0001: operandA - operandB; //sub
				4'b0010: operandA * operandB; //mult
				4'b0011: (operandA ^ operandB); // xor
				4'b0100: (~operandA); //inv
				4'b0101: (operandA & operandB); // and
				4'b0110: (operandA | operandB); //or
