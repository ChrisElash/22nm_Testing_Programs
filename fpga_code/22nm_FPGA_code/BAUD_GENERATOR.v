`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:40:31 08/18/2016 
// Design Name: 
// Module Name:    BAUD_GENERATOR 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module BAUD_GENERATOR(
    input clk,
    input rst,
    output reg baud,//bit per second
	 output reg baud_8x
    );
	
	reg [15:0] cnt;
	reg [8:0] cnt2;
	
	parameter bps_115200 = 430; //clocks per bit, one baud cycle = 430 clock cycles
	parameter bps_115200_2 = 215; 
	parameter clk_rcv = 53;
	parameter clk_rcv_2 = 26;
	
	initial begin
		cnt <= 0;
		cnt2 <= 0;
	end
				
	always @ (posedge clk or negedge rst) begin
		if(!rst) begin
			baud <= 1'b0;
			cnt <= 1'b0;
		end
		else if(cnt == bps_115200_2) begin
			baud <= ~baud;
			cnt <= cnt + 1;
		end
		else if(cnt == bps_115200) begin
			baud <= ~baud;
			cnt <= 16'b0;
		end
		else begin
			cnt <= cnt + 1;
			baud <= baud;
		end
	end
	
	always @ (posedge clk or negedge rst) begin
		if(!rst) begin
			baud_8x  <= 1'b0;
			cnt2 <= 1'b0;
		end
		else if(cnt2 == clk_rcv_2) begin
			baud_8x <= ~baud_8x;
			cnt2 <= cnt2 + 1;
		end
		else if(cnt2 == clk_rcv) begin
			baud_8x <= ~baud_8x;
			cnt2 <= 0;
		end
		else begin
			cnt2 <= cnt2 + 1;
			baud_8x <= baud_8x;
		end	
	end
	

endmodule
