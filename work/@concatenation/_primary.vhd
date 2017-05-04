library verilog;
use verilog.vl_types.all;
entity Concatenation is
    port(
        DataInput1      : in     vl_logic_vector(27 downto 0);
        DataInput2      : in     vl_logic_vector(31 downto 0);
        DataOutput      : out    vl_logic_vector(31 downto 0)
    );
end Concatenation;
