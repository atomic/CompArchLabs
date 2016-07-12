`timescale 1ns / 1ps

module control_unit (
	input [5:0] opcode,
	input [5:0] funct,

	output reg [5:0] ALU_Ctrl,
    output reg [6:0] signals
);

always @(*) begin
    case( opcode )
      6'h23: begin ALU_Ctrl = 6'b100000; signals = 7'b0111010; end
      6'h2b: begin ALU_Ctrl = 6'b100000; signals = 7'bx1001x0; end
      6'h8:  begin ALU_Ctrl = 6'b100000; signals = 7'b0110000; end
      default: begin
          case( funct )
            6'h20: begin ALU_Ctrl = 6'b100000; signals = 7'b1010000; end
            6'h22: begin ALU_Ctrl = 6'b100010; signals = 7'b1010000; end
            6'h24: begin ALU_Ctrl = 6'b100100; signals = 7'b1010000; end
            6'h25: begin ALU_Ctrl = 6'b100101; signals = 7'b1010000; end
            6'h27: begin ALU_Ctrl = 6'b100111; signals = 7'b1010000; end
            6'h26: begin ALU_Ctrl = 6'b100110; signals = 7'b1010000; end
          endcase
      end
    endcase
end
endmodule
