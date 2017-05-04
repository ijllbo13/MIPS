module Concatenation
(   
	input [27:0]  DataInput1,
	input [31:0]  DataInput2,
   output[31:0] DataOutput

);
     assign DataOutput = {DataInput2[31:28], DataInput1[27:0]};

endmodule
