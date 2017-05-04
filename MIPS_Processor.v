////PIPELINE PROCESSOR /////

/**********************************TOP LEVEL*************************/
module MIPS_Processor
#(
	parameter MEMORY_DEPTH = 128, //512
	parameter DATA_WIDTH = 32//16
)

(
	// Inputs
	input clk,
	input reset,
	input [7:0] PortIn,
	// Output
	output [31:0] ALUResultOut,
	output [31:0] PortOut
);
//******************************************************************/
assign  PortOut = 0;
//******************************************************************/
// Data types to connect modules
wire MUX_BranchEQ_wire;
wire MUX_BranchNE_wire; 
wire [31:0] MUX_PC_wire;
wire [31:0] PC_wire;
wire [31:0] ReadData2OrInmmediate_wire;
wire [31:0] PC_4_wire;
wire [31:0] InmmediateExtendAnded_wire;
wire [31:0] PCtoBranch_wire;



// Wires for registers
wire [31:0] Instruction_wire_IF; 
wire [31:0] Instruction_wire_ID; 
wire [31:0] Instruction_wire_EX;
wire [31:0] ALUResult_wire_M;


///////////////////////// PIPELINE IF-ID//////////////////////////////////
wire [31:0] PC_Branch_wire_IF;
wire [31:0] PC_Branch_wire_ID;
//



//////////////////////// PIPELINE ID-EX/////////////////////////////
wire [31:0] ReadData1_wire_ID;
wire [31:0] ReadData2_wire_ID;
wire [31:0] InmmediateExtend_wire_ID;
//wire [31:0] PC_Branch_wire_ID;
wire [31:0] Conca_wire_ID;
//


//////////////////////// CONTROL ID //////////////////////////////////

wire [1:0] RegDst_wire_ID; //EX
wire BranchNE_wire_ID;		//M
wire BranchEQ_wire_ID;		//M
wire [3:0] ALUOp_wire_ID;	//EX
wire ALUSrc_wire_ID;			//EX
wire RegWrite_wire_ID;		//WB
wire MemRead_wire_ID;		//M
wire [1:0] MemtoReg_wire_ID;//WB
wire MemWrite_wire_ID;		//M
wire [1:0] J_wire_ID;		//M
//


///////////////////////// CONTROL EX////
wire [1:0] RegDst_wire_EX;	//EX
wire BranchNE_wire_EX;		//M
wire BranchEQ_wire_EX;		//M
wire [3:0] ALUOp_wire_EX;	//EX
wire ALUSrc_wire_EX;			//EX
wire RegWrite_wire_EX;		//WB
wire MemRead_wire_EX;		//M
wire [1:0] MemtoReg_wire_EX;//WB
wire MemWrite_wire_EX;		//M
wire [1:0] J_wire_EX;		//M
//


////////////////////////////////PIPE EX-M/////////////////////////////
wire [31:0] MUX_AddALU_EX;
wire Zero_wire_EX;
wire [31:0] ALUResult_wire_EX;
wire [4:0]WriteRegister_wire_EX;

wire [31:0]PC_Branch_wire_M;
wire [31:0]MUX_AddALU_M;
wire BranchNE_wire_M;
wire BranchEQ_wire_M;
wire RegWrite_wire_M;
wire MemRead_wire_M;
wire [1:0]MemtoReg_wire_M;
wire MemWrite_wire_M;
wire [1:0]J_wire_M;
wire [31:0]Conca_wire_M;
wire [31:0]ReadData1_wire_M;
wire [31:0]ReadData2_wire_M;
wire Zero_wire_M;
wire [4:0]WriteRegister_wire_M;
//

//////////////////////////////// PIPE M-WB//////////////////////////
wire [31:0] ReadDataMUX_wire_M;
wire [31:0]PC_Branch_wire_WB;
wire [31:0] ReadDataMUX_wire_WB;
wire [1:0]MemtoReg_wire_WB;
wire RegWrite_wire_WB;
wire [31:0]ALUResult_wire_WB;
wire [4:0]WriteRegister_wire_WB;
//



