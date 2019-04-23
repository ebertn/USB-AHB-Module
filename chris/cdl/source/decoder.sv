module decoder
(
	input wire clk, 
	input wire n_rst, 
	input wire d_plus_in, 
	input wire d_minus_in, 
	output logic d_decoded, 
	output logic eop
); 

	reg next_decoded; 

	
	typedef enum reg [2:0] {INITIAL, ZERO, ONE, EOP_ONE, EOP_TWO} state_var; 		
	state_var state; 
	state_var next_state;

  
	always_ff @(posedge clk, negedge n_rst) begin
		if(n_rst == 1'b0) begin
			state <= INITIAL; 
			
		end else begin
			d_decoded <= next_decoded;
			state <= next_state; 
		end
	end

			
	always_comb begin
		next_decoded = d_decoded;
		eop = 1'b0; 
		
		case(state) 
			INITIAL: begin
				if(d_plus_in == 1'b1 && d_minus_in == 1'b0)begin
					next_decoded = 1'b0; 
					next_state = ZERO; 
					eop = 1'b0; 
				end
			end
			ZERO: begin
				if(d_plus_in == 1'b1 && d_minus_in == 1'b0) begin
					next_decoded = 1'b0; 
					next_state = ZERO; 
				end else if(d_plus_in == 1'b0 && d_minus_in == 1'b1)begin
					next_decoded = 1'b1; 
					next_state = ONE; 
				end else if (d_plus_in == 1'b0 && d_minus_in == 1'b0) begin
					next_state = EOP_ONE; 
				end 
				eop = 1'b0; 
			end
			ONE: begin
				if(d_plus_in == 1'b1 && d_minus_in == 1'b0) begin
					next_decoded = 1'b0; 
					next_state = ZERO; 
				end else if(d_plus_in == 1'b0 && d_minus_in == 1'b1)begin
					next_decoded = 1'b1; 
					next_state = ONE; 
				end else if (d_plus_in == 1'b0 && d_minus_in == 1'b0) begin
					next_state = EOP_ONE; 
				end 
				eop = 1'b0; 
			end
			EOP_ONE: begin
				if (d_plus_in == 1'b0 && d_minus_in == 1'b0) begin
					next_state = EOP_TWO; 
				end 
				else begin
					next_state = INITIAL; 
				end
				eop = 1'b0;
			end 
			EOP_TWO: begin
				eop = 1'b1; 
				next_state = EOP_TWO; 
			end
		endcase
	end

				

endmodule 