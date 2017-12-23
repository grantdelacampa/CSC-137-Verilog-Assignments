// Grant De La Campa
//
// decoder2x4.v, 2x4 decoder, gate synthesis
//
// how to compile: ~changw/ivl/bin/iverilog decoder1x2.v
// how to run: ./a.out

/*
   old-style comments starts with "slash-star"
   why didn't I do this: x=y*z;
   all comments until "star-slash"
*/

module DecoderMod(s0, s1, o0, o1, o2, o3); // module definition
   input s0, s1;
   output o0, o1, o2, o3;

    wire s0_inv, s1_inv;
    not (s0_inv, s0);
    not (s1_inv, s1);
    and (o0, s0_inv, s1_inv);
    and (o1, s0, s1_inv);
    and (o2, s0_inv, s1);
    and (o3, s0, s1);

endmodule

module TestMod; // or call it main, it tests DecoderMod
   reg s0, s1;       // s is a 1-bit flipflop
   wire o0, o1, o2, o3; // 2 additional wires

   DecoderMod my_decoder(s0, s1, o0, o1, o2, o3); // create instance

   initial begin
      $monitor("%0d\t%b\t%b\t%b\t%b\t%b\t%b", $time, s0, s1, o0, o1, o2, o3);
      $display("Time\ts0\ts1\to0\to1\to2\to3");
      $display("--------------------------");
   end

   initial begin
      s0 = 0; s1 = 0;      // initially s is 0
      #1;          // wait 1 simulation time unit/cycle
      s0 = 0; s1 = 1;      // change s to 1
      #1;          // wait 1 simulation time unit/cycle
      s0 = 1; s1 = 0;      // change s to 0
      #1;          // wait 1 simulation time unit/cycle
      s0 = 1; s1 = 1;      // change s to 1
   end
endmodule