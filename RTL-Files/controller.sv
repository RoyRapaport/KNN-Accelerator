`timescale 1ns/1ps

module controller(
	input clk,
	input rst,
	input i_valid,
	input i_data_type,
	input i_train_points_update,
	
	output logic o_wr_rq,
	output logic o_wr_source,
	output logic o_wr_test_point_en,
	output logic o_sorting_indication,
	output logic o_clr_smallest_data_regs,
	output logic o_valid,
	output logic o_busy,
	output logic [2:0] o_current_state
);

// localparam declaration
localparam RST_VALUE = 0;

//fsm declaration
typedef enum [2:0] {idle,memory_write,transition_st,sort,knn_finished} sm_type;
	sm_type current_state;
	sm_type next_state;

//internal logic declaration
logic [7:0] num_of_train_points;
logic train_point_indication;
logic test_point_flag;
logic test_point_indication;
logic [6:0] num_of_sorting_cycles;
logic sorting_indication;
logic clr_sorting_counter;
logic clr_train_point_counter;

//state machine register
always_ff @(posedge clk, posedge rst) begin
	if (rst) 
		current_state <= idle;
	else 
		current_state <= next_state;
	end

//counter:number of received train data point register
always_ff @(posedge clk, posedge rst) begin
	if (rst) 
		num_of_train_points <= RST_VALUE;
	else if (train_point_indication) // what will happend when equal to 128 - need add stop statement - check that 
		num_of_train_points <= num_of_train_points + 1'b1;
	else if (clr_train_point_counter)
		num_of_train_points <= RST_VALUE;
	end    

// flag if test point was received - register
always_ff @(posedge clk, posedge rst) begin
	if (rst) 
		test_point_flag <= 1'b0;
	else if (test_point_indication)
		test_point_flag <= 1'b1;
	
	end
	
	
//counter: number passed cycle since sorting started
always_ff @(posedge clk, posedge rst) begin
	if (rst) 
		num_of_sorting_cycles <= RST_VALUE;
	else if (sorting_indication) // what will happend when equal to 32 - need add stop statement - check that 
		num_of_sorting_cycles <= num_of_sorting_cycles + 1'b1;
	else if (clr_sorting_counter)
		num_of_sorting_cycles <= 7'b0;
	end

assign o_current_state = current_state;
assign o_sorting_indication = sorting_indication;

always_comb begin
	next_state = current_state;
	o_wr_rq = 1'b0;
	o_wr_source = 1'b0;
	train_point_indication = 1'b0;
	o_wr_test_point_en = 1'b0;
	test_point_indication = 1'b0;
	sorting_indication = 1'b0;
	o_valid = 1'b0;
	o_busy = 1'b0;
	clr_sorting_counter = 1'b0;
	o_clr_smallest_data_regs = 1'b0;
	clr_train_point_counter = 1'b0;

	case (current_state)
	idle: begin
		// valid & train point 
		if (i_valid & ~i_data_type ) begin 
			next_state = memory_write;
			o_wr_rq = 1'b1; 
			// In case we got less then 128 points
			if (num_of_train_points < 8'd128)
				train_point_indication = 1'b1;
		end

		// valid & test point
		else if (i_valid & i_data_type) begin
			// we already got 128 train points
			if (num_of_train_points == 8'd128) begin
				 next_state = transition_st;
				 //sorting_indication = 1'b1;
				 o_busy = 1'b1;
				 // memory cyclic write - sorting phase
				 //o_wr_source = 1'b1;
				 //o_wr_rq = 1'b1;
				 o_wr_test_point_en = 1'b1;
				 test_point_indication = 1'b1;
			end

			// we got less than 128 train points
			else begin
				o_wr_test_point_en = 1'b1;
				test_point_indication = 1'b1;
			end
		end

		// // full memory (128 numbers) & test point was given
		// else if (test_point_flag & num_of_train_points == 8'd128) begin
		//     next_state = sort;
		//     o_wr_source = 1'b1; 
		//     sorting_indication = 1'b1;
		//     o_wr_rq = 1'b1;
		// end

	end
	
	memory_write: begin 
		// In case we already got test point before we entered the memory state
		if (test_point_flag & num_of_train_points == 8'd128) begin
			next_state = sort;
			o_wr_source = 1'b1; 
			sorting_indication = 1'b1;
			o_wr_rq = 1'b1;
			o_busy = 1'b1;
		end
		// valid train point & num of train point so far is less than 128 => we add +1 to the counter . 
		// if num of train point so far is 128 or bigger => counter stays on max(128)
		else if (i_valid & ~i_data_type) begin 
			o_wr_rq = 1'b1;
			if (num_of_train_points < 8'd128)
				train_point_indication = 1'b1;
		end

		// valid & test point In case we got it inside the memory write state
		else if (i_valid & i_data_type) begin
			// In case we already got 128 numbers
			if (num_of_train_points == 8'd128) begin 
				next_state = transition_st;
				o_wr_test_point_en = 1'b1; // write test point register
				test_point_indication = 1'b1;
				o_busy = 1'b1; 
				// memory cyclic write - sorting phase
				//o_wr_source = 1'b1;
				//o_wr_rq = 1'b1; 
				//sorting_indication = 1'b1;

			end    
			// In case we got less than 128 numbers
			else begin
				next_state = idle;
				o_wr_test_point_en = 1'b1;
				test_point_indication = 1'b1;
			end
		end
		
		// In case we don't get valid.
		else 
			next_state = idle;
	end
	
	
	transition_st: begin 
		next_state = sort; 
		o_busy = 1'b1;
		o_wr_source = 1'b1;
		o_wr_rq = 1'b1; 
		sorting_indication = 1'b1;
		
	end


	sort: begin 
		// test point recived & we got 128 train points & less than 32 cycles => we are still sorting
		// test_point_flag & num_of_train_points == 8'd128 &  - old condition
		if (num_of_sorting_cycles < 6'd32) begin
			// memory cyclic write - sorting phase
			o_wr_rq = 1'b1;
			o_wr_source = 1'b1;  
			// inidaction for the sorting cycle     
			sorting_indication = 1'b1;
			o_busy = 1'b1;

		end
		// we finished with the 32(maybe 33?) sorting cycles
		else if (num_of_sorting_cycles == 6'd32) begin
			next_state = knn_finished;
			clr_sorting_counter = 1'd1; // Init the num of sorting cycles.
			o_busy = 1'b1; // think 
		end
	end

	knn_finished: begin
		o_valid = 1'b1;
		if (i_train_points_update) begin 
			next_state = idle;
			o_clr_smallest_data_regs = 1'b1;
			clr_train_point_counter = 1'b1;
			if (i_valid & i_data_type) begin 
				o_wr_test_point_en = 1'b1;
				test_point_indication = 1'b1;
			end
		end	
		// In case one update the test point
		else if (i_valid & i_data_type) begin 
			next_state = transition_st; 
			o_wr_test_point_en = 1'b1;
			//sorting_indication = 1'b1;
			 // memory cyclic write - sorting phase
			//o_wr_rq = 1'b1;
			//o_wr_source = 1'b1;
			test_point_indication = 1'b1;
			o_clr_smallest_data_regs = 1'b1;
		end

		// In case one update 1 train point
		else if (i_valid & ~i_data_type) begin
			next_state = transition_st;
			//sorting_indication = 1'b1;
			 // memory cyclic write - sorting phase
			o_wr_rq = 1'b1;
			o_wr_source = 1'b0;
			o_clr_smallest_data_regs = 1'b1;
		end
	end
	endcase
	
end

	property busy_while_sort; 
		@(posedge clk) disable iff (rst)
				current_state == sort |-> o_busy == 1;
	endproperty
	NOT_BUSY_WHILE_SORT_ASSERT: assert property (busy_while_sort) else $display("ERROR: o_busy must be 1 during sort state");

endmodule





