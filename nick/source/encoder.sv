// $Id: $
// File name:   encoder.sv
// Created:     4/16/2019
// Author:      Nick Ebert
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Encoder

module encoder
(
    input logic clk,
    input logic n_rst,
    input logic serial_in,
    input logic rollover_flag64,
    input logic EOP,
    output logic dplus,
    output logic dminus
);

typedef enum {IDLE, ZERO1, ZERO2, ONE1, ONE2, EOP1, EOP2} State;
State state, next_state;

logic next_dplus, next_dminus;

always_ff @(posedge clk, negedge n_rst) begin
    if (!n_rst) begin
        state <= IDLE;
        dplus <= 0;
        dminus <= 1;
    end else begin
        state <= next_state;
        dplus <= next_dplus;
        dminus <= next_dminus;
    end
end

// next state logic
always_comb begin
    next_state = state;

    case(state)
        IDLE: begin
            if (serial_in == 0)
                next_state = ZERO1;
            else
                next_state = ONE1;
        end

        ZERO1: begin
//            if (serial_in == 1)
//                next_state = ONE;
		next_state = ZERO2;
        end

	ZERO2: begin
		if (serial_in == 1)
                	next_state = IDLE;
	end

        ONE1: begin
//            if (serial_in == 0)
//                next_state = ZERO;
		next_state = ONE2;
        end

	ONE2: begin
		if (serial_in == 0)
	                next_state = IDLE;
	end

        EOP1: begin
	    if(rollover_flag64)
                 next_state = EOP2;
        end

        EOP2: begin
	    if(rollover_flag64)
                 next_state = IDLE;
        end
    endcase

    if (EOP)
        next_state = EOP1;
end

// Output logic

always_comb begin
    next_dplus = !dminus;
    next_dminus = !dplus;
    
    case(state)
        IDLE: begin
		if(dplus == dminus) begin
			next_dplus = 0;
			next_dminus = 1;
		end

        end

        ZERO1: begin
            next_dplus = !dplus;
            next_dminus = !dminus;
        end

        ONE1: begin
            next_dplus = dplus;
            next_dminus = dminus;
        end

        EOP1: begin
            next_dplus = 0;
            next_dminus = 0;
        end

        EOP2: begin
            next_dplus = 0;
            next_dminus = 0;
        end
    endcase
end

endmodule