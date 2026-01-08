`timescale 1ns/1ps

module group_decider_tb ();

	
	logic clk;
	logic [4:0] smallest_5_distances_group_bit;
	logic o_group;
	
	
	initial begin 
		clk = 1'b0;
		forever #10ns begin 
			clk <= ~clk;
		end
	end
	
	initial begin
		smallest_5_distances_group_bit = 0;

		for (int i=0; i < 32; i = i+1) begin 
			@(posedge clk);
					smallest_5_distances_group_bit = i;
		end
		
		#7ns
				smallest_5_distances_group_bit = 5'b01010;
		#7ns 
				smallest_5_distances_group_bit = 5'b10101;
	end
	
	group_decider group_decider (
		.i_5_smallest_distances_group_bit (smallest_5_distances_group_bit),
		.o_group (o_group)
	);
	
endmodule