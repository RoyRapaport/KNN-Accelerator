`timescale 1ns/1ps

module top_chip (
	input clk, 
	input rst,
	input [10:0] i_x,
	input [9:0] i_y,		
	input i_valid,	
	input i_data_type,
	input i_train_points_update,


	output logic o_valid,
	output logic o_group,
	output logic [2:0] o_current_state,
	output logic o_inverter,
	output logic o_ff,
	output logic o_busy
	);

	localparam NUM_OF_CALCULATORS = 4;
	localparam REGSITER_SIZE = 11;
	localparam RST_VALUE = 11'b0;
	
	//////////////////////////////////////
	//test point regs logic declaration://
	//////////////////////////////////////
	logic [9:0] x_test_point_reg;
	logic [9:0] y_test_point_reg;

	/////////////////////////////////////
	// Memory module logic declaration://
	/////////////////////////////////////
	logic wr_rq;
	logic wr_source;
	logic [REGSITER_SIZE - 1:0] x_memory [3:0];
	logic [REGSITER_SIZE - 2:0] y_memory [3:0];


	//////////////////////////////////////////////////
	// distance calculator module logic declaration://
	//////////////////////////////////////////////////
	logic test_point_wr_en;
	logic [REGSITER_SIZE:0] distance [3:0];
	
	////////////////////////////////////////////
	// group decider module logic declaration://
	////////////////////////////////////////////
	logic [4:0] smallest_5_distances_group_bit;


	///////////////////////////////////////////
	// bitonic sort module logic declaration://
	///////////////////////////////////////////
	logic sorting_indication;
	logic clr_smallest_data_regs;
	
	
	///////////////////////////
	// sampled outputs logic://
	///////////////////////////
	logic group_pre_sample;
	always_ff @(posedge clk or posedge rst) begin
		if (rst)
			o_group <= 1'b0;
		else 
			o_group <= group_pre_sample;
		end

	logic valid_output_pre_sample;
	always_ff @(posedge clk or posedge rst) begin
		if (rst)
			o_valid <= 1'b0;
		else 
			o_valid <= valid_output_pre_sample;
		end


	logic busy_pre_sample;
	always_ff @(posedge clk or posedge rst) begin
		if (rst)
			o_busy <= 1'b0;
		else 
			o_busy <= busy_pre_sample;
		end


	/////////////////////////
	//Goel logic
	/////////////////////////
	//inverter
	assign o_inverter = ~i_data_type;
	
	//ff
	always_ff @(posedge clk or posedge rst) begin
		if (rst)
			o_ff <= 1'b0;
		else 
			o_ff <= i_data_type;
	end
	
	///////////////////
	//test point regs//
	///////////////////
	always_ff @(posedge clk or posedge rst)
		begin
			if (rst) begin
				x_test_point_reg <= RST_VALUE;
				y_test_point_reg <= RST_VALUE;
				end
			else if (test_point_wr_en) begin
				x_test_point_reg <= i_x[9:0]; 
				y_test_point_reg <= i_y[9:0]; 
				end	
		end	
	

	/////////////////////////
	// Memory
	/////////////////////////

	memory chip_memory (
		.rst (rst),
		.clk (clk),
		.i_x (i_x),
		.i_y (i_y),
		.i_wr_rq (wr_rq),
		.i_wr_source (wr_source),
		.o_x_out0 (x_memory[0]),
		.o_x_out1 (x_memory[1]),
		.o_x_out2 (x_memory[2]),
		.o_x_out3 (x_memory[3]),
		.o_y_out0 (y_memory[0]),
		.o_y_out1 (y_memory[1]),
		.o_y_out2 (y_memory[2]),
		.o_y_out3 (y_memory[3])
	);

	/////////////////////////
	// 4 Distance calculator
	/////////////////////////
	genvar i;
	generate 
		for (i=0 ; i < NUM_OF_CALCULATORS ; i = i +1) 
			begin 
				distance_calculator distance_calculator(
					.i_x_mem (x_memory[i]),
					.i_y_mem (y_memory[i]),
					.i_x_test_point (x_test_point_reg),
					.i_y_test_point (y_test_point_reg),
					.o_distance (distance[i])
					);
			end                    
				 
	endgenerate 

	/////////////////////////
	//group_decider
	/////////////////////////
	group_decider group_decider (
		.i_5_smallest_distances_group_bit (smallest_5_distances_group_bit),
		.o_group (group_pre_sample)
		);


	/////////////////////////
	//bitonic_sort
	/////////////////////////
	bitonic_sort bitonic_sort (
	.clk                                 (clk),
	.rst                                 (rst),
	.i_distance                          (distance),
	.i_sorting_indication                (sorting_indication),
	.i_clr_smallest_data_regs            (clr_smallest_data_regs),
	.o_5_smallest_distances_group_bit    (smallest_5_distances_group_bit)
	);

	/////////////////////////
	//controller
	/////////////////////////
	controller controller (
	.clk                     (clk),
	.rst                     (rst),
	.i_valid                 (i_valid),
	.i_data_type             (i_data_type),
	.i_train_points_update	 (i_train_points_update),
	.o_wr_rq                 (wr_rq),
	.o_wr_source             (wr_source),
	.o_wr_test_point_en      (test_point_wr_en),
	.o_sorting_indication    (sorting_indication),
	.o_clr_smallest_data_regs(clr_smallest_data_regs),
	.o_valid                 (valid_output_pre_sample),
	.o_busy                  (busy_pre_sample),
	.o_current_state         (o_current_state)
);


endmodule






