module PipelineRegister 
#(
	parameter N=32
) 
(
	input clk,
	input reset,
	input [N-1:0] DataInput,

	output reg [N-1:0] DataOutput
);

always@(negedge reset or negedge clk) begin
	if(reset == 0) 
		DataOutput <= 0;
	else	
		DataOutput <= DataInput;
end

endmodule
