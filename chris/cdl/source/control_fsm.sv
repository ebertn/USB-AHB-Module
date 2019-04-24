module control_fsm
(
	input wire clk, 
	input wire n_rst, 
	input wire sync_byte, 
	input wire [7:0] packet_in, 
	input wire eop, 
	input wire five_crc, 
	input wire byte_count, 
	input wire sixteen_crc, 
	output reg five_crc_clear, 
	output reg sixteen_crc_clear, 
	output reg [7:0] packet_data, 
	output reg [2:0] rx_packet, 
	output reg store_rx_data 
);

	/* 
	rx_packet
	000 = idle  "ACK"
 	001 = ready "OUT"
	100 = busy "DATA0 , DATA1"
	010 = recieved "IN"
	011 = error "NACK, STALL"
	*/

	typedef enum reg [3:0] {IDLE, PID, DATA0, DATA1, DATA2, TOKEN, ADDRESS, ENDPOINT_CRC, EOP, EOP2} state_var;
				
	
	state_var state, next_state; 

	always_ff @(posedge clk, negedge n_rst) begin
		if (n_rst == 1'b0) begin
			state <= IDLE; 
		end else begin 
			state <= next_state; 
		end
	end 

	always_comb begin
		store_rx_data = 1'b0; 
		next_state = state; 
		rx_packet = 3'b000; 
		packet_data = '0; 
		five_crc_clear = 1'b0; 
		sixteen_crc_clear = 1'b0; 
		case(state) 
			IDLE:begin
				rx_packet = 3'b000; 
				if (sync_byte == 1'b1) begin
					next_state = PID; 	
				end else begin
					next_state = IDLE;
				end
		
			end 
			PID:begin
				if (packet_in == 8'b00111100 || packet_in == 8'b10110100) begin
					next_state = DATA0; 
					rx_packet = 3'b100; 
					
				end else if (packet_in == 8'b00011110) begin
					rx_packet = 3'b001; 
					next_state = TOKEN;
				end else if (packet_in == 8'b00101101) begin
					rx_packet = 3'b000; 
					next_state = TOKEN;
				end else if (packet_in == 8'b10010110) begin	
					rx_packet = 3'b010; 
					next_state = TOKEN;
				end else if (packet_in == 8'b10100101 || packet_in == 8'b11100001) begin
					rx_packet = 3'b011;
					next_state = TOKEN;
				end
			end 
			TOKEN:begin 
				next_state = ADDRESS; 
			end
			ADDRESS:begin 
				next_state = ENDPOINT_CRC; 
			end 
			ENDPOINT_CRC:begin
				next_state = EOP; 
			end
			DATA0:begin
				next_state = DATA1;
			end
			DATA1:begin
				next_state = DATA2; 
		
			end 
			DATA2:begin
				if(byte_count == 1'b1) begin
					packet_data = packet_in;
				end
				if (eop == 1'b1) begin
					next_state = EOP2; 
					store_rx_data = 1'b1; 
				end else begin
					next_state = DATA2; 
				end
			end
			EOP:begin
				//store_rx_data = 1'b1; 
				next_state = EOP; 
				if (five_crc == 1'b1 && eop == 1'b1) begin
					five_crc_clear = 1'b1; 
					rx_packet = 3'b011; 
				end else begin
					five_crc_clear = 1'b0; 
				end 
			end 
			EOP2:begin
				store_rx_data = 1'b1;
				next_state = EOP2;
				if (sixteen_crc == 1'b1 && eop == 1'b1) begin
					sixteen_crc_clear = 1'b1; 
					rx_packet = 3'b011; 
				end else begin
					sixteen_crc_clear = 1'b0; 
				end 
			end
		endcase
	end 

endmodule
			
				
			

				
				
				
						
				
				
				
				
				
				
				 