wire [31:0] ReadData1_wire_EX;
wire [31:0] ReadData2_wire_EX;
wire [31:0] InmmediateExtend_wire_EX;
//wire [20:16] Instruction_wire_EX;
//wire [15:11] Instruction_wire_EX;
//wire [10:6]	Instruction_wire_ID;
//wire [5:0] Instruction_wire_EX;
wire [31:0] PC_Branch_wire_EX;
wire [31:0] Conca_wire_EX;



wire [31:0]	WriteData_wire;
wire [31:0] Shift2_wire;
wire [31:0] BranchesEQ_wire;
wire [31:0] BranchesNE_wire;
wire [27:0] Jump_wire;
wire [31:0] MUX_Branches_wire;



//******************************************************************/
//******************************************************************/

/**********************************CONTROL UNIT *************************/
Control
ControlUnit
(
	.OP(Instruction_wire_ID[31:26]),
	.Function(Instruction_wire_ID[5:0]),//Segundo comparador para JR
	.RegDst(RegDst_wire_ID),
	.BranchNE(BranchNE_wire_ID),
	.BranchEQ(BranchEQ_wire_ID),
	.ALUOp(ALUOp_wire_ID),
	.ALUSrc(ALUSrc_wire_ID),
	.RegWrite(RegWrite_wire_ID),
	.MemRead(MemRead_wire_ID),
	.MemtoReg(MemtoReg_wire_ID),
	.MemWrite(MemWrite_wire_ID),
	.Jump(J_wire_ID)
);

/**********************************PROGRAM COUNTER*************************/
PC_Register
ProgramCounter
(
	.clk(clk),
	.reset(reset),
	.NewPC(PC_4_wire),
	.PCValue(PC_wire)
);

/**********************************ROM************************************/
ProgramMemory
#(
	.MEMORY_DEPTH(MEMORY_DEPTH)
)
ROMProgramMemory
(
	.Address(PC_wire),
	.Instruction(Instruction_wire_IF)
);

/**********************************PC+4********************************/
Adder32bits
PC_Puls_4
(
	.Data0(PC_wire),
	.Data1(4),
	.Result(PC_Branch_wire_IF)
);

/**********************************MUX For R & I*****************************/
Multiplexer3to1
#(
	.NBits(5)
)
MUX_ForRTypeAndIType
(
	.Selector(RegDst_wire_EX),
	.MUX_Data0(Instruction_wire_EX[20:16]),
	.MUX_Data1(Instruction_wire_EX[15:11]),
	.MUX_Data2(5'b11111),
	
	.MUX_Output(WriteRegister_wire_EX)

);


/**********************************Register File*************************/
RegisterFile
Register_File
(
	.clk(clk),
	.reset(reset),
	.RegWrite(RegWrite_wire_WB),
	.WriteRegister(WriteRegister_wire_WB),
	.ReadRegister1(Instruction_wire_ID[25:21]),
	.ReadRegister2(Instruction_wire_ID[20:16]),
	.WriteData(WriteData_wire),
	.ReadData1(ReadData1_wire_ID),
	.ReadData2(ReadData2_wire_ID)

);

/**********************************Sign Extend*************************/
SignExtend
SignExtendForConstants
(   
	.DataInput(Instruction_wire_ID[15:0]),
   .SignExtendOutput(InmmediateExtend_wire_ID)
);


/*************************MUX for Read Data/Inmediate*************************/
Multiplexer2to1
#(
	.NBits(32)
)
MUX_ForReadDataAndInmediate
(
	.Selector(ALUSrc_wire_EX),
	.MUX_Data0(ReadData2_wire_EX),
	.MUX_Data1(InmmediateExtend_wire_EX),
	
	.MUX_Output(ReadData2OrInmmediate_wire)

);

/**********************************ALU CONTROL*************************/
ALUControl
ArithmeticLogicUnitControl
(
	.ALUOp(ALUOp_wire_EX),
	.ALUFunction(Instruction_wire_EX[5:0]),
	.ALUOperation(ALUOperation_wire)

);



