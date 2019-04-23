// $Id: $
// File name:   bit_stuffer.sv
// Created:     4/16/2019
// Author:      Nick Ebert
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Bit Stuffer

module bit_stuffer 
(
    input logic clk,
    input logic n_rst,
    input logic serial_in,
    input logic rollover_flag64,
    output logic stuffing,
    output logic stuffed_serial_out
);

typedef enum {IDLE, ONE1, ONE2, ONE3, ONE4, ONE5, ONE6, ZERO} State;
State state, next_state;

always_ff @(posedge clk, negedge n_rst) begin
    if(!n_rst) begin
        state <= IDLE;
    end else begin
        state <= next_state;
    end
end

// Next State logic

always_comb begin
    next_state = state;

    case(state)
        IDLE: begin
            if (serial_in == 1 && rollover_flag64)
                next_state = ONE1;
        end

        ONE1: begin
            if (serial_in == 1 && rollover_flag64)
                next_state = ONE2;
        end

        ONE2: begin
            if (serial_in == 1 && rollover_flag64)
                next_state = ONE3;
        end

        ONE3: begin
            if (serial_in == 1 && rollover_flag64)
                next_state = ONE4;
        end

        ONE4: begin
            if (serial_in == 1 && rollover_flag64)
                next_state = ONE5;
        end

        ONE5: begin
            if (serial_in == 1 && rollover_flag64)
                next_state = ZERO;
        end

        ZERO: begin
            if(rollover_flag64)
                next_state = IDLE;
        end
    endcase

    if (serial_in == 0 && rollover_flag64) 
        next_state = IDLE;
end

// Output logic

always_comb begin
    stuffing = 0;
    stuffed_serial_out = serial_in;

    if (state == ZERO) begin
        stuffing = 1;
        stuffed_serial_out = 0;
    end
end

endmodule