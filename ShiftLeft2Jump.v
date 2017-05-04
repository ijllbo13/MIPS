module ShiftLeft2Jump
(   
	input [25:0]  DataInput,
   output reg [27:0] DataOutput

);
   always @ (DataInput)
     DataOutput = {DataInput[25:0], 1'b0, 1'b0};

endmodule // leftShift2