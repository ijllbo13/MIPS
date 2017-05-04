library verilog;
use verilog.vl_types.all;
entity Control is
    port(
        OP              : in     vl_logic_vector(5 downto 0);
        \Function\      : in     vl_logic_vector(5 downto 0);
        RegDst          : out    vl_logic_vector(1 downto 0);
        BranchEQ        : out    vl_logic;
        BranchNE        : out    vl_logic;
        MemRead         : out    vl_logic;
        MemtoReg        : out    vl_logic_vector(1 downto 0);
        MemWrite        : out    vl_logic;
        ALUSrc          : out    vl_logic;
        RegWrite        : out    vl_logic;
        Jump            : out    vl_logic_vector(1 downto 0);
        ALUOp           : out    vl_logic_vector(3 downto 0)
    );
end Control;
