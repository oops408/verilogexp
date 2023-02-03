module prbs_sequence_generator (
  input clk,
  input reset,
  output reg [31:0] prbs_sequence
);

reg [31:0] shift_register;

always @(posedge clk) begin
  if (reset) begin
    shift_register <= 32'hFFFFFFFF;
  end else begin
    shift_register <= {shift_register[30:0], shift_register[31] ^ shift_register[28]};
  end
end

assign prbs_sequence = shift_register;

endmodule
