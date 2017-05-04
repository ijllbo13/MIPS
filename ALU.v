/******************************************************************
* Description
*	This is an 32-bit arithetic logic unit that can execute the next set of operations:
*		add
*		sub
*		or
*		and
*		nor
*		sll
*		srl
* This ALU is written by using behavioral description.
* Version:
*	1.0
* Author:
*	Dr. JosÃ© Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	01/03/2014
******************************************************************/

module ALU 
(
	input [3:0] ALUOperation,
	input [4:0] Shamt,
	input [31:0] A,
	input [31:0] B,
	output reg Zero,
	output reg [31:0]ALUResult
	//output reg JReg/////////
);
localparam AND = 4'b0000;
localparam OR  = 4'b0001;
localparam NOR = 4'b0010;
localparam ADD = 4'b0011;
//localparam ADDI= 4'b0011;
localparam LUI = 4'b0101;
localparam SLL = 4'b0110;
localparam SRL = 4'b0111;
localparam SUB = 4'b1000;
//localparam ANDI= 4'b0000;
//localparam ORI = 4'b0001;
localparam LW  = 4'b0011;
localparam SW	= 4'b0011;
//localparam BEQ = 4'b1000;
//localparam BNE = 4'b1000;
//localparam JAL = 4'b0100;
//localparam JR  = 4'b1001;

   always @ (A or B or ALUOperation)
     begin
		case (ALUOperation)
		  ADD: // add
			ALUResult=A + B;
		  //ADDI: //addi 
			//ALUResult=A + B;//{16'b0,B[15:0]};
		  SUB: // sub
			ALUResult=A - B;
		  AND: // and
			ALUResult= A & B;
		  //ANDI: // andi 
			//ALUResult= A & B;//{16'b0,B[15:0]};
		  OR: // or
			ALUResult= A | B;
		  //ORI: //ori
			//ALUResult= A | B;//{16'b0,B[15:0]};
		  NOR: // or
			ALUResult= ~(A|B);
		  SLL: // sll
			ALUResult= B<<Shamt;
		  SRL: // srl
			ALUResult= B>>Shamt;
		  LUI: // lui
			ALUResult= {B[15:0],16'b0};
		  //JAL: //jal
			//ALUResult= B;
		  //JR: 
		   //ALUResult=B;
		  //JR: //jr
			//ALUResult= 
		  //LW:  //lw
			//ALUResult= A + B;
		  //SW:	//sw
			//ALUResult= A + B;
		  //BEQ: // beq
			//ALUResult= A - B;
		  //BNE: // bne
			//ALUResult= A - B;
		default:
			ALUResult= 0;
		endcase // case(control)
		Zero = (ALUResult==0) ? 1'b1 : 1'b0;
     end 
endmodule // ALU