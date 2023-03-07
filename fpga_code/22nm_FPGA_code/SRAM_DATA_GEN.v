`timescale 1ns / 10ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Christopher Elash - Revised May 31, 2021
// 
// Create Date:    10:33:27 05/12/2015 
// Design Name: 
// Module Name:    SRAM_DATA_GEN
// Project Name: 22nm SRAM Test
// Target Devices: 
// Tool versions: 
// Description: Data generator for 22nm SRAM Test
//
// Dependencies: None, other than a clock source
//
// Revision: 
// Revision 0.01 - Initial Release
// Additional Comments: Data Gen will choose what data to use for the test, and will loop through each memory address, assigned to a 15-bit number
//						It will also drive read and write enable for the SRAM. When write mode is active data gen will output a memory address for the SRAM to write the test data to.
//						When in read mode it will also output which address to read from.
//
//////////////////////////////////////////////////////////////////////////////////

module SRAM_DATA_GEN (
	 input reset,	// active low
	 input data,	// input line for data selection	 
	 input data_clk,	// clk for data input
	 output reg [7:0] SRAM_DATA_IN,
	 output reg [14:0] SRAM_ADDRESS_START,
	 output reg [14:0] SRAM_ADDRESS_END,
	 output reg [63:0] data_count
    );
	 
	 reg [7:0] sram_data_holder;
	 reg [14:0] sram_address_holder_start;
	 reg [14:0] sram_address_holder_end;
	 

	initial begin
		SRAM_DATA_IN <= 8'd0;
		SRAM_ADDRESS_START <= 15'd0;
		SRAM_ADDRESS_END <= 15'd0;
		data_count <= 64'd0;
	end

	// counter for how many data clks come in
	always @ (posedge data_clk)
		if (~reset)
			begin
				data_count <= 64'd0;
			end
		else
			begin
				data_count <= data_count + 1'b1;	// increment count each time to keep track
			end

	// input for the data selection
	initial begin
		sram_data_holder <= 8'b00000000;
	end

	always @ (posedge data_clk)
		if (~reset)
			begin
				sram_data_holder <= 8'd0;
			end
		else if (data_count <= 64'd7)
			begin
				// now start loading data it into the SRAM input data holder
				sram_data_holder[0] <= data;
				sram_data_holder[1] <= sram_data_holder[0];
				sram_data_holder[2] <= sram_data_holder[1];
				sram_data_holder[3] <= sram_data_holder[2];
				sram_data_holder[4] <= sram_data_holder[3];
				sram_data_holder[5] <= sram_data_holder[4];
				sram_data_holder[6] <= sram_data_holder[5];
				sram_data_holder[7] <= sram_data_holder[6];
			end
		else if (data_count == 32'd38)	// when data is all written in including data and address and C, output
			begin
				SRAM_DATA_IN <= sram_data_holder;
			end
		else
			begin
				SRAM_DATA_IN <= SRAM_DATA_IN;
			end

	
	// now do the input for the start address location
	initial begin
		sram_address_holder_start <= 15'd0;
	end

	always @ (posedge data_clk)
		if (~reset)
			begin
				sram_address_holder_start <= 15'd0;
			end
		else if ((data_count >= 32'd8) && (data_count <= 32'd22))
			begin
				// now load address in
				sram_address_holder_start[0] <= data;
				sram_address_holder_start[1] <= sram_address_holder_start[0];
				sram_address_holder_start[2] <= sram_address_holder_start[1];
				sram_address_holder_start[3] <= sram_address_holder_start[2];
				sram_address_holder_start[4] <= sram_address_holder_start[3];
				sram_address_holder_start[5] <= sram_address_holder_start[4];
				sram_address_holder_start[6] <= sram_address_holder_start[5];
				sram_address_holder_start[7] <= sram_address_holder_start[6];
				sram_address_holder_start[8] <= sram_address_holder_start[7];
				sram_address_holder_start[9] <= sram_address_holder_start[8];
				sram_address_holder_start[10] <= sram_address_holder_start[9];
				sram_address_holder_start[11] <= sram_address_holder_start[10];
				sram_address_holder_start[12] <= sram_address_holder_start[11];
				sram_address_holder_start[13] <= sram_address_holder_start[12];
				sram_address_holder_start[14] <= sram_address_holder_start[13];
			end
		else if (data_count == 32'd38)	// when data is all written in including data and address and C, output
			begin
				SRAM_ADDRESS_START <= sram_address_holder_start;
			end
		else
			begin
				SRAM_ADDRESS_START <= SRAM_ADDRESS_START;
			end
		
		

	// input for address end location
	initial begin
		sram_address_holder_end <= 15'd0;
	end

	always @ (posedge data_clk)
		if (~reset)
			begin
				sram_address_holder_end <= 15'd0;
			end
		else if ((data_count >= 32'd23) && (data_count <= 32'd37))
			begin
					// now load address in
					sram_address_holder_end[0] <= data;
					sram_address_holder_end[1] <= sram_address_holder_end[0];
					sram_address_holder_end[2] <= sram_address_holder_end[1];
					sram_address_holder_end[3] <= sram_address_holder_end[2];
					sram_address_holder_end[4] <= sram_address_holder_end[3];
					sram_address_holder_end[5] <= sram_address_holder_end[4];
					sram_address_holder_end[6] <= sram_address_holder_end[5];
					sram_address_holder_end[7] <= sram_address_holder_end[6];
					sram_address_holder_end[8] <= sram_address_holder_end[7];
					sram_address_holder_end[9] <= sram_address_holder_end[8];
					sram_address_holder_end[10] <= sram_address_holder_end[9];
					sram_address_holder_end[11] <= sram_address_holder_end[10];
					sram_address_holder_end[12] <= sram_address_holder_end[11];
					sram_address_holder_end[13] <= sram_address_holder_end[12];
					sram_address_holder_end[14] <= sram_address_holder_end[13];
				end
		else if (data_count == 32'd38)	// when data is all written in including data and address and C, output
			begin
				SRAM_ADDRESS_END <= sram_address_holder_end;
			end
		else
			begin
				SRAM_ADDRESS_END <= SRAM_ADDRESS_END;
			end
			
	
	/*
	// input for NS_DAT_CTL
	initial begin
		NS_DAT_CTL_holder <= 2'd0;
	end

	always @ (posedge data_clk)
		if (~reset)
			begin
				NS_DAT_CTL_holder <= 2'd0;
			end
		else if ((data_count >= 32'd38) && (data_count <= 32'd39))
			begin
					// now load the data in for C
					NS_DAT_CTL_holder[0] <= data;
					NS_DAT_CTL_holder[1] <= NS_DAT_CTL_holder[0];
				end
		else if (data_count == 32'd40)	// when data is all written in including data and address and C, output
			begin
				NS_DAT_CTL <= NS_DAT_CTL_holder;
			end
		else
			begin
				NS_DAT_CTL <= NS_DAT_CTL;
			end
			*/	
		
endmodule
