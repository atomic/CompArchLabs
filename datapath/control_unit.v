`timescale 1ns / 1ps

module control_unit (
	input [5:0] opcode,
	input [5:0] funct,
	input [4:0] rt,

	output reg [5:0] ALU_Ctrl,
   output reg [9:0] signals,
	// RegDest, ALUsrc, RegWrite, MemRead, MemWrite, MemToReg, Branch, Jump, size_in(2'b)
	output reg r_jump, 
		pcn_to_wb,
		jal_ra ,
		lui_rt
);

always @(*) begin
	 r_jump = 0;	// ask jack if this is ok
	 pcn_to_wb = 0;
	 jal_ra = 0;
	 lui_rt = 0;
	 
	 
    case( opcode )
	 
		// I-type Instructions
		6'h23: begin ALU_Ctrl = 6'b100000; signals = 10'b0111010011; end
      6'h2b: begin ALU_Ctrl = 6'b100000; signals = 10'bx1001x0011; end
      6'h8:  begin ALU_Ctrl = 6'b100000; signals = 10'b0110000011; end
		
		// with branch(lab 4)
		6'h20: begin ALU_Ctrl = 6'b100000; signals = 10'b0111010000; end
		6'h21: begin ALU_Ctrl = 6'b100000; signals = 10'b0111010001; end
		6'h28: begin ALU_Ctrl = 6'b100000; signals = 10'bx1001x0000; end
		6'h29: begin ALU_Ctrl = 6'b100000; signals = 10'bx1001x0001; end
		6'h24: begin ALU_Ctrl = 6'b100000; signals = 10'b0111010000; end	// lbu
		6'h25: begin ALU_Ctrl = 6'b100000; signals = 10'b0111010001; end
		6'h4:  begin ALU_Ctrl = 6'b111100; signals = 10'bx0000010xx; end
		6'h5:  begin ALU_Ctrl = 6'b111101; signals = 10'bx0000010xx; end
		6'h1:  begin // bgez, and bltz
				ALU_Ctrl = ( rt == 5'b00000 ? 6'b111000 : 6'b111001 ); 
				signals = 10'bx0000010xx;
		end		
		6'h6:  begin ALU_Ctrl = 6'b111110; signals = 10'bx0000010xx; end
		6'h7:  begin ALU_Ctrl = 6'b111111; signals = 10'bx0000010xx; end
		6'h9:  begin ALU_Ctrl = 6'b100001; signals = 10'b01100000xx; end
		6'hC:  begin ALU_Ctrl = 6'b100100; signals = 10'b01100000xx; end
		6'hD:  begin ALU_Ctrl = 6'b100101; signals = 10'b01100000xx; end
		6'hE:  begin ALU_Ctrl = 6'b100110; signals = 10'b01100000xx; end
		6'hF:  begin // lui
						 ALU_Ctrl = 6'b100000; signals = 10'b0111010011; 
						 lui_rt  = 1;
		end
		
		// J-type
		6'h2:  begin ALU_Ctrl = 6'b111010; signals = 10'b00000001xx; end 	// j
		6'h3:  begin ALU_Ctrl = 6'b111010; signals = 10'b00100001xx; 		// jal
						 jal_ra = 1;
						 pcn_to_wb = 1;
		end

		// signals: RegDest, ALUsrc, RegWrite, MemRead, MemWrite, MemToReg, Branch, Jump, size_in(2'b)
		// Opcode : 0x0, R Type
      default: begin
          case( funct )
            6'h20: begin ALU_Ctrl = 6'b100000; signals = 10'b1010000011; end
            6'h22: begin ALU_Ctrl = 6'b100010; signals = 10'b1010000011; end
            6'h24: begin ALU_Ctrl = 6'b100100; signals = 10'b1010000011; end
            6'h25: begin ALU_Ctrl = 6'b100101; signals = 10'b1010000011; end
            6'h27: begin ALU_Ctrl = 6'b100111; signals = 10'b1010000011; end
            6'h26: begin ALU_Ctrl = 6'b100110; signals = 10'b1010000011; end
				
				// jr, ASK JACK (not sure man)
				// ALU_Ctrl is taken from alu.v table
				6'h8:  begin  ALU_Ctrl = 6'b111011; signals = 10'b00000000xx; r_jump = 1; end // jr
				6'h9:  begin  ALU_Ctrl = 6'b111011; signals = 10'b00100000xx; 
								  r_jump = 1;
								  pcn_to_wb = 1;	// jalr
				end 
				// changed jump = 0 because its R-type
				
				
				
				// with branch(lab 4)
				6'h21: begin ALU_Ctrl = 6'b100001; signals = 10'b10100000xx; end
				6'h23: begin ALU_Ctrl = 6'b100011; signals = 10'b10100000xx; end
				6'h2A: begin ALU_Ctrl = 6'b101000; signals = 10'b10100000xx; end
				6'h2B: begin ALU_Ctrl = 6'b101001; signals = 10'b10100000xx; end
				
				6'h0:  begin ALU_Ctrl = 6'b100000; signals = 10'b00000000xx; end // nop
          endcase
      end
    endcase
end
endmodule
