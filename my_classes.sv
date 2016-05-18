class MyEnv #( parameter [ 3:0 ] PATTERN = 4'b0110 );

    localparam WIDTH = 50;

    virtual patt_if.TB sig_h;

    function new( virtual patt_if.TB s );
        sig_h = s;
    endfunction

    task run();
        bit [ WIDTH - 1:0 ] mystream = 'b10001100011100011110000010100100011010100010101100;

        fork
            forever
            begin
                if ( sig_h.cb.found )
                    $display( "Found! PATTERN = %b", PATTERN );
                    @( sig_h.cb );
      	    end
        join_none

        for ( int i = 0; i < WIDTH; i++ )
        begin
            sig_h.cb.bit_stream <= mystream[ WIDTH - 1 - i ];
            @( sig_h.cb );
        end
    endtask
endclass

