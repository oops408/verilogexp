module crc (input wire [7:0] data, input wire [3:0] generator, output reg [3:0] crc);
  reg [3:0] data_reg = data;
  reg [3:0] generator_reg = generator;
  reg [3:0] temp;
  integer i;

  always @ (data or generator) begin
    crc = 0;
    temp = data_reg;
    for (i=7; i>=0; i=i-1) begin
      if (temp[3] == 1'b1) begin
        temp = temp ^ generator_reg;
      end
      temp = temp << 1;
      temp[0] = data_reg[i];
    end
    crc = temp[3:0];
  end
endmodule
