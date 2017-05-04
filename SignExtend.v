/******************************************************************
* Description
*	This module performes a sign-extend operation that is need with
*	in instruction like andi or ben.
* Version:
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	01/03/2014
******************************************************************/
module SignExtend
(   
	input [15:0]  DataInput,
   output reg[31:0] SignExtendOutput
);

always@(DataInput)
	begin
	if(DataInput[15:12] == 4'b1111)
		SignExtendOutput <= {16'b1111111111111111,DataInput[15:0]};
	else
		SignExtendOutput <= {16'b0,DataInput[15:0]};
	end
//assign  SignExtendOutput = {16'b0,DataInput[15:0]};

endmodule // signExtend
