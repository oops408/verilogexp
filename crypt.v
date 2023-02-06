module sha256 (input clk, reset, input start,
               input [7:0] data_in,
               output reg [7:0] data_out,
               output reg busy,
               output reg done);
 
  reg [7:0] state[8];
  reg [31:0] message[16];
  reg [7:0] block_counter;
  reg [7:0] word_counter;
  reg [7:0] k[64];
  
  always @(posedge clk) begin
    if (reset) begin
      block_counter <= 8'b0;
      word_counter <= 8'b0;
      busy <= 1'b0;
      done <= 1'b0;
    end else if (start) begin
      busy <= 1'b1;
      message[word_counter] <= data_in;
      word_counter <= word_counter + 1;
      if (word_counter == 15) begin
        // perform padding, pre-processing and message schedule
        // ...
        // perform the main hash computation
        // ...
        // update the state with the final hash value
        // ...
        block_counter <= block_counter + 1;
        word_counter <= 8'b0;
      end
      if (block_counter == 8'b11111111) begin
        done <= 1'b1;
        busy <= 1'b0;
      end
    end
  end
  
  assign data_out = state[block_counter];
endmodule
