`timescale 1ns/1ps

module bitonic_sort_comb (
    input [11:0] smallest_data_register [4:0],
    input [11:0] data_register [3:0],
	output [11:0] smallest_data_register_in_value [4:0]
);

localparam REGSITER_SIZE = 12;
localparam K = 5;
localparam NUM_OF_DISTANCE_CALCULATORS = 4;
localparam RST_VALUE = 12'd4095;



//logic [REGSITER_SIZE-1:0] smallest_data_register [K-1:0];
//logic [REGSITER_SIZE-1:0] data_register [NUM_OF_DISTANCE_CALCULATORS-1:0];
logic [REGSITER_SIZE-1:0] internal_mux_output1 [7:0];
logic [REGSITER_SIZE-1:0] internal_mux_output2 [7:0];
logic [REGSITER_SIZE-1:0] internal_mux_output3 [7:0];
logic [REGSITER_SIZE-1:0] internal_mux_output4 [7:0];
logic [REGSITER_SIZE-1:0] internal_mux_output5 [5:0]; 
logic [REGSITER_SIZE-1:0] internal_mux_output6 [1:0];
//logic [REGSITER_SIZE-1:0] smallest_data_register_in_value [K-1:0]; 
logic sorting_indication_delay;



	////////////////////////////
	//phase 1
	////////////////////////////
	// comparator 1.1 + 2 mux
	assign internal_mux_output1[0] = (smallest_data_register[0][10:0] < smallest_data_register[1][10:0]) ? smallest_data_register[0] : smallest_data_register[1]; // output is smaller
	assign internal_mux_output1[1] = (smallest_data_register[0][10:0] < smallest_data_register[1][10:0]) ? smallest_data_register[1] : smallest_data_register[0]; // output is bigger

	// comparator 1.2 + 2 mux
	assign internal_mux_output1[2] = (smallest_data_register[2][10:0] > smallest_data_register[3][10:0]) ? smallest_data_register[2] : smallest_data_register[3]; // output is bigger
	assign internal_mux_output1[3] = (smallest_data_register[2][10:0] > smallest_data_register[3][10:0]) ? smallest_data_register[3] : smallest_data_register[2]; // output is smaller

	// comparator 1.3 + 2 mux
	assign internal_mux_output1[4] = (smallest_data_register[4][10:0] < data_register[0][10:0]) ? smallest_data_register[4] : data_register[0]; // output is smaller
	assign internal_mux_output1[5] = (smallest_data_register[4][10:0] < data_register[0][10:0]) ? data_register[0] : smallest_data_register[4]; // output is bigger

	// comparator 1.4 + 2 mux
	assign internal_mux_output1[6] = (data_register[1][10:0] > data_register[2][10:0]) ? data_register[1] : data_register[2]; // output is bigger
	assign internal_mux_output1[7] = (data_register[1][10:0] > data_register[2][10:0]) ? data_register[2] : data_register[1]; // output is smaller


	////////////////////////////
	//phase 2 - upper 4
	////////////////////////////
	// comparator 2.1 + 2 mux
	assign internal_mux_output2[0] = (internal_mux_output1[0][10:0] < internal_mux_output1[2][10:0]) ? internal_mux_output1[0] : internal_mux_output1[2]; // output is smaller
	assign internal_mux_output2[1] = (internal_mux_output1[0][10:0] < internal_mux_output1[2][10:0]) ? internal_mux_output1[2] : internal_mux_output1[0]; // output is bigger

	// comparator 2.2 + 2 mux
	assign internal_mux_output2[2] = (internal_mux_output1[1][10:0] < internal_mux_output1[3][10:0]) ? internal_mux_output1[1] : internal_mux_output1[3]; // output is smaller
	assign internal_mux_output2[3] = (internal_mux_output1[1][10:0] < internal_mux_output1[3][10:0]) ? internal_mux_output1[3] : internal_mux_output1[1]; // output is bigger

	// comparator 2.5 + 2 mux
	assign internal_mux_output3[0] = (internal_mux_output2[0][10:0] < internal_mux_output2[2][10:0]) ? internal_mux_output2[0] : internal_mux_output2[2]; // output is smaller
	assign internal_mux_output3[1] = (internal_mux_output2[0][10:0] < internal_mux_output2[2][10:0]) ? internal_mux_output2[2] : internal_mux_output2[0]; // output is bigger

	// comparator 2.6 + 2 mux
	assign internal_mux_output3[2] = (internal_mux_output2[1][10:0] < internal_mux_output2[3][10:0]) ? internal_mux_output2[1] : internal_mux_output2[3]; // output is smaller
	assign internal_mux_output3[3] = (internal_mux_output2[1][10:0] < internal_mux_output2[3][10:0]) ? internal_mux_output2[3] : internal_mux_output2[1]; // output is bigger

   ////////////////////////////
   //phase 2 - lower 4
   ////////////////////////////
	// comparator 2.3 + 2 mux
	assign internal_mux_output2[4] = (internal_mux_output1[4][10:0] > internal_mux_output1[6][10:0]) ? internal_mux_output1[4] : internal_mux_output1[6]; // output is bigger
	assign internal_mux_output2[5] = (internal_mux_output1[4][10:0] > internal_mux_output1[6][10:0]) ? internal_mux_output1[6] : internal_mux_output1[4]; // output is smaller

	// comparator 2.4 + 2 mux
	assign internal_mux_output2[6] = (internal_mux_output1[5][10:0] > internal_mux_output1[7][10:0]) ? internal_mux_output1[5] : internal_mux_output1[7]; // output is bigger
	assign internal_mux_output2[7] = (internal_mux_output1[5][10:0] > internal_mux_output1[7][10:0]) ? internal_mux_output1[7] : internal_mux_output1[5]; // output is smaller

	// comparator 2.7 + 2 mux
	assign internal_mux_output3[4] = (internal_mux_output2[4][10:0] > internal_mux_output2[6][10:0]) ? internal_mux_output2[4] : internal_mux_output2[6]; // output is bigger
	assign internal_mux_output3[5] = (internal_mux_output2[4][10:0] > internal_mux_output2[6][10:0]) ? internal_mux_output2[6] : internal_mux_output2[4]; // output is smaller

	// comparator 2.8 + 2 mux
	assign internal_mux_output3[6] = (internal_mux_output2[5][10:0] > internal_mux_output2[7][10:0]) ? internal_mux_output2[5] : internal_mux_output2[7]; // output is bigger
	assign internal_mux_output3[7] = (internal_mux_output2[5][10:0] > internal_mux_output2[7][10:0]) ? internal_mux_output2[7] : internal_mux_output2[5]; // output is smaller


   ////////////////////////////
   //phase 3
   ////////////////////////////
	// comparator 3.1 + 2 mux
	assign internal_mux_output4[0] = (internal_mux_output3[0][10:0] < internal_mux_output3[4][10:0]) ? internal_mux_output3[0] : internal_mux_output3[4]; // output is smaller
	assign internal_mux_output4[1] = (internal_mux_output3[0][10:0] < internal_mux_output3[4][10:0]) ? internal_mux_output3[4] : internal_mux_output3[0]; // output is bigger

	// comparator 3.2 + 2 mux
	assign internal_mux_output4[2] = (internal_mux_output3[1][10:0] < internal_mux_output3[5][10:0]) ? internal_mux_output3[1] : internal_mux_output3[5]; // output is smaller
	assign internal_mux_output4[3] = (internal_mux_output3[1][10:0] < internal_mux_output3[5][10:0]) ? internal_mux_output3[5] : internal_mux_output3[1]; // output is bigger

	// comparator 3.3 + 2 mux
	assign internal_mux_output4[4] = (internal_mux_output3[2][10:0] < internal_mux_output3[6][10:0]) ? internal_mux_output3[2] : internal_mux_output3[6]; // output is smaller
	assign internal_mux_output4[5] = (internal_mux_output3[2][10:0] < internal_mux_output3[6][10:0]) ? internal_mux_output3[6] : internal_mux_output3[2]; // output is bigger

	// comparator 3.4 + 2 mux
	assign internal_mux_output4[6] = (internal_mux_output3[3][10:0] < internal_mux_output3[7][10:0]) ? internal_mux_output3[3] : internal_mux_output3[7]; // output is smaller
	assign internal_mux_output4[7] = (internal_mux_output3[3][10:0] < internal_mux_output3[7][10:0]) ? internal_mux_output3[7] : internal_mux_output3[3]; // output is bigger

	


	 // comparator 3.5 + 2 mux
	assign internal_mux_output5[0] = (internal_mux_output4[0][10:0] < internal_mux_output4[4][10:0]) ? internal_mux_output4[0] : internal_mux_output4[4]; // output is smaller
	assign internal_mux_output5[1] = (internal_mux_output4[0][10:0] < internal_mux_output4[4][10:0]) ? internal_mux_output4[4] : internal_mux_output4[0]; // output is bigger

	// comparator 3.6 + 2 mux
	assign internal_mux_output5[2] = (internal_mux_output4[2][10:0] < internal_mux_output4[6][10:0]) ? internal_mux_output4[2] : internal_mux_output4[6]; // output is smaller
	assign internal_mux_output5[3] = (internal_mux_output4[2][10:0] < internal_mux_output4[6][10:0]) ? internal_mux_output4[6] : internal_mux_output4[2]; // output is bigger

	// comparator 3.7 + 1 mux
	assign internal_mux_output5[4] = (internal_mux_output4[1][10:0] < internal_mux_output4[5][10:0]) ? internal_mux_output4[1] : internal_mux_output4[5]; // output is smaller

	// comparator 3.8 + 1 mux
	assign internal_mux_output5[5] = (internal_mux_output4[3][10:0] < internal_mux_output4[7][10:0]) ? internal_mux_output4[3] : internal_mux_output4[7]; // output is smaller



	// comparator 3.11 + 1 mux
	assign internal_mux_output6[0] = (internal_mux_output5[4][10:0] < internal_mux_output5[5][10:0]) ? internal_mux_output5[4] : internal_mux_output5[5]; // output is smaller
	

   ////////////////////////////
   //phase 4
   ////////////////////////////
	// comparator 4.1 + 1 mux
	assign internal_mux_output6[1] = (internal_mux_output6[0][10:0] < data_register[3][10:0]) ? internal_mux_output6[0] : data_register[3]; // output is smaller



		//assign smallest_data_register_in_value
		assign smallest_data_register_in_value[0] = internal_mux_output5[0];
		assign smallest_data_register_in_value[1] = internal_mux_output5[1];
		assign smallest_data_register_in_value[2] = internal_mux_output5[2];
		assign smallest_data_register_in_value[3] = internal_mux_output5[3];
		assign smallest_data_register_in_value[4] = internal_mux_output6[1];


	//assign output

//	assign o_5_smallest_distances_group_bit = ({smallest_data_register[0][11],
												//smallest_data_register[1][11],
												//smallest_data_register[2][11],
												//smallest_data_register[3][11],
												//smallest_data_register[4][11] });
	
	
	
endmodule
