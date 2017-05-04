module Multiplexer3to1
#(
	parameter NBits=32
)
(
	input [1:0]Selector,
	input [NBits-1:0] MUX_Data0,
	input [NBits-1:0] MUX_Data1,
	input [NBits-1:0] MUX_Data2,
	
	output reg [NBits-1:0] MUX_Output

);
localparam data0 = 2'b00; 
localparam data1 = 2'b01;
localparam data2 = 2'b10;
	always@(Selector,MUX_Data0,MUX_Data1,MUX_Data2) 
	begin
		case(Selector)
			data0:
				MUX_Output = MUX_Data0;
			data1:
				MUX_Output = MUX_Data1;
			data2:
				MUX_Output = MUX_Data2;
		default:
				MUX_Output = 0;
		endcase
	end

endmodule
