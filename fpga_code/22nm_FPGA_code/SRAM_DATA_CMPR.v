`timescale 1ns / 10ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Christopher Elash - Revised May 31, 2021
// 
// Create Date:    10:33:27 05/12/2015 
// Design Name: 
// Module Name:    SRAM_DATA_CMPR
// Project Name: 22nm SRAM Test
// Target Devices: 
// Tool versions: 
// Description: Data comparitor for 22nm SRAM Test
//
// Dependencies: None, other than clock source
//
// Revision: 
// Revision 0.01 - Initial Release
// Additional Comments: Data compare will compare that data that is being read from the SRAM with what the expected data should be. If there is an error it will raise a flag.
//						It will also keep track of how many errors occured. Note that it will only count errors while in read mode. When in write mode the errors will show up as 0.
//
//////////////////////////////////////////////////////////////////////////////////

module SRAM_DATA_CMPR (
	 input CLK, 		// 1 MHz clock
	 input sram_data_clk,	// clk to read data Q out from sram
	 input reset,	// active low
	 input clear_error, //active clear error signal from sram
	 input [63:0] data_count,		// data count to keep track of how many clocks
	 input [7:0] SRAM_DATA_IN,
	 input [7:0] SRAM_DATA_OUT,
	 input [14:0] SRAM_ADDRESS_START,		// the starting address
	 input [14:0] SRAM_ADDRESS_END,			// the ending address
	 output reg [14:0] SRAM_ADDRESS,				// the current address location
	 output reg error,		// error flag to pi to indicate if an error has been found
	 output reg sram_data_pi,
	 output reg RDWEN
    );
	 
	 initial begin
		error <= 1'b0;
		SRAM_ADDRESS <= 15'd0;
		sram_data_pi <= 1'b1;
	end

	// check for the error flag and save data registers at error location
	reg [7:0] DATA_IN_HOLDER;
	reg [7:0] DATA_OUT_HOLDER;
	reg [14:0] ADDRESS_HOLDER;
	
	
	reg [15:0] test_data_counter;	// counter to check to see if all addresses have been written
	reg test_data_written;	// flag to check if all test data written has been written
	
	
	initial begin
		test_data_counter <= 16'd0;
		test_data_written <= 1'b0;
		
	end
	
	// block to control address selection
	always @ (posedge CLK)
		if (~reset)
			begin
				SRAM_ADDRESS <= 15'd0;
			end
		else if (data_count == 64'd38)	// load start address in sram
			begin
				SRAM_ADDRESS <= SRAM_ADDRESS_START;
			end
		else if (data_count >= 64'd39)	// if data count if 39 then begin the process of looking through the addresses
			if (SRAM_ADDRESS == SRAM_ADDRESS_END)
				begin
					SRAM_ADDRESS <= SRAM_ADDRESS_START;
				end
			else if ((SRAM_DATA_IN != SRAM_DATA_OUT) && (RDWEN == 1'b1) && (error == 1'b0))	// error found in read mode and we are currently waiting for an error
				begin
					SRAM_ADDRESS <= SRAM_ADDRESS - 15'd2;	// move address back by 8
				end
			else	// all is normal, or we are currently dealing with an error, so increase the address
				begin
					SRAM_ADDRESS <= SRAM_ADDRESS + 1'b1;
				end
				
	
				
	
	// block to control the errors
	always @ (posedge CLK)
		if (~reset)
			begin
				error <= 1'b0;
				DATA_IN_HOLDER <= 8'd0;
				DATA_OUT_HOLDER <= 8'd0;
				ADDRESS_HOLDER <= 15'd0;
			end
		else if (clear_error == 1'b0)
			begin
				error <= 1'b0; // reset the error
				DATA_IN_HOLDER <= 8'd0;
				DATA_OUT_HOLDER <= 8'd0;
				ADDRESS_HOLDER <= 15'd0;
			end
		else if ((SRAM_DATA_IN != SRAM_DATA_OUT) && (RDWEN == 1'b1) && (error == 1'b0) )	// check if data is wrong and were in read mode with no current error not read
			begin
				error <= 1'b1;
				DATA_IN_HOLDER <= SRAM_DATA_IN;	// capture both the data found for data in and data out
				DATA_OUT_HOLDER <= SRAM_DATA_OUT;
				ADDRESS_HOLDER <= SRAM_ADDRESS;
			end
		else
			begin
				error <= error;	// no error or currently dealing with an error so keep it the same
				DATA_IN_HOLDER <= DATA_IN_HOLDER;	// keep catured data the same
				DATA_OUT_HOLDER <= DATA_OUT_HOLDER;
				ADDRESS_HOLDER <= ADDRESS_HOLDER;
			end
			
			
			
	// block to control writing of test data
	always @ (posedge CLK)
		if (~reset)
			begin
				test_data_counter <= 16'd0;
				test_data_written <= 1'b0;
			end
		else if (data_count == 8'd38)
			begin
				test_data_counter <= SRAM_ADDRESS_START;
			end
		else if (data_count >= 8'd39 && (test_data_written == 1'b0))
				if ((test_data_counter == 16'd65535) && (test_data_written == 1'b0))
					begin
						test_data_counter <= test_data_counter;
						test_data_written <= 1'b1;		// we have written to all test addresses so raise flag to stop
					end
				else if ((test_data_counter != 16'd65535) && (test_data_written == 1'b0))	
					begin
						test_data_counter <= test_data_counter + 1'b1;
					end
		else
			begin
				test_data_counter <= test_data_counter;
				test_data_written <= test_data_written;
			end
			
	reg internal_error;		
			
	// block to control rdwen
	always @ (posedge CLK)
		if (~reset)
			begin
				RDWEN <= 1'b0;	// default to write
			end
		else if (test_data_written == 1'b1)	// test data has been written so look for errors
			if ((SRAM_DATA_OUT != SRAM_DATA_IN) && (error == 1'b0) && (internal_error == 1'b0))	// if no current error and error found look here
				begin
					RDWEN <= 1'b0;		// change to write after an error is found to correct it
					internal_error <= 1'b1; // mark internal error so we can write 16 addresses
					
				end
			else if ((internal_error == 1'b1) && (SRAM_ADDRESS < ADDRESS_HOLDER + 8'd2))
				begin
					RDWEN <= 1'b0;
				end
			else if ((internal_error == 1'b1) && (SRAM_ADDRESS == ADDRESS_HOLDER + 8'd2))
				begin
					RDWEN <= 1'b1;
					internal_error <= 1'b0;		// done writing through addresses so remove flag and change back to read mode
				end
			else
				begin
					RDWEN <= 1'b1;		// stay in read mode otherwise
				end
		else
			begin
				RDWEN <= 1'b0;	// not written through all test data so stay in write mode
			end
					
	
				
	// block to output data out to the raspberry pi if an error is found
	reg [7:0] output_counter_sram;
	
	initial begin
		output_counter_sram <= 8'd0;
	end
	
	//counter to keep track of which bit to output
	always @ (posedge sram_data_clk)
		if (~reset)
			begin
				output_counter_sram <= 8'd0;
			end
		else if (output_counter_sram == 8'd30)
			begin
				output_counter_sram <= 8'd0;
			end
		else
			begin
				output_counter_sram <= output_counter_sram + 1'b1;
			end
			
	// now choose which data to ouput to the pi, start with captured data out, then captured data in
	always @ (posedge sram_data_clk)
		if (~reset)
			begin
				sram_data_pi = 1'b0;
			end
		else
			begin
				case(output_counter_sram)
					8'd0	:	sram_data_pi = DATA_OUT_HOLDER[0];
					8'd1 	: 	sram_data_pi = DATA_OUT_HOLDER[1];
					8'd2 	: 	sram_data_pi = DATA_OUT_HOLDER[2];
					8'd3 	: 	sram_data_pi = DATA_OUT_HOLDER[3];
					8'd4 	: 	sram_data_pi = DATA_OUT_HOLDER[4];
					8'd5 	: 	sram_data_pi = DATA_OUT_HOLDER[5];
					8'd6 	: 	sram_data_pi = DATA_OUT_HOLDER[6];
					8'd7 	: 	sram_data_pi = DATA_OUT_HOLDER[7];
					8'd8	:	sram_data_pi = DATA_IN_HOLDER[0];
					8'd9 	: 	sram_data_pi = DATA_IN_HOLDER[1];
					8'd10 : 	sram_data_pi = DATA_IN_HOLDER[2];
					8'd11 : 	sram_data_pi = DATA_IN_HOLDER[3];
					8'd12 : 	sram_data_pi = DATA_IN_HOLDER[4];
					8'd13 : 	sram_data_pi = DATA_IN_HOLDER[5];
					8'd14 : 	sram_data_pi = DATA_IN_HOLDER[6];
					8'd15 : 	sram_data_pi = DATA_IN_HOLDER[7];
					8'd16 : sram_data_pi = ADDRESS_HOLDER[0];
					8'd17 : sram_data_pi = ADDRESS_HOLDER[1];
					8'd18 : sram_data_pi = ADDRESS_HOLDER[2];
					8'd19 : sram_data_pi = ADDRESS_HOLDER[3];
					8'd20 : sram_data_pi = ADDRESS_HOLDER[4];
					8'd21 : sram_data_pi = ADDRESS_HOLDER[5];
					8'd22 : sram_data_pi = ADDRESS_HOLDER[6];
					8'd23 : sram_data_pi = ADDRESS_HOLDER[7];
					8'd24 : sram_data_pi = ADDRESS_HOLDER[8];
					8'd25 : sram_data_pi = ADDRESS_HOLDER[9];
					8'd26 : sram_data_pi = ADDRESS_HOLDER[10];
					8'd27 : sram_data_pi = ADDRESS_HOLDER[11];
					8'd28 : sram_data_pi = ADDRESS_HOLDER[12];
					8'd29 : sram_data_pi = ADDRESS_HOLDER[13];
					8'd30 : sram_data_pi = ADDRESS_HOLDER[14];
					default	:	sram_data_pi = 1'b0;
				endcase
			end


endmodule