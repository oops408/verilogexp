module divider (input wire [31:0] dividend, divisor, output reg [31:0] quotient);
  reg [31:0] dividend_reg = dividend;
  reg [31:0] divisor_reg = divisor;
  reg [31:0] temp;
  integer i;

  always @ (dividend or divisor) begin
    quotient = 0;
    temp = dividend_reg;
    for (i=31; i>=0; i=i-1) begin
      if (temp >= divisor_reg) begin
        temp = temp - divisor_reg;
        quotient[i] = 1'b1;
      end else
        quotient[i] = 1'b0;
      divisor_reg = divisor_reg >> 1;
    end
  end
endmodule
