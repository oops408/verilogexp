module uart(
    input clk,
    input rst_n,
    input [7:0] data_in,
    input start,
    output reg [7:0] data_out,
    output reg done
);

parameter BAUD_RATE = 9600;
parameter BIT_PERIOD = 1000000000 / BAUD_RATE; // Assuming 1 GHz clock

reg [3:0] state;
reg [7:0] shift_reg;
reg [3:0] bit_count;
reg start_bit, stop_bit;
reg tx_active;

// State machine states
parameter IDLE = 4'd0;
parameter START_BIT = 4'd1;
parameter DATA_BITS = 4'd2;
parameter PARITY_BIT = 4'd3;
parameter STOP_BIT = 4'd4;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state <= IDLE;
        shift_reg <= 8'b0;
        bit_count <= 4'd0;
        start_bit <= 1'b0;
        stop_bit <= 1'b0;
        tx_active <= 1'b0;
        done <= 1'b0;
        data_out <= 8'b0;
    end else begin
        case (state)
            IDLE: begin
                if (start) begin
                    shift_reg <= data_in;
                    bit_count <= 4'd0;
                    start_bit <= 1'b1;
                    stop_bit <= 1'b0;
                    tx_active <= 1'b1;
                    state <= START_BIT;
                end else begin
                    tx_active <= 1'b0;
                    done <= 1'b0;
                end
            end
            START_BIT: begin
                if (bit_count == 4'd0) begin
                    data_out <= 8'b0;
                end else if (bit_count >= 4'd1 && bit_count <= 4'd8) begin
                    data_out[bit_count-1] <= shift_reg[bit_count-1];
                end else if (bit_count == 4'd9) begin
                    data_out[7] <= 1'b0; // Even parity
                    stop_bit <= 1'b0;
                    for (int i=0; i<8; i=i+1) begin
                        stop_bit <= stop_bit ^ data_out[i];
                    end
                    state <= STOP_BIT;
                end
                bit_count <= bit_count + 1;
            end
            DATA_BITS: begin
                if (bit_count == 4'd9) begin
                    stop_bit <= 1'b1;
                    state <= PARITY_BIT;
                end else begin
                    bit_count <= bit_count + 1;
                end
            end
            PARITY_BIT: begin
                if (bit_count == 4'd10) begin
                    state <= STOP_BIT;
                end else begin
                    bit_count <= bit_count + 1;
                end
            end
            STOP_BIT: begin
                if (bit_count == 4'd11) begin
                    done <= 1'b1;
                    tx_active <= 1'b0;
                    state <= IDLE;
                end else begin
                    bit_count <= bit_count + 1;
                end
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

always @(posedge clk) begin
    if (tx_active) begin
        shift_reg <= {1'b0, shift_reg[7:1]};
    end
end

endmodule
