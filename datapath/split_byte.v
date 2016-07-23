`timescale 1ns / 1ps

module split_byte (
	input		[1:0] size_in,
	input			sign,
	input 	  [31:0] addr_in,
	input    [31:0] data_in,
	output	reg [31:0] data_out
);

	always @(*) begin
		case( size_in )
			2'b00: 	// 00 byte		
				case(addr_in[1:0])
					2'b00:
						if(sign == 1)     data_out <= { {24{data_in[7]}}	, data_in[7:0] }; 
						else					data_out <= { 24'h0              , data_in[7:0] }; 
					2'b01:
						if(sign == 1)     data_out <= { {24{data_in[15]}}	, data_in[15:8] }; 
						else					data_out <= { 24'h0        		, data_in[15:8] }; 
					2'b10:
						if(sign == 1)     data_out <= { {24{data_in[23]}}	, data_in[23:16] }; 
						else					data_out <= { 24'h0        		, data_in[23:16] };  
					2'b11:
						if(sign == 1)     data_out <= { {24{data_in[31]}}, data_in[31:24] }; 
						else					data_out <= { 24'h0        	 , data_in[31:24] }; 
				endcase

			2'b01: 	// 01 half
				case(addr_in[1])
					1'b0:
						if(sign == 1)     data_out <= { {16{data_in[15]}}, data_in[15:0] }; 
						else					data_out <= { 16'h0            , data_in[15:0] };
					1'b1:
						if(sign == 1)     data_out <= { {16{data_in[31]}}, data_in[31:16] }; 
						else					data_out <= { 16'h0            , data_in[31:16] };
				endcase
			
			default: // 11 word
				data_out = data_in; // previously is this
		endcase
	end
endmodule