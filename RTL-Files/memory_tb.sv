`timescale 1ns/1ps

module memory_tb ();

	localparam REGSITER_SIZE = 11;

	logic rst;
	logic clk;
	logic [REGSITER_SIZE-1:0] i_x;
	logic [REGSITER_SIZE-2:0] i_y;
	logic wr_rq;
	logic wr_source;
	logic [REGSITER_SIZE-1:0] x_memory [3:0];
	logic [REGSITER_SIZE-2:0] y_memory [3:0];
	
	
	initial begin 
		clk = 1'b0;
		forever #10ns begin 
			clk <= ~clk;
		end
	end
	
	initial begin 
		rst = 1'b1;
	#50ns	
		rst = 1'b0;
	#5000ns
		rst = 1'b1;
	end
	
	
	
	initial begin 
		i_x = 11'b0;
		i_y = 11'b0;
		wr_rq = 1'b0;
		wr_source = 1'b0;
		
		@(negedge rst);
		wr_rq = 1'b1;
		wr_source = 1'b0;
		for (int i = 1; i < 129; i++) begin 
			@(negedge clk);
			i_x = i; 
			i_y = i;
		end
		wr_rq = 1'b0;
		
		#100ns 
		wr_rq = 1'b1;
		wr_source = 1'b1;
		#640ns
				
		wr_rq = 1'b0;
		
	end
	
	
	
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

	
endmodule