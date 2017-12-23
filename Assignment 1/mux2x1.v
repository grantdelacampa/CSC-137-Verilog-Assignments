// Grant De La Campa
//
// mux2x1.v, 2x1 multiplexor, gate synthesis
//
// how to compile: ~changw/ivl/bin/iverilog mux2x1.v
// how to run: ./a.out

module MuxMod(s, d0, d1, o);
   input s, d0, d1;
   output o;

   wire s_inv, and0, and1; // additional needed wires

   not(s_inv, s);          // "not" is built-in gate
   and(and0, d0, s_inv);   // "and" is built-in gate
   and(and1, d1, s);       // "and" is built-in gate
   or(o, and0, and1);      // "or" is built-in gate
endmodule

module TestMod;
   reg s, d0, d1;
   wire o;

   MuxMod my_mux(s, d0, d1, o);

//  initial #8 $finish; // end at $time 8

   initial begin
      $display("Time\ts\td0\td1\to");
      $display("---------------------------------");
      $monitor("%0d\t%b\t%b\t%b\t%b", $time, s, d0, d1, o);
   end

   initial begin
      s = 0; d0 = 0; d1 = 0;   // initially 000
      #1;                      // wait 1 cycle
      s = 0; d0 = 0; d1 = 1;   // change to 001
      #1;                      // wait 1 cycle
      s = 0; d0 = 1; d1 = 0;   // change to 010
      #1;                      // wait 1 cycle
      s = 0; d0 = 1; d1 = 1;   // change to 011
      #1;                      // wait 1 cycle
      s = 1; d0 = 0; d1 = 0;   // change to 100
      #1;                      // wait 1 cycle
      s = 1; d0 = 0; d1 = 1;   // change to 101
      #1;                      // wait 1 cycle
      s = 1; d0 = 1; d1 = 0;   // change to 110
      #1;                      // wait 1 cycle
      s = 1; d0 = 1; d1 = 1;   // change to 111
   end
endmodule