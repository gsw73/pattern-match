// Code your testbench here
// or browse Examples
interface patt_if
(
    input bit clk
);
    logic rst_n;
    logic bit_stream;
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

parameter [ 3:0 ] PATTERN = 4'b1101;

logic clk;

// instantiate the interface
patt_if u_patt_if( .clk( clk ) );

// instantiate the main program
// main_prg #( .PATTERN( PATTERN ) ) u_main_prg( .i_f( u_patt_if ) );

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
  
initial
  #100 $finish;

// instantiate the DUT
pattern #( .PATTERN( PATTERN ) )
(
    .clk( clk ),
    .rst_n( u_patt_if.rst_n ),

    .bit_stream( u_patt_if.bit_stream ),
    .found( u_patt_if.found )
);

endmodule
