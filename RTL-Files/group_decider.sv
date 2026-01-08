`timescale 1ns/1ps


module group_decider (
	input [4:0] i_5_smallest_distances_group_bit,
	
	output logic o_group
	);
	
	
	localparam NUM_OF_BITS = 5;
	localparam COMPARATOR_THRESHOLD = 3'd2;
	logic [2:0] sum;
	
	
	assign sum = i_5_smallest_distances_group_bit[0]+
				 i_5_smallest_distances_group_bit[1]+
				 i_5_smallest_distances_group_bit[2]+
				 i_5_smallest_distances_group_bit[3]+
				 i_5_smallest_distances_group_bit[4];
	

	always_comb begin 
		if (sum > COMPARATOR_THRESHOLD) 
			o_group = 1'b1;
		else 
			o_group = 1'b0;
	end		
		
endmodule		