/**********************************ALU*******************************/
ALU
ArithmeticLogicUnit 
(
	.ALUOperation(ALUOperation_wire),
	.Shamt(Instruction_wire_EX[10:6]),
	.A(ReadData1_wire_EX),
	.B(ReadData2OrInmmediate_wire),
	.Zero(Zero_wire_EX),
	.ALUResult(ALUResult_wire_EX)
);

assign ALUResultOut = ALUResult_wire_EX;

/**********************************RAM*****************************/
DataMemory
#(	.MEMORY_DEPTH(1024),
	.DATA_WIDTH(DATA_WIDTH)
)
RAMProgramMemory
(
	.Address({20'b0,ALUResult_wire_M[11:0]>>2}),
	.WriteData(ReadData2_wire_M),
	.MemWrite(MemWrite_wire_M),
	.MemRead(MemRead_wire_M),
	.ReadData(ReadDataMUX_wire_M),
	.clk(clk)
);

/**********************************MUX MEMORY*************************/
Multiplexer3to1

#(
	.NBits(32)
)
MUX_Memory
(
	.Selector(MemtoReg_wire_WB),
	.MUX_Data0(ALUResult_wire_WB),
	.MUX_Data1(ReadDataMUX_wire_WB),
	.MUX_Data2(PC_Branch_wire_WB),
	
	.MUX_Output(WriteData_wire)
);

/**********************************AND BEQ*************************/
ANDGate
ANDEq
(
	.A(BranchEQ_wire_M),
	.B(Zero_wire_M),
	.C(MUX_BranchEQ_wire)
);


/**********************************MUX BEQ*************************/
Multiplexer2to1
#(
	.NBits(32)
)
MUX_BranchEQ
(
	.Selector(MUX_BranchEQ_wire),
	.MUX_Data0(PC_Branch_wire_M),
	.MUX_Data1(MUX_AddALU_M),
	.MUX_Output(BranchesEQ_wire)
);


/**********************************ADD ALU RESULT*************************/
Adder32bits
ADDAluResult
(
	.Data0(PC_Branch_wire_EX),
	.Data1(Shift2_wire),
	.Result(MUX_AddALU_EX)
);

/**********************************SHIFT LEFT 2*************************/
ShiftLeft2
Shift
(
	.DataInput(InmmediateExtend_wire_EX),
	.DataOutput(Shift2_wire)
);


/**********************************NAND BEQ*************************/
NANDGate
NANDDNeq
(
	.A(BranchNE_wire_M),
	.B(Zero_wire_M),
	.C(MUX_BranchNE_wire)
);


/**********************************MUX BNE*************************/
Multiplexer2to1
#(
	.NBits(32)
)
MUX_BranchNE
(
	.Selector(MUX_BranchNE_wire),
	.MUX_Data0(MUX_AddALU_M),
	.MUX_Data1(PC_Branch_wire_M),
	.MUX_Output(BranchesNE_wire)
);

/**********************************MUX BRANCHES*************************/
Multiplexer2to1
#(
	.NBits(32)
)
MUX_Branches
(
	.Selector(BranchEQ_wire_M),
	.MUX_Data0(BranchesNE_wire),
	.MUX_Data1(BranchesEQ_wire),
	.MUX_Output(MUX_Branches_wire)
);


/**********************************SHIFT LEFT JUMP*************************/
ShiftLeft2Jump
ShiftJump
(
	.DataInput(Instruction_wire_ID[25:0]),
	.DataOutput(Jump_wire)
);


/*******************************CONCATENATION JUMP*************************/
Concatenation
Concatenation_Jump
(
	.DataInput1(Jump_wire),
	.DataInput2(PC_Branch_wire_ID),
	.DataOutput(Conca_wire_ID)
);

/**********************************MUX JUMP******************************/
Multiplexer3to1
#(
	.NBits(32)
)
MUX_Jump
(
	.Selector(J_wire_M),
	.MUX_Data0(MUX_Branches_wire),
	.MUX_Data1(Conca_wire),
	.MUX_Data2(ReadData1_wire_M),
	.MUX_Output(PC_4_wire)
);





//////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////
///////////////////////STAGES PIPELINE////////////////////////////////////
//////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////

