`include "my_classes.sv"

interface patt_if
(
    input bit clk
);
    logic rst_n = 1'b0;
    logic bit_stream = 1'b0;
    logic found;

    clocking cb @( posedge clk );
        default output #1;

        output rst_n;
        output bit_stream;
        input found;
    endclocking : cb

    modport TB( clocking cb );
endinterface : patt_if

// ========================================================================

module tb;

parameter [ 3:0 ] PATTERN = 4'b1000;

logic clk;

// instantiate the interface
patt_if u_patt_if( .clk( clk ) );

// instantiate the main program
main_prg #( .PATTERN( PATTERN ) ) u_main_prg( .i_f( u_patt_if ) );

initial
begin
    $dumpfile( "dump.vcd" );
    $dumpvars( 0 );
end

initial
begin
    $timeformat( -9, 1, "ns", 8 );

    clk = 1'b0;
    forever #5 clk = ~clk;
end
  
// instantiate the DUT
pattern #( .PATTERN( PATTERN ) ) u_pattern
(
    .clk( clk ),
    .rst_n( u_patt_if.rst_n ),

    .bit_stream( u_patt_if.bit_stream ),
    .found( u_patt_if.found )
);

endmodule

// =======================================================================

program automatic main_prg
    #( parameter [ 3:0 ] PATTERN = 4'b1110 )
    ( patt_if i_f );

MyEnv#( .PATTERN( PATTERN ) ) env;
virtual patt_if.TB sig_h = i_f.TB;

initial
begin
    env = new( sig_h );

    sig_h.cb.rst_n <= 1'b0;
    #50 sig_h.cb.rst_n <= 1'b1;
    repeat( 10 ) @( sig_h.cb );

    env.run();

    repeat( 1000 ) @( sig_h.cb );
end

endprogram
