module mux_4to1(
  input wire [3:0] a,
  input wire [3:0] b,
  input wire [3:0] c,
  input wire [3:0] d,
  input wire [1:0] sel,
  output reg [3:0] out
);

  always @(*) begin
    case (sel)
      2'b00: out <= a;
      2'b01: out <= b;
      2'b10: out <= c;
      2'b11: out <= d;
      default: out <= a;
    endcase
  end

endmodule
