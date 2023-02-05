module pacman_hdmi (input clk,
                    output reg [1023:0] video_out);
  
  reg [9:0] x;
  reg [9:0] y;
  reg [3:0] state;
  
  always @(posedge clk) begin
    case (state)
      4'b0000: begin
        x <= x + 1;
        if (x == 10'd100)
          state <= 4'b0001;
      end
      4'b0001: begin
        y <= y + 1;
        if (y == 10'd100)
          state <= 4'b0010;
      end
      4'b0010: begin
        x <= x - 1;
        if (x == 10'd0)
          state <= 4'b0011;
      end
      4'b0011: begin
        y <= y - 1;
        if (y == 10'd0)
          state <= 4'b0000;
      end
    endcase
  end
  
  always @(*) begin
    video_out = 1023'b0;
    video_out[y*10+x] = 1;
  end
  
endmodule
