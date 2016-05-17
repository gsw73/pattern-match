module pattern_sm
#(
    parameter [ 3:0 ] PATTERN = 4'b0101
)
(
    input logic clk,
    input logic rst_n,

    input logic bit_stream,
    input logic start,

    output logic found
);

// =======================================================================
// Declarations & Parameters

typedef enum logic [ 3:0 ] { ST0 = 4'b0001, ST1 = 4'b0010, ST2 = 4'b0100, ST3 = 4'b1000 } state_t;

state_t state;

logic st0, st1, st2, st3;

// =======================================================================
// Combinational Logic

assign st0 = state == ST0;
assign st1 = state == ST1;
assign st2 = state == ST2;
assign st3 = state == ST3;

// =======================================================================
// Registered Logic

// Register:  found

always_ff @( posedge clk )

    if ( st3 && bit_stream == PATTERN[ 3 ] )
        found <= 1'b0;

    else
        found <= 1'b1;

// =======================================================================
// State Machines

always_ff @( posedge clk )

    if ( ~rst_n )
        state <= ST0;

    else
    begin
        case( state )
            ST0:
                if ( start && bit_stream == PATTERN[ 0 ] )
                    state <= ST1;

                else
                    state <= ST0;

            ST1:
                if ( bit_stream == PATTERN[ 1 ] )
                    state <= ST2;

                else
                    state <= ST0;

            ST2:
                if ( bit_stream == PATTERN[ 2 ] )
                    state <= ST3;

                else
                    state <= ST0;

            ST3:
                state <= ST0;
        endcase
    end

endmodule



