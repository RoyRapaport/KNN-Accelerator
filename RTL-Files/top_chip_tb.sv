`timescale 1ns/1ps


module top_chip_tb ();



	logic clk;
	logic rst;
	logic [10:0] i_x; 
	logic [9:0] i_y;
	logic i_valid;
	logic i_data_type;
	logic i_train_points_update;
	logic o_valid;
	logic o_group;
	logic [2:0] o_current_state;
	logic o_inverter;
	logic o_ff;
	logic o_busy;
	
	logic o_valid_old;
	logic o_group_old;
	logic [2:0] o_current_state_old;
	logic o_inverter_old;
	logic o_ff_old;
	logic o_busy_old;
	

	reg [15:0] x_memory [127:0];
	reg [15:0] y_memory [127:0];
	
	initial begin
		$readmemh("x.mem", x_memory);
		$readmemh("y.mem", y_memory);
	end

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
		#13000ns
			rst = 1'b1;
	end





/////////
//11_th//
/////////


		initial begin 
			i_x = 11'b0;
			i_y = 11'b0;
			i_valid = 1'b0;
			i_data_type = 1'b0;
			i_train_points_update = 1'b0;
			
			@(negedge rst);
			#1ns
	
			for (int i = 0; i < 140; i++) begin
				@(negedge clk);
				i_x = i;
				i_y = i;
				i_valid = 1'b1;
				i_data_type = 1'b0;
			end
			for (int i = 0; i < 4; i++) begin
				@(negedge clk);
				i_x = 2000 + i;
				i_y = 2000 + i;
				i_valid = 1'b1;
				i_data_type = 1'b0;
			end
			
			@(negedge clk);
			i_valid = 1'b0;
			#80ns
					
			@(negedge clk);
			i_x = 11'd1010;
			i_y = 11'd1010;
			i_valid = 1'b1;
			i_data_type = 1'b1;
			
			
			@(negedge clk);
			i_valid = 1'b0;
			#60ns 
			
					
			i_train_points_update = 1'b1;		
			#700ns
					
			i_train_points_update = 1'b0;
			
			for (int i = 0; i < 124; i++) begin
				@(negedge clk);
				i_x = 300 + i;
				i_y = 300 + i;
				i_valid = 1'b1;
				i_data_type = 1'b0;
			end
			for (int i = 0; i < 4; i++) begin
				@(negedge clk);
				i_x = 2010 + i;
				i_y = 2010 + i;
				i_valid = 1'b1;
				i_data_type = 1'b0;
			end
			
			@(negedge clk);
			i_valid = 1'b0;
			#800ns 
					
			i_train_points_update = 1'b1;
			i_x = 11'd800;
			i_y = 11'd800;
			i_valid = 1'b1;
			i_data_type = 1'b1;
			#1ns
					
			@(negedge clk);
			i_valid = 1'b0;
			i_train_points_update = 1'b0;
					
			for (int i = 0; i < 124; i++) begin
				@(negedge clk);
				i_x = 500 + i;
				i_y = 500 + i;
				i_valid = 1'b1;
				i_data_type = 1'b0;
			end
			for (int i = 0; i < 4; i++) begin
				@(negedge clk);
				i_x = 2020 + i;
				i_y = 2020 + i;
				i_valid = 1'b1;
				i_data_type = 1'b0;
			end		
			
			@(negedge clk);
			i_valid = 1'b0;	
			#700ns 
		
			i_train_points_update = 1'b1;
			i_x = 11'd700;
			i_y = 11'd700;
			i_valid = 1'b1;
			i_data_type = 1'b0;
			#1ns
					
			@(negedge clk);
			i_valid = 1'b0;	
			i_train_points_update = 1'b0;
			
		end



/////////
//10_th//
/////////

//	initial begin 
//		i_x = 11'b0;
//		i_y = 11'b0;
//		i_valid = 1'b0;
//		i_data_type = 1'b0;
//		i_train_points_update = 1'b0;
//		
//		@(negedge rst);
//		#1ns
//
//		for (int i = 0; i < 140; i++) begin
//			@(negedge clk);
//			i_x = i;
//			i_y = i;
//			i_valid = 1'b1;
//			i_data_type = 1'b0;
//		end
//		for (int i = 0; i < 4; i++) begin
//			@(negedge clk);
//			i_x = 2000 + i;
//			i_y = 2000 + i;
//			i_valid = 1'b1;
//			i_data_type = 1'b0;
//		end
//		
//		@(negedge clk);
//		i_valid = 1'b0;
//		#80ns
//				
//		@(negedge clk);
//		i_x = 11'd1010;
//		i_y = 11'd1010;
//		i_valid = 1'b1;
//		i_data_type = 1'b1;
//		
//		
//		@(negedge clk);
//		i_valid = 1'b0;
//		#60ns 
//		
//				
//		i_train_points_update = 1'b1;		
//		#700ns
//				
//		i_train_points_update = 1'b0;
//		
//		for (int i = 0; i < 124; i++) begin
//			@(negedge clk);
//			i_x = 300 + i;
//			i_y = 300 + i;
//			i_valid = 1'b1;
//			i_data_type = 1'b0;
//		end
//		for (int i = 0; i < 4; i++) begin
//			@(negedge clk);
//			i_x = 2010 + i;
//			i_y = 2010 + i;
//			i_valid = 1'b1;
//			i_data_type = 1'b0;
//		end
//		
//		@(negedge clk);
//		i_valid = 1'b0;
//		#660ns 
//				
//		i_train_points_update = 1'b1;
//		i_x = 11'd800;
//		i_y = 11'd800;
//		i_valid = 1'b1;
//		i_data_type = 1'b1;
//		#1ns
//				
//		@(negedge clk);
//		i_valid = 1'b0;
//		i_train_points_update = 1'b0;
//		
//		
//	end


////////
//9_th//
////////

//	initial begin 
//		i_x = 11'b0;
//		i_y = 11'b0;
//		i_valid = 1'b0;
//		i_data_type = 1'b0;
//		i_train_points_update = 1'b0;
//		
//		@(negedge rst);
//		#1ns
//
//		for (int i = 0; i < 140; i++) begin
//			@(negedge clk);
//			i_x = i;
//			i_y = i;
//			i_valid = 1'b1;
//			i_data_type = 1'b0;
//		end
//		for (int i = 0; i < 4; i++) begin
//			@(negedge clk);
//			i_x = 2000 + i;
//			i_y = 2000 + i;
//			i_valid = 1'b1;
//			i_data_type = 1'b0;
//		end
//		
//		@(negedge clk);
//		i_valid = 1'b0;
//		#80ns
//				
//		@(negedge clk);
//		i_x = 11'd1010;
//		i_y = 11'd1010;
//		i_valid = 1'b1;
//		i_data_type = 1'b1;
//		
//		
//		@(negedge clk);
//		i_valid = 1'b0;
//
//		
//	end



////////
//8_th//
////////


//	initial begin 
//		i_x = 11'b0;
//		i_y = 11'b0;
//		i_valid = 1'b0;
//		i_data_type = 1'b0;
//		i_train_points_update = 1'b0;
//		
//		@(negedge rst);
//		#1ns
//				
//		i_x = 11'd1010;
//		i_y = 11'd1010;
//		i_valid = 1'b1;
//		i_data_type = 1'b1;
//
//
//		for (int i = 0; i < 140; i++) begin
//			@(negedge clk);
//			i_x = i;
//			i_y = i;
//			i_valid = 1'b1;
//			i_data_type = 1'b0;
//		end
//		for (int i = 0; i < 4; i++) begin
//			@(negedge clk);
//			i_x = 2000 + i;
//			i_y = 2000 + i;
//			i_valid = 1'b1;
//			i_data_type = 1'b0;
//		end
//		
//		@(negedge clk);
//		i_valid = 1'b0;
//		#100ns
//		
//		
//		@(negedge clk);
//		i_x = 11'd456;
//		i_y = 11'd456;
//		i_valid = 1'b1;
//		i_data_type = 1'b0;
//		#20ns
//		
//		@(negedge clk);
//		i_x = 11'd70;
//		i_y = 11'd70;
//		i_valid = 1'b1;
//		i_data_type = 1'b1;
//		#20ns
//	
//	
//		@(negedge clk);
//		i_valid = 1'b0;
//
//		
//	end


////////
//7_th//
////////

//	initial begin 
//		i_x = 11'b0;
//		i_y = 11'b0;
//		i_valid = 1'b0;
//		i_data_type = 1'b0;
//		i_train_points_update = 1'b0;
//		
//		@(negedge rst);
//		#1ns
//				
//		i_x = 11'd1010;
//		i_y = 11'd1010;
//		i_valid = 1'b1;
//		i_data_type = 1'b1;
//
//		
//		for (int i = 0; i < 4; i++) begin
//			@(negedge clk);
//			i_x = 2000 + i;
//			i_y = 2000 + i;
//			i_valid = 1'b1;
//			i_data_type = 1'b0;
//		end
//		for (int i = 0; i < 124; i++) begin
//			@(negedge clk);
//			i_x = i;
//			i_y = i;
//			i_valid = 1'b1;
//			i_data_type = 1'b0;
//		end
//		
//		
//		@(negedge clk);
//		i_valid = 1'b0;
//		#660ns
//		
//		
//		i_x = 11'd10;
//		i_y = 11'd10;
//		i_valid = 1'b1;
//		i_data_type = 1'b0;
//		
//		#1ns
//		@(negedge clk);
//		i_valid = 1'b0;
//
//		
//	end


////////
//6_th//
////////

//	initial begin 
//		i_x = 11'b0;
//		i_y = 11'b0;
//		i_valid = 1'b0;
//		i_data_type = 1'b0;
//		i_train_points_update = 1'b0;
//		
//		@(negedge rst);
//		#1ns
//				
//		i_x = 11'd1010;
//		i_y = 11'd1010;
//		i_valid = 1'b1;
//		i_data_type = 1'b1;
//
//
//		for (int i = 0; i < 124; i++) begin
//			@(negedge clk);
//			i_x = i;
//			i_y = i;
//			i_valid = 1'b1;
//			i_data_type = 1'b0;
//		end
//		for (int i = 0; i < 4; i++) begin
//			@(negedge clk);
//			i_x = 2000 + i;
//			i_y = 2000 + i;
//			i_valid = 1'b1;
//			i_data_type = 1'b0;
//		end
//		
//		@(negedge clk);
//		i_valid = 1'b0;
//		#660ns
//		
//		
//		i_x = 11'd10;
//		i_y = 11'd10;
//		i_valid = 1'b1;
//		i_data_type = 1'b1;
//		
//		#1ns
//		@(negedge clk);
//		i_valid = 1'b0;
//
//		
//	end

////////
//5_th//
////////

//	initial begin 
//		i_x = 11'b0;
//		i_y = 11'b0;
//		i_valid = 1'b0;
//		i_data_type = 1'b0;
//		i_train_points_update = 1'b0;
//		
//		@(negedge rst);
//		#1ns
//				
//		i_x = 11'd1010;
//		i_y = 11'd1010;
//		i_valid = 1'b1;
//		i_data_type = 1'b1;
//		
//		@(negedge clk);
//		i_valid = 1'b0;
//		#60ns
//
//		for (int i = 0; i < 124; i++) begin
//			@(negedge clk);
//			i_x = i;
//			i_y = i;
//			i_valid = 1'b1;
//			i_data_type = 1'b0;
//		end
//		for (int i = 0; i < 4; i++) begin
//			@(negedge clk);
//			i_x = 2000 + i;
//			i_y = 2000 + i;
//			i_valid = 1'b1;
//			i_data_type = 1'b0;
//		end
//		
//		@(negedge clk);
//		i_valid = 1'b0;
//
//		
//	end



////////
//4_th//
////////	

//	initial begin 
//		i_x = 11'b0;
//		i_y = 11'b0;
//		i_valid = 1'b0;
//		i_data_type = 1'b0;
//		i_train_points_update = 1'b0;
//		
//		@(negedge rst);
//		#1ns
//				
//		i_x = 11'd1010;
//		i_y = 11'd1010;
//		i_valid = 1'b1;
//		i_data_type = 1'b1;
//
//		for (int i = 0; i < 124; i++) begin
//			@(negedge clk);
//			i_x = i;
//			i_y = i;
//			i_valid = 1'b1;
//			i_data_type = 1'b0;
//		end
//		for (int i = 0; i < 4; i++) begin
//			@(negedge clk);
//			i_x = 2000 + i;
//			i_y = 2000 + i;
//			i_valid = 1'b1;
//			i_data_type = 1'b0;
//		end
//		
//		@(negedge clk);
//		i_valid = 1'b0;
//
//		
//	end
	
	
////////
//3_rd//
////////	
	

//	initial begin 
//		i_x = 11'b0;
//		i_y = 11'b0;
//		i_valid = 1'b0;
//		i_data_type = 1'b0;
//		i_train_points_update = 1'b0;
//		
//		@(negedge rst);
//		#1ns
//		for (int i = 0; i < 124; i++) begin
//			@(negedge clk);
//			i_x = i;
//			i_y = i;
//			i_valid = 1'b1;
//			i_data_type = 1'b0;
//		end
//		for (int i = 0; i < 4; i++) begin
//			@(negedge clk);
//			i_x = 2000 + i;
//			i_y = 2000 + i;
//			i_valid = 1'b1;
//			i_data_type = 1'b0;
//		end
//		
//		@(negedge clk);
//		i_valid = 1'b0;
//		#60ns
//		
//		@(negedge clk);
//		i_x = 11'd1010;
//		i_y = 11'd1010;
//		i_valid = 1'b1;
//		i_data_type = 1'b1;
//		
//		@(negedge clk);
//		i_valid = 1'b0;
//		
//	end


////////
//2_nd//
////////


//	initial begin 
//		i_x = 11'b0;
//		i_y = 11'b0;
//		i_valid = 1'b0;
//		i_data_type = 1'b0;
//		i_train_points_update = 1'b0;
//		
//		@(negedge rst);
//		#1ns
//		for (int i = 0; i < 124; i++) begin
//			@(negedge clk);
//			i_x = i;
//			i_y = i;
//			i_valid = 1'b1;
//			i_data_type = 1'b0;
//		end
//		for (int i = 0; i < 4; i++) begin
//			@(negedge clk);
//			i_x = 2000 + i;
//			i_y = 2000 + i;
//			i_valid = 1'b1;
//			i_data_type = 1'b0;
//		end
//		
//		
//		@(negedge clk);
//		i_x = 11'd1010;
//		i_y = 11'd1010;
//		i_data_type = 1'b1;
//		
//		@(negedge clk);
//		i_valid = 1'b0;
//		
//	end


////////
//1_st//
////////

//	initial begin 
//		i_x = 11'b0;
//		i_y = 11'b0;
//		i_valid = 1'b0;
//		i_data_type = 1'b0;
//		i_train_points_update = 1'b0;
//		
//		@(negedge rst);
//		#1ns
//		for (int i = 0; i < 128; i++) begin
//			@(negedge clk);
//			i_x = x_memory[i][10:0];
//			i_y = y_memory[i][10:0];
//			i_valid = 1'b1;
//			i_data_type = 1'b0;
//		end
//		
//		@(negedge clk);
//		i_x = 11'd623;
//		i_y = 11'd385;
//		i_data_type = 1'b1;
//		
//		@(negedge clk);
//		i_valid = 1'b0;
//		
//	end
	

top_chip u_top_chip (
	.clk                	(clk),
	.rst                	(rst),
	.i_x                	(i_x),
	.i_y                	(i_y),
	.i_valid            	(i_valid),
	.i_data_type        	(i_data_type),
	.i_train_points_update  (i_train_points_update),
	.o_valid            	(o_valid),
	.o_group            	(o_group),
	.o_current_state    	(o_current_state),
	.o_inverter         	(o_inverter),
	.o_ff               	(o_ff),
	.o_busy             	(o_busy)
);

//top_chip_old u_top_chip_old (
	//.clk                	(clk),
	//.rst                	(rst),
	//.i_x                	(i_x),
	//.i_y                	(i_y),
	//.i_valid            	(i_valid),
	//.i_data_type        	(i_data_type),
	//.i_train_points_update  (i_train_points_update),
	//.o_valid            	(o_valid_old),
	//.o_group            	(o_group_old),
	//.o_current_state    	(o_current_state_old),
	//.o_inverter         	(o_inverter_old),
//	.o_ff               	(o_ff_old),
//	.o_busy             	(o_busy_old)
//);



endmodule


















