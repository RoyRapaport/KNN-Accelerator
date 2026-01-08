`timescale 1ns/1ps

module bitonic_sort_seq (
	input clk,
	input rst,
	input i_sorting_indication,
	input [11:0] i_distance [3:0],
	input i_clr_smallest_data_regs,
    input [11:0] smallest_data_register_in_value [4:0],
    output logic [11:0] smallest_data_register [4:0],
    output logic [11:0] data_register[3:0],
	output [4:0] o_5_smallest_distances_group_bit
);

localparam REGSITER_SIZE = 12;
localparam K = 5;
localparam NUM_OF_DISTANCE_CALCULATORS = 4;
localparam RST_VALUE = 12'd4095;



//logic [REGSITER_SIZE-1:0] smallest_data_register [K-1:0];
//logic [REGSITER_SIZE-1:0] data_register [NUM_OF_DISTANCE_CALCULATORS-1:0];
//logic [REGSITER_SIZE-1:0] smallest_data_register_in_value [K-1:0]; 
logic sorting_indication_delay;

//Delay of 1 clk cycle for the sorting indication - we use this one to write for the registers that hold the 5 smallest nums
always_ff @(posedge clk or posedge rst) begin
		if (rst) 
			sorting_indication_delay <= 1'b0;
		else 
			sorting_indication_delay <= i_sorting_indication;
end 



genvar i,j;
generate 
	for (i = 0; i < NUM_OF_DISTANCE_CALCULATORS; i = i+1) begin :  DATA_REGISTER_INIT
		always_ff @(posedge clk or posedge rst) begin
			if (rst) begin
				data_register[i] <= RST_VALUE;
			end
			else if (i_sorting_indication) begin
				data_register[i] <= i_distance[i];
			end
		end
	end
endgenerate

generate
	for (j = 0; j < K ; j = j+1) begin : SMALLEST_DATA_REGISTER_INIT
		always_ff @(posedge clk or posedge rst) begin
			if (rst) begin
				smallest_data_register[j] <= RST_VALUE;
			end
			else if (sorting_indication_delay) begin
				smallest_data_register[j] <= smallest_data_register_in_value[j];
			end
			else if (i_clr_smallest_data_regs) begin 
				smallest_data_register[j] <= RST_VALUE;	
			end
		
		end
	end
endgenerate




	//assign output

	assign o_5_smallest_distances_group_bit = ({smallest_data_register[0][11],
												smallest_data_register[1][11],
												smallest_data_register[2][11],
												smallest_data_register[3][11],
												smallest_data_register[4][11] });
	
	
	
endmodule
