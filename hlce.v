module lossless_compressor (input clk, reset,
                            input [7:0] data_in,
                            output reg [7:0] data_out,
                            output reg compress_enable,
                            output reg [3:0] run_length);
 
  reg [7:0] last_data;
  reg [3:0] count;
  
  always @(posedge clk) begin
    if (reset) begin
      last_data <= 8'b0;
      count <= 4'b0;
      compress_enable <= 1'b0;
    end else begin
      if (data_in == last_data) begin
        count <= count + 1;
        if (count == 15) begin
          compress_enable <= 1'b1;
          run_length <= count;
        end
      end else begin
        last_data <= data_in;
        count <= 1;
        compress_enable <= 1'b0;
      end
    end
  end
  
  assign data_out = (compress_enable) ? last_data : data_in;
endmodule
