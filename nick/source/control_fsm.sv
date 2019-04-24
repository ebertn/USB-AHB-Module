// $Id: $
// File name:   control_fsm.sv
// Created:     4/16/2019
// Author:      Nick Ebert
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Control FSM

module control_fsm
(
	input logic clk,
	input logic n_rst, 
	input logic [7:0] tx_packet_data,
	input logic [6:0] tx_packet_data_size,
	input logic [1:0] tx_packet,
	input logic rollover_flag8,
	input logic rollover_flag64,
	input logic rollover_flag512,
	input logic stuffing,
	input logic [15:0] calculated_crc,
	output logic timer_count_enable,
	output logic timer_clear,
	output logic timer_latch_packet_size,
	output logic crc_clear,
	output logic crc_shift,
	output logic get_tx_packet_data,
	output logic pts_shift,
	output logic pts_load,
	output logic [7:0] data_out,
	output logic eop
);

typedef enum {IDLE, START_TRANSFER, SYNC_BYTE, LOAD_PID, DATA_PID, LOAD_DATA, SEND_BYTE, CRC0, CRC1, ACK_PID, NACK_PID, DELAY, EOP} State;
State state, next_state;

localparam tx_packet_IDLE 	    = 2'b00;
localparam tx_packet_DATA = 2'b01;
localparam tx_packet_SEND_ACK 	    = 2'b10;
localparam tx_packet_SEND_NACK 	    = 2'b11;

always_ff @(posedge clk, negedge n_rst) begin
	if (!n_rst) begin
		state <= IDLE;
	end else begin
		state <= next_state;
	end
end

// Next State Logic

always_comb begin
	next_state = state;

	case(state)
		IDLE: begin
			if(tx_packet != tx_packet_IDLE) next_state = START_TRANSFER;
		end

		START_TRANSFER: begin
			next_state = SYNC_BYTE;
		end

		SYNC_BYTE: begin
			if(rollover_flag64) next_state = LOAD_PID;
		end

		LOAD_PID: begin
			//if (!rollover_flag64) next_state = LOAD_PID;
			//else 
			if (tx_packet == tx_packet_DATA) next_state = DATA_PID;
			else if (tx_packet == tx_packet_SEND_ACK) next_state = ACK_PID;
			else next_state = NACK_PID;
		end

		DATA_PID: begin
			if(rollover_flag64) next_state = LOAD_DATA;
		end

		LOAD_DATA: begin
			next_state = SEND_BYTE;
			if (rollover_flag512) next_state = CRC0;
		end

		SEND_BYTE: begin
			if (rollover_flag64) next_state = LOAD_DATA;
		end

		CRC0: begin 
			if (rollover_flag64) next_state = CRC1;
		end

		CRC1: begin 
			if (rollover_flag64) next_state = DELAY;
		end

		ACK_PID: begin 
			if (rollover_flag64) next_state = DELAY;
		end

		NACK_PID: begin 
			if (rollover_flag64) next_state = DELAY;
		end

		DELAY: begin
			if(rollover_flag8 || rollover_flag64) next_state = EOP;
		end

		EOP: begin
			next_state = IDLE;
		end
		
	endcase

	if (stuffing)
		next_state = state;
end

// Output Logic

always_comb begin
	timer_count_enable = 1;
	timer_clear = 0;
	data_out = '0;
	eop = 0;
	get_tx_packet_data = 0;
	crc_clear = 0;
	crc_shift = 0;
	timer_latch_packet_size = 0;
	pts_load = 0;

	pts_shift = rollover_flag8 && !stuffing && state != IDLE;

	case(state)
		IDLE: begin
			//timer_count_enable = 0;
		end

		START_TRANSFER: begin
			pts_load = 1;
			data_out = 8'b10000000;
			timer_clear = 1;
			timer_latch_packet_size = 1;
		end

		SYNC_BYTE: begin
		end

		LOAD_PID: begin
			pts_load = 1;
			//timer_clear = 1;

			if (tx_packet == tx_packet_DATA) data_out = 8'b00111100;
			else if (tx_packet == tx_packet_SEND_ACK) data_out = 8'b10110100;//8'b00101101;
			else data_out = 8'b10100101;
		end

		DATA_PID: begin
			if(rollover_flag64) timer_clear = 1;
			crc_clear = 1;
			get_tx_packet_data = 1;
		end

		/*GET_DATA: begin
			timer_count_enable = 0; // Maybe needed, maybe not. 
						// Want to make sure timer counts 
						// to correct value fo 8, and counting 
						// on data pid might make it only count 
						// to 7
			if (!stuffing)
				get_tx_packet_data = 1;

			if(rollover_flag512) begin
				data_out = calculated_crc[7:0];
				pts_load = 1;
			end
			
		end*/

		LOAD_DATA: begin
			//timer_count_enable = 0;
			data_out = tx_packet_data;

			if(rollover_flag512) begin
				data_out = calculated_crc[7:0];
			end

			pts_load = 1;
		end

		SEND_BYTE: begin
			if(rollover_flag64 && !stuffing)
				get_tx_packet_data = 1;

			if(rollover_flag8)
				crc_shift = 1;
		end

		CRC0: begin 
			if(rollover_flag64) begin
				data_out = calculated_crc[15:8];
				pts_load = 1;
			end
		end

		CRC1: begin 
		end

		ACK_PID: begin 
			data_out = 8'b10110100;
		end

		NACK_PID: begin 
			data_out = 8'b10100101;
		end

		EOP: eop = 1;
		
	endcase
end


endmodule