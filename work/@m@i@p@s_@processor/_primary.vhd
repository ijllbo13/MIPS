library verilog;
use verilog.vl_types.all;
entity MIPS_Processor is
    generic(
        MEMORY_DEPTH    : integer := 128;
        DATA_WIDTH      : integer := 32
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        PortIn          : in     vl_logic_vector(7 downto 0);
        ALUResultOut    : out    vl_logic_vector(31 downto 0);
        PortOut         : out    vl_logic_vector(31 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of MEMORY_DEPTH : constant is 1;
    attribute mti_svvh_generic_type of DATA_WIDTH : constant is 1;
end MIPS_Processor;
