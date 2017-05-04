library verilog;
use verilog.vl_types.all;
entity ShiftLeft2Jump is
    port(
        DataInput       : in     vl_logic_vector(25 downto 0);
        DataOutput      : out    vl_logic_vector(27 downto 0)
    );
end ShiftLeft2Jump;
