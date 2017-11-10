library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity half_adder is
    port(a : in std_logic;
         b : in std_logic;
       sum : out std_logic;
      cout : out std_logic);
end half_adder;
 
architecture func_half_adder of half_adder is
begin
    sum   <= a xor b;
    carry <= a and b;
end func_half_adder;


entity full_adder is
    port( a : in std_logic;
          b : in std_logic;
        cin : in std_logic;
        sum : out std_logic;
       cout : out std_logic);
end full_adder;

architecture func_full_adder of full_adder is
begin

    sum  <= a XOR b XOR cin ;
    cout <= (a AND b) OR (cin AND a) OR (cin AND b) ;

end func_full_adder;

entity wallace_multiplier is
    port( A : in  STD_LOGIC_VECTOR (7 downto 0);
          B : in  STD_LOGIC_VECTOR (7 downto 0);
       prod : out  STD_LOGIC_VECTOR (17 downto 0));
end wallace_multiplier
    
architecture func_wallace_multiplier is

component half_adder is
    port(a : in std_logic;
         b : in std_logic;
       sum : out std_logic;
      cout : out std_logic);
end component;
 
component full_adder is
    port( a : in std_logic;
          b : in std_logic;
        cin : in std_logic;
        sum : out std_logic;
       cout : out std_logic);
end component;

signal p0, p1, p2, p3, p4, p5, p6, p7 : std_logic_vector(7 downto 0);       --Storing the product terms

begin


signal s2_1, s3_1, s3_2, s4_1, s4_2, s5_1, s5_2, s6_1. s6_2, s7_1, s7_2, s8_1, s8_2, s9_1,s9_2,s10_1,s10_2,s11_1,s11_2,s12_1,s12_2,s13_1:std_logic;



process(A, B)
begin
    for i in 0 to 7 loop
        p0(i) <= A(i) and B(0);
        p1(i) <= A(i) and B(1);
        p2(i) <= A(i) and B(2);
        p3(i) <= A(i) and B(3);
        p4(i) <= A(i) and B(4);
        p5(i) <= A(i) and B(5);
        p6(i) <= A(i) and B(6);
        p7(i) <= A(i) and B(7);
    end loop;       
end process;

prod(0) <= p0(0);           --first pp is passed throughout all stages

--first stage
FA1:full_adder
port map(p2(0),
         p1(1),
         p0(2),
         s2_1,
         s3_1);
            
FA2:full_adder
port map(p3(0),
         p2(1),
         p1(2),
         s3_2,
         s4_1);

FA3:full_adder
port map(p4(0),
         p3(1),
         p2(2),
         s4_2,
         s5_1);
                 
FA4:full_adder
port map(p5(0),
         p4(1),
         p3(2),
         s5_2,
         s6_1);
        
FA5:full_adder
port map(p6(0),
         p5(1),
         p4(2),
         s6_2,
         s7_1);

FA6:full_adder
port map(p7(0),
         p6(1),
         p5(2),
         s7_2,
         s8_1);

FA7:full_adder
port map(p7(1),
         p6(2),
         p5(3),
         s8_2,
         s9_1);

FA8:full_adder
port map(p7(2),
         p6(3),
         p5(4),
         s9_2,
         s10_1);        
        
FA9:full_adder
port map(p7(3),
         p6(4),
         p5(5),
         s10_2,
         s11_1);        
        
FA10:full_adder
port map(p7(4),
         p6(5),
         p5(6),
         s11_2,
         s12_1);    

FA11:full_adder
port map(p7(5),
         p6(6),
         p5(7),
         s12_2,
         s13_1);

FA12:full_adder
port map(p2(3),
         p1(4),
         p0(5),
         s5_3,
         s6_3);

FA13:full_adder
port map(p3(3),
         p2(4),
         p1(5),
         s6_4,
         s7_3);

FA14:full_adder
port map(p4(3),
         p3(4),
         p2(5),
         s7_4,
         s8_3);

FA15:full_adder
port map(p4(4),
         p3(5),
         p2(6),
         s8_4,
         s9_3);

FA16:full_adder
port map(p4(5),
         p3(6),
         p2(7),
         s9_4,
         s10_3);

--Second Stage

FA17:full_adder
port map(p0(3),
         s3_1,
         s3_2,
         t3_1,
         t4_1);

FA18:full_adder     --s4_2 unused
port map(p1(3),
         p0(4),
         s4_1,
         t4_2,
         t5_1);

FA19:full_adder     
port map(s5_1,
         s5_2,
         s5_3,
         t5_2,
         t6_1);

FA20:full_adder      --s6_3,s6_4 unused     
port map(p0(6),
         s6_1,
         s6_2,
         t6_2,
         t7_1);

FA21:full_adder     --s7_2, s7_3, s7_4 unused
port map(p1(6),
         p0(7),
         s7_1,
         t7_2,
         t8_1);

FA22:full_adder     --s8_3, s8_4 unused
port map(p1(7),
         s8_1,
         s8_2,
         t8_2,
         t9_1);

FA23:full_adder     --s4_2 unused
port map(s9_1,
         p0(4),
         s4_1,
         t3_1,
         t4_1);

FA24:full_adder     --s4_2 unused
port map(p1(3),
         p0(4),
         s4_1,
         t3_1,
         t4_1);

FA25:full_adder     --s4_2 unused
port map(p1(3),
         p0(4),
         s4_1,
         t3_1,
         t4_1);

HA1:half_adder
port map(
);
    

end func_wallace_multiplier; 



