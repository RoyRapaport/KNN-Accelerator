`timescale 1ns/1ps

module controller_tb ();

	logic clk;
	logic rst;
	logic i_valid;
	logic i_data_type;
	logic i_train_points_update;
	logic o_wr_rq;
	logic o_wr_source;
	logic o_wr_test_point_en;
	logic o_sorting_indication;
	logic o_valid;
	logic o_busy;
	logic [2:0] o_current_state;

	
	
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
		#8000ns
			rst = 1'b1;
	end



	initial begin 
		i_valid = 1'b0;
		i_data_type = 1'b0;
		
			@(negedge rst);
			i_valid = 1'b1;
			i_data_type = 1'b1;
			#1ns
			
			for (int i = 0; i < 128; i++) begin
				@(negedge clk);
				i_valid = 1'b1;
				i_data_type = 1'b0;
			end	
			
			@(negedge clk);	
			i_valid = 1'b0;
			
			#100ns
			i_valid = 1'b1;
			i_data_type = 1'b1;
			#1ns
			
			@(negedge clk);	
			i_valid = 1'b0;
			
			#40ns 
			i_valid = 1'b1;
			i_data_type = 1'b0;	
			#1ns
			
			@(negedge clk);	
			i_valid = 1'b0;
			i_data_type = 1'b1;
			
			#480ns
			i_valid = 1'b1;
			#1ns
					
			@(negedge clk);	
			i_valid = 1'b0;
			i_data_type = 1'b0;	
			
			#640ns
			i_valid = 1'b1;
			
			#61ns
			
			@(negedge clk);	
			i_valid = 1'b0;
					
	
				
	end
	



//		@(negedge rst);
//		i_valid = 1'b1;
//		i_data_type = 1'b1;
//		
//		for (int i = 0; i < 128; i++) begin
//			@(negedge clk);
//			i_valid = 1'b1;
//			i_data_type = 1'b0;
//		end	
//		
//		@(negedge clk);	
//		i_valid = 1'b0;





	
//	@(negedge rst);
//	i_valid = 1'b1;
//	i_data_type = 1'b1;
//	#1ns
//	
//	for (int i = 0; i < 128; i++) begin
//		@(negedge clk);
//		i_valid = 1'b1;
//		i_data_type = 1'b0;
//	end	
//	
//	@(negedge clk);	
//	i_valid = 1'b0;
//	
//	#100ns
//	i_valid = 1'b1;
//	i_data_type = 1'b1;
//	#1ns
//	
//	@(negedge clk);	
//	i_valid = 1'b0;
//	
//	#40ns 
//	i_valid = 1'b1;
//	i_data_type = 1'b0;	
//	#1ns
//	
//	@(negedge clk);	
//	i_valid = 1'b0;
//	i_data_type = 1'b1;
//	
//	#480ns
//	i_valid = 1'b1;
//	#1ns
//			
//	@(negedge clk);	
//	i_valid = 1'b0;
//	i_data_type = 1'b0;	
//	
//	#640ns
//	i_valid = 1'b1;
//	
//	#61ns
//	
//	@(negedge clk);	
//	i_valid = 1'b0;
//			
//end


	
//	@(negedge rst);
//	#1ns
//	for (int i = 0; i < 70; i++) begin
//		@(negedge clk);
//		i_valid = 1'b1;
//		i_data_type = 1'b0;
//	end	
//	
//	
//	@(negedge clk);	
//	i_valid = 1'b0;
//	#100ns
//	
//	@(negedge clk);
//	i_valid = 1'b1;
//	i_data_type = 1'b1;
//	
//	
//	@(negedge clk);	
//	i_valid = 1'b0;
//	#100ns
//	
//	for (int i = 0; i < 70; i++) begin
//		@(negedge clk);
//		i_valid = 1'b1;
//		i_data_type = 1'b0;
//	end	
//	
//	@(negedge clk);	
//	i_valid = 1'b0;
//	
			
	
			
//	
//	@(negedge rst);
//	#1ns
//	for (int i = 0; i < 140; i++) begin
//		@(negedge clk);
//		i_valid = 1'b1;
//		i_data_type = 1'b0;
//	end	
//	
//	
//	@(negedge clk);	
//	i_valid = 1'b0;
//	#100ns
//	
//	@(negedge clk);
//	i_valid = 1'b1;
//	i_data_type = 1'b1;
//	
//	
//	@(negedge clk);	
//	i_valid = 1'b0;
//				
	

	controller controller(
		.clk                     (clk),
		.rst                     (rst),
		.i_valid                 (i_valid),
		.i_data_type             (i_data_type),
		.i_train_points_update	 (i_train_points_update),
		.o_wr_rq                 (o_wr_rq),
		.o_wr_source             (o_wr_source),
		.o_wr_test_point_en      (o_wr_test_point_en),
		.o_sorting_indication    (o_sorting_indication),
		.o_valid                 (o_valid),
		.o_busy                  (o_busy),
		.o_current_state         (o_current_state)
		);
		
		

endmodule













