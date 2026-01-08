`timescale 1ns/1ps

module memory(
	input clk,
	input rst,                   
	input [10:0] i_x,
	input [9:0] i_y,
	input i_wr_rq,
	input i_wr_source,
					
	output [10:0] o_x_out0,
	output [10:0] o_x_out1,
	output [10:0] o_x_out2,
	output [10:0] o_x_out3, 
	output [9:0] o_y_out0,
	output [9:0] o_y_out1,
	output [9:0] o_y_out2,
	output [9:0] o_y_out3
	);

	//Local parameters:
	localparam RST_VALUE = 11'd0;
	localparam REGSITER_SIZE = 11;
	localparam NUM_OF_REGISTERS = 128;

	//logic declaration
	logic [REGSITER_SIZE-1:0] x_regs [NUM_OF_REGISTERS-1:0];
	logic [REGSITER_SIZE-2:0] y_regs [NUM_OF_REGISTERS-1:0];

	genvar i;

	always_ff @(posedge clk or posedge rst) 
		begin
			if (rst) begin 
				x_regs[0] <= RST_VALUE;
				y_regs[0] <= RST_VALUE;
			end
			else if (i_wr_rq & ~i_wr_source) begin 
				x_regs[0] <= i_x;
				y_regs[0] <= i_y;
			end	
			else if (i_wr_rq & i_wr_source) begin
				x_regs[0] <= x_regs [124];
				y_regs[0] <= y_regs [124];
			end	
		end

	for (i = 1; i < NUM_OF_REGISTERS ; i = i + 1)
		always_ff @(posedge clk or posedge rst) 
		begin
			if (rst) begin 
				x_regs[i] <= RST_VALUE;
				y_regs[i] <= RST_VALUE;
			end	
			else if (i_wr_rq & ~i_wr_source) begin 
				x_regs[i] <= x_regs[i-1];
				y_regs[i] <= y_regs[i-1];
			end	
			else if (i_wr_rq & i_wr_source) begin 
				x_regs[i] <= x_regs[(i + NUM_OF_REGISTERS -4) % 128];
				y_regs[i] <= y_regs[(i + NUM_OF_REGISTERS -4) % 128];
			end	
		end
	
	assign  o_x_out0 = x_regs[124];
	assign  o_x_out1 = x_regs[125];
	assign  o_x_out2 = x_regs[126];
	assign  o_x_out3 = x_regs[127];

	assign  o_y_out0 = y_regs[124];
	assign  o_y_out1 = y_regs[125];
	assign  o_y_out2 = y_regs[126];
	assign  o_y_out3 = y_regs[127];


	generate 
		genvar j; 
		for(j = 0; j < NUM_OF_REGISTERS - 1; j++) begin: WRITE_GEN_ASSERT 
			property valid_write_phase; 
				@(posedge clk) disable iff (rst)
						(!i_wr_source & i_wr_rq) |-> (x_regs[j+1] == $past(x_regs[j]) & y_regs[j+1] == $past(y_regs[j])); 
			endproperty 
			WRITE_PHASE_ASSERT: assert property (valid_write_phase) else $display("Error: Register[%0d] did not get the value of Register[%0d]", j+1, j); 
		end 
	endgenerate
	
	generate 
		genvar k; 
		for(k = 0; k < NUM_OF_REGISTERS; k++) begin: READ_GEN_ASSERT 
			property valid_read_phase; 
				@(posedge clk) disable iff (rst)
						(i_wr_source & i_wr_rq) |=> (x_regs[k] == $past(x_regs[(k + NUM_OF_REGISTERS -4) % 128]) & y_regs[k] == $past(y_regs[(k + NUM_OF_REGISTERS -4) % 128])); 
			endproperty 
			READ_PHASE_ASSERT: assert property (valid_read_phase) else $display("Error: Register[%0d] did not get the value of Register[%0d]", k, ((k + NUM_OF_REGISTERS -4) % 128)); 
		end 
	endgenerate

endmodule
