`timescale 1ns/1ps

module distance_calculator (
	input [10:0] i_x_mem,
	input [9:0] i_y_mem,		
	input [9:0] i_x_test_point,	
	input [9:0] i_y_test_point,	
	
	output [11:0] o_distance
	);
	
	
	logic [10:0] x_sub;
	logic [10:0] y_sub;
	logic [10:0] manhattan_distance;
		
		
	assign x_sub = i_x_mem[9:0] > i_x_test_point ? i_x_mem[9:0] - i_x_test_point : i_x_test_point - i_x_mem[9:0]; //TODO: problem may be exist with negative numbers
	assign y_sub = i_y_mem > i_y_test_point ? i_y_mem - i_y_test_point : i_y_test_point - i_y_mem;
	assign manhattan_distance = x_sub + y_sub;
	
	assign o_distance = {i_x_mem[10], manhattan_distance}; 
	
endmodule