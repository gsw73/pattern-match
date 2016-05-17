`include "pattern_sm.sv"

module pattern
#(
    parameter [ 3:0 ] PATTERN = 4'b1010
)
(
    input logic clk,
    input logic rst_n,

    input logic bit_stream,
    output logic found
);

// =======================================================================
// Declarations & Parameters

logic start_sm_a;
logic start_sm_b;
logic start_sm_c;
logic start_sm_d;

logic found_a;
logic found_b;
logic found_c;
logic found_d;
  
logic [ 1:0 ] cnt;  

// =======================================================================
// Combinational Logic

assign start_sm_a = cnt == 2'b00;
assign start_sm_b = cnt == 2'b01;
assign start_sm_c = cnt == 2'b10;
assign start_sm_d = cnt == 2'b11;

always_comb
    found = found_a | found_b | found_c | found_d;

// =======================================================================
// Registered Logic

always_ff @( posedge clk )

    if ( ~rst_n )
        cnt <= 2'b00;

    else
        cnt <= cnt + 2'b1;

// =======================================================================
// Instantiations

pattern_sm
#(
    .PATTERN( PATTERN )
)
u_sm_a
(
    .clk( clk ),
    .rst_n( rst_n ),

    .bit_stream( bit_stream ),
    .start( start_sm_a ),

    .found( found_a )
);

pattern_sm
#(
    .PATTERN( PATTERN )
)
u_sm_b
(
    .clk( clk ),
    .rst_n( rst_n ),

    .bit_stream( bit_stream ),
    .start( start_sm_b ),

    .found( found_b )
);

pattern_sm
#(
    .PATTERN( PATTERN )
)
u_sm_c
(
    .clk( clk ),
    .rst_n( rst_n ),

    .bit_stream( bit_stream ),
    .start( start_sm_c ),

    .found( found_c )
);

pattern_sm
#(
    .PATTERN( PATTERN )
)
u_sm_d
(
    .clk( clk ),
    .rst_n( rst_n ),

    .bit_stream( bit_stream ),
    .start( start_sm_d ),

    .found( found_d )
);

endmodule
