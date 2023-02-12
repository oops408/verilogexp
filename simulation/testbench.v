module and4_tb;
   reg a, b, c, d;
   wire y;

   and4 and4_uut (a, b, c, d, y);

   initial begin
      a = 0; b = 0; c = 0; d = 0;
      #10
      a = 0; b = 0; c = 0; d = 1;
      #10
      a = 0; b = 0; c = 1; d = 0;
      #10
      a = 0; b = 0; c = 1; d = 1;
      #10
      a = 0; b = 1; c = 0; d = 0;
      #10
      a = 0; b = 1; c = 0; d = 1;
      #10
      a = 0; b = 1; c = 1; d = 0;
      #10
      a = 0; b = 1; c = 1; d = 1;
      #10
      a = 1; b = 0; c = 0; d = 0;
      #10
      a = 1; b = 0; c = 0; d = 1;
      #10
      a = 1; b = 0; c = 1; d = 0;
      #10
      a = 1; b = 0; c = 1; d = 1;
      #10
      a = 1; b = 1; c = 0; d = 0;
      #10
      a = 1; b = 1; c = 0; d = 1;
      #10
      a = 1; b = 1; c = 1; d = 0;
      #10
      a = 1; b = 1; c = 1; d = 1;
      #10
      $finish;
   end
endmodule
