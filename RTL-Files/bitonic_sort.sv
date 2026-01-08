`timescale 1ns/1ps

module bitonic_sort (
	input clk,
	input rst,
	input i_sorting_indication,
	input [11:0] i_distance [3:0],
	input i_clr_smallest_data_regs,

	output [4:0] o_5_smallest_distances_group_bit
);

localparam REGSITER_SIZE = 12;
localparam K = 5;
localparam NUM_OF_DISTANCE_CALCULATORS = 4;
localparam RST_VALUE = 12'd4095;

logic [REGSITER_SIZE-1:0] smallest_data_register [K-1:0];
logic [REGSITER_SIZE-1:0] data_register [NUM_OF_DISTANCE_CALCULATORS-1:0];
logic [REGSITER_SIZE-1:0] smallest_data_register_in_value [K-1:0];
logic sorting_indication_delay;


bitonic_sort_seq bitonic_sort_seq (
	.clk                                 (clk),
	.rst                                 (rst),
	.i_sorting_indication				 (i_sorting_indication),
	.i_distance							 (i_distance),
	.i_clr_smallest_data_regs            (i_clr_smallest_data_regs),
	.smallest_data_register_in_value     (smallest_data_register_in_value),
	.smallest_data_register              (smallest_data_register),
	.data_register                       (data_register),
	.o_5_smallest_distances_group_bit    (o_5_smallest_distances_group_bit)
	
	);


bitonic_sort_comb bitonic_sort_comb (
	.smallest_data_register              (smallest_data_register),
	.data_register                       (data_register),
	.smallest_data_register_in_value     (smallest_data_register_in_value)
	
	);
//bitonic_sort_only_ff U1(.*);
//bs_no_ff U2(.*);
	
endmodule
