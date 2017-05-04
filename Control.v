/******************************************************************
* Description
*	This is control unit for the MIPS processor. The control unit is 
*	in charge of generation of the control signals. Its only input 
*	corresponds to opcode from the instruction.
*	1.0
* Author:
*	Dr. JosÃ© Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	01/03/2014
******************************************************************/
module Control
(
	input [5:0]OP,
	input [5:0]Function,//JR
	
	output [1:0]RegDst,
	output BranchEQ,
	output BranchNE,
	output MemRead,
	output [1:0]MemtoReg,
	output MemWrite,
	output ALUSrc,
	output RegWrite,
	output [1:0]Jump,
	output [3:0]ALUOp
);
localparam R_Type_AND = 12'b000000_100100;//0,
localparam R_Type_OR = 12'b000000_100101;//0,
localparam R_Type_NOR = 12'b000000_100111;//0,
localparam R_Type_ADD = 12'b000000_100000;//0
localparam R_Type_SLL = 12'b000000_000000;//0,
localparam R_Type_SRL = 12'b000000_000010;//0,
localparam R_Type_SUB = 12'b000000_100010;//0,
localparam R_Type_JR = 12'b000000_001000;//0,8
localparam I_Type_ADDI = 12'b001000_xxxxxx;//8,x
localparam I_Type_ORI = 12'b001101_xxxxxx;//d,x
localparam I_Type_LUI = 12'b001111_xxxxxx;//f,x
localparam I_Type_ANDI= 12'b001100_xxxxxx;//c,x
localparam I_Type_LW  = 12'b100011_xxxxxx;//23,x
localparam I_Type_SW	 = 12'b101011_xxxxxx;//2b,x
localparam BEQ = 12'b000100_xxxxxx;//4,x
localparam BNE = 12'b000101_xxxxxx;//5,x
localparam J = 12'b000010_xxxxxx;//2,x
localparam JAL = 12'b000011_xxxxxx;//3,x

wire [11:0] Selector;
reg [15:0] ControlValues;
assign Selector={OP,Function};

always@(Selector) begin
	casex(Selector)
		R_Type_AND:       ControlValues= 16'b00_01_0_00_1_00_00_0111;
		R_Type_OR:        ControlValues= 16'b00_01_0_00_1_00_00_0111;
		R_Type_NOR:       ControlValues= 16'b00_01_0_00_1_00_00_0111;
		R_Type_ADD:       ControlValues= 16'b00_01_0_00_1_00_00_0111;
		R_Type_SLL:       ControlValues= 16'b00_01_0_00_1_00_00_0111;
		R_Type_SRL:       ControlValues= 16'b00_01_0_00_1_00_00_0111;
		R_Type_SUB:       ControlValues= 16'b00_01_0_00_1_00_00_0111;
		I_Type_LUI:	  ControlValues= 16'b00_00_1_00_1_00_00_0110;
		I_Type_ORI:   ControlValues= 16'b00_00_1_00_1_00_00_0101;
		I_Type_ADDI:  ControlValues= 16'b00_00_1_00_1_00_00_0100;
		I_Type_SW: 	  ControlValues= 16'b00_xx_1_xx_0_01_00_0011;
		I_Type_LW:	  ControlValues= 16'b00_00_1_01_1_10_00_0010;
		I_Type_ANDI:  ControlValues= 16'b00_00_1_00_1_00_00_0001;
		BEQ:  		  ControlValues= 16'b00_00_0_00_0_00_01_1000;
		BNE:			  ControlValues= 16'b00_00_0_00_0_00_10_1001;
		J:				  ControlValues= 16'b01_00_0_00_0_00_00_xxxx;
		JAL:			  ControlValues= 16'b01_10_0_10_1_00_00_xxxx;
		R_Type_JR:	  ControlValues= 16'b10_00_0_00_0_00_00_0111;
		default:
			ControlValues= 16'b0000000000000000;
		endcase
end	


assign Jump = ControlValues[15:14];
assign RegDst = ControlValues[13:12];
assign ALUSrc = ControlValues[11];
assign MemtoReg = ControlValues[10:9];
assign RegWrite = ControlValues[8];
assign MemRead = ControlValues[7];
assign MemWrite = ControlValues[6];
assign BranchNE = ControlValues[5];
assign BranchEQ = ControlValues[4];
assign ALUOp = ControlValues[3:0];	

endmodule


