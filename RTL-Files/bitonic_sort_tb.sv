`timescale 1ns/1ps

module bitonic_sort_tb ();

	

	localparam REGSITER_SIZE = 11;

	logic clk;
	logic rst;
	logic [REGSITER_SIZE:0] distance [3:0];
	logic sorting_indication;
	logic clr_smallest_data_regs;
	logic [4:0] smallest_5_distances_group_bit_old;
	logic [4:0] smallest_5_distances_group_bit;
	
	
	initial begin 
		clk = 1'b0;
		forever #10ns begin 
			clk <= ~clk;
		end
	end
	
	initial begin 
			rst = 1'b1;
		#60ns	
			rst = 1'b0;
		#270ns
			rst = 1'b1;
	end
	

	
	initial begin
		distance [0] = 12'hfff;
		distance [1] = 12'hfff;
		distance [2] = 12'hfff;
		distance [3] = 12'hfff;
		clr_smallest_data_regs = 1'b0;
		sorting_indication = 1'b0;
		
		@(negedge rst);
		#5ns
		distance [0] = $urandom_range(0,4095);
		distance [1] = $urandom_range(0,4095);
		distance [2] = $urandom_range(0,4095);
		distance [3] = $urandom_range(0,4095);
		sorting_indication = 1'b1;
		
		#20ns
		distance [0] = $urandom_range(0,4095);
		distance [1] = $urandom_range(0,4095);
		distance [2] = $urandom_range(0,4095);
		distance [3] = $urandom_range(0,4095);
		sorting_indication = 1'b1;
		
		#20ns
		distance [0] = $urandom_range(0,4095);
		distance [1] = $urandom_range(0,4095);
		distance [2] = $urandom_range(0,4095);
		distance [3] = $urandom_range(0,4095);
		sorting_indication = 1'b1;
		
		#20ns 
		sorting_indication = 1'b0;

	
		end
		
	bitonic_sort bitonic_sort (
		.clk                                 (clk),
		.rst                                 (rst),
		.i_distance                          (distance),
		.i_sorting_indication                (sorting_indication),
		.i_clr_smallest_data_regs			 (clr_smallest_data_regs),
		.o_5_smallest_distances_group_bit    (smallest_5_distances_group_bit)
		);
	
	
	bitonic_sort_old bitonic_sort_old (
		.clk                                 (clk),
		.rst                                 (rst),
		.i_distance                          (distance),
		.i_sorting_indication                (sorting_indication),
		.i_clr_smallest_data_regs			 (clr_smallest_data_regs),
		.o_5_smallest_distances_group_bit    (smallest_5_distances_group_bit_old)
		);

endmodule

