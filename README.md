Implements a four-bit pattern match design in SystemVerilog.  The basic testbench generates a stream of bits and pushes them into the DUT.  The DUT indicates back to the testbench when the pattern has been detected.  Checking is still manual at this point.

Top-level file names and use of backtick-include statements are consistent with what is required for simulating with EDAPlayground.  You can run the sim and look at waves at http://www.edaplayground.com/x/2XwU.
