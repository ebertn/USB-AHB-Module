module decoder
(
	input logic clk, 
	input logic n_rst, 
	input logic d_plus_in, 
	input logic d_minus_in, 
	output logic start, 
	output logic d_decoded, 
	output logic eop
); 

	reg next_decoded; 

	
	typedef enum reg [2:0] {INITIAL, ONE, EOP_ONE, EOP_TWO, ZERO, ZERO_TWO, ONE_TWO} state_var; 		
	state_var state; 
	state_var next_state;
	logic next_start; 
  
	always_ff @(posedge clk, negedge n_rst) begin
		if(n_rst == 1'b0) begin
			state <= INITIAL;
			d_decoded <= 1'b0; 
			start <= 1'b0; 
		end else begin
			d_decoded <= next_decoded;
			state <= next_state; 
			start <= next_start; 
			
		end
	end

			
	always_comb begin
		next_state = state; 
		next_decoded = d_decoded;
		eop = 1'b0; 
		
		next_start = start; 
		case(state) 
			INITIAL: begin
				next_start = 1'b0; 
				if(d_plus_in == 1'b0 && d_minus_in == 1'b1)begin
					next_decoded = 1'b0; 
					next_state = ZERO; 
					next_start = 1'b1; 
					 
				end else if (d_plus_in == 1'b1 && d_minus_in == 1'b0) begin
					next_decoded = 1'b1; 
					next_state = ONE; 
					next_start = 1'b1; 
				end else if (d_plus_in == 1'b0 && d_minus_in == 1'b0) begin
					next_state = EOP_ONE; 
				end else begin
					next_state = INITIAL; 
				end
				eop = 1'b0;
					
			end
			ZERO: begin
				//next_start = 1'b1; 
				if(d_plus_in == 1'b1 && d_minus_in == 1'b0) begin
					next_decoded = 1'b0; 
					next_state = ZERO_TWO; 
				end else if(d_plus_in == 1'b0 && d_minus_in == 1'b1)begin
					next_decoded = 1'b1; 
					next_state = ONE; 
				end else if (d_plus_in == 1'b0 && d_minus_in == 1'b0) begin
					next_state = EOP_ONE; 
				end 
				eop = 1'b0; 
			end
			ZERO_TWO:begin
				
				if(d_plus_in == 1'b0 && d_minus_in == 1'b1) begin
					next_decoded = 1'b0; 
					next_state = ZERO; 
				end else if(d_plus_in == 1'b1 && d_minus_in == 1'b0)begin
					next_decoded = 1'b1; 
					next_state = ONE_TWO; 
				end else if (d_plus_in == 1'b0 && d_minus_in == 1'b0) begin
					next_state = EOP_ONE; 
				end 
				eop = 1'b0; 
			end
			ONE: begin
				//next_start = 1'b1; 
				if(d_plus_in == 1'b1 && d_minus_in == 1'b0) begin
					next_decoded = 1'b0; 
					next_state = ZERO_TWO; 
				end else if(d_plus_in == 1'b0 && d_minus_in == 1'b1)begin
					next_decoded = 1'b1; 
					next_state = ONE; 
				end else if (d_plus_in == 1'b0 && d_minus_in == 1'b0) begin
					next_state = EOP_ONE; 
				end 
				eop = 1'b0; 
			end
			ONE_TWO:begin
				if(d_plus_in == 1'b0 && d_minus_in == 1'b1) begin
					next_decoded = 1'b0; 
					next_state = ZERO; 
				end else if(d_plus_in == 1'b1 && d_minus_in == 1'b0)begin
					next_decoded = 1'b1; 
					next_state = ONE_TWO; 
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
				next_state = EOP_TWO; 
				eop = 1'b0;
			end 
			EOP_TWO: begin
				eop = 1'b1; 
				next_state = INITIAL; 
			end
		endcase
	end

				

endmodule 