`timescale 1ns/1ps

module distance_calculator_tb ();


	localparam REGSITER_SIZE = 11;


	logic rst;
	logic clk; 
	logic [REGSITER_SIZE - 1:0] x_memory;
	logic [REGSITER_SIZE - 2:0] y_memory;
	logic [9:0] x_test_point_reg;
	logic [9:0] y_test_point_reg;
	logic [REGSITER_SIZE:0] distance;
	


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
		@(negedge rst);
		#5ns		
		x_memory = 11'd0; 
		y_memory = 11'd0;
		x_test_point_reg = 11'hfff;
		y_test_point_reg = 11'hfff;
		
		#20ns		
		x_memory = 11'hf00; 
		y_memory = 11'hf00;
		x_test_point_reg = 11'h0a0;
		y_test_point_reg = 11'h0c0;
		
		#20ns		
		x_memory = $urandom_range(0,2047); 
		y_memory = 11'd1234;
		x_test_point_reg = $urandom_range(0,2047);
		y_test_point_reg = $urandom_range(0,2047);
		
		
	end


	distance_calculator distance_calculator(
	.i_x_mem (x_memory),
	.i_y_mem (y_memory),
	.i_x_test_point (x_test_point_reg),
	.i_y_test_point (y_test_point_reg),
	.o_distance (distance)
	);


endmodule