///////////////////////// PIPELINE IF-ID//////////////////////////////////


PipelineRegister
#(	
	.N(64)
)
IF_ID
(
	.clk(clk),
	.reset(reset),
	.DataInput({PC_Branch_wire_IF,Instruction_wire_IF}),
	.DataOutput({PC_Branch_wire_ID, Instruction_wire_ID})
);
/////////////////////////////////////////////////////////////////////


//////////////////////// PIPELINE ID-EX/////////////////////////////




PipelineRegister
#(	
	.N(197)
)
ID_EX
(
	.clk(clk),
	.reset(reset),
	.DataInput({ReadData1_wire_ID,
					ReadData2_wire_ID,
					InmmediateExtend_wire_ID,
					Instruction_wire_ID[20:16],
					Instruction_wire_ID[15:11],
					Instruction_wire_ID[10:6],
					Instruction_wire_ID[5:0],
					PC_Branch_wire_ID,
					Conca_wire_ID,
					RegDst_wire_ID,
					BranchNE_wire_ID,
					BranchEQ_wire_ID,
					ALUOp_wire_ID,
					ALUSrc_wire_ID,
					RegWrite_wire_ID,
					MemRead_wire_ID,
					MemtoReg_wire_ID,
					MemWrite_wire_ID,
					J_wire_ID}), 
	
	.DataOutput({ReadData1_wire_EX,
					ReadData2_wire_EX,
					InmmediateExtend_wire_EX,
					Instruction_wire_EX[20:16],
					Instruction_wire_EX[15:11],
					Instruction_wire_EX[10:6],
					Instruction_wire_EX[5:0],
					PC_Branch_wire_EX,
					Conca_wire_EX,
					RegDst_wire_EX,
					BranchNE_wire_EX,
					BranchEQ_wire_EX,
					ALUOp_wire_EX,
					ALUSrc_wire_EX,
					RegWrite_wire_EX,
					MemRead_wire_EX,
					MemtoReg_wire_EX,
					MemWrite_wire_EX,
					J_wire_EX})
);

/////////////////////////////////////////////////////////////////////


////////////////////////////////PIPE EX-M/////////////////////////////

PipelineRegister
#(	
	.N(207)
)
EX_M
(
	.clk(clk),
	.reset(reset),
	.DataInput({PC_Branch_wire_EX,
					MUX_AddALU_EX,
					BranchNE_wire_EX,
					BranchEQ_wire_EX,
					RegWrite_wire_EX,
					MemRead_wire_EX,
					MemtoReg_wire_EX,
					MemWrite_wire_EX,
					J_wire_EX,
					Conca_wire_EX,
					ReadData1_wire_EX,
					ReadData2_wire_EX,
					Zero_wire_EX,
					ALUResult_wire_EX,
					WriteRegister_wire_EX}),
	
	.DataOutput({PC_Branch_wire_M,
					MUX_AddALU_M,
					BranchNE_wire_M,
					BranchEQ_wire_M,
					RegWrite_wire_M,
					MemRead_wire_M,
					MemtoReg_wire_M,
					MemWrite_wire_M,
					J_wire_M,
					Conca_wire_M,
					ReadData1_wire_M,
					ReadData2_wire_M,
					Zero_wire_M,
					ALUResult_wire_M,
					WriteRegister_wire_M})
);
//////////////////////////////////////////////////////////////////////


//////////////////////////////// PIPE M-WB//////////////////////////

PipelineRegister
#(	
	.N(104)
)
M_WB
(
	.clk(clk),
	.reset(reset),
	.DataInput({PC_Branch_wire_M,
			MemtoReg_wire_M,
			RegWrite_wire_M,
			ReadDataMUX_wire_M,
			ALUResult_wire_M,
			WriteRegister_wire_M}),
	.DataOutput({PC_Branch_wire_WB,
			MemtoReg_wire_WB,
			RegWrite_wire_WB,
			ReadDataMUX_wire_WB,
			ALUResult_wire_WB,
			WriteRegister_wire_WB})

);

/////////////////////////////////////////////////////////////

endmodule

