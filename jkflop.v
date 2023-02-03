module jk_flop (input J, K, clk,
                output reg Q, Qbar);
  always @(posedge clk)
    if (J & K)
      Q <= ~Q;
    else if (J)
      Q <= 1;
    else if (K)
      Q <= 0;
  assign Qbar = ~Q;
endmodule
