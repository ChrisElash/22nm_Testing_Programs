`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:13:43 08/11/2016 
// Design Name: 
// Module Name:    XMIT_FIFO 
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

//The purpose of the FIFO structures is to hold data either received from the serial port or to be written to the serial port.
module XMIT_FIFO(
    input clk,
	 input busy, //busty means the the port of xmit_interface was transmiting 
    input [7:0] din, //data_fpga
    input rst,
    input en_wr, //1 means work
	 input baud_clk,
	 input CLK_MUXOUT,
	 
	 output write,
    output empty, //1 means empty
	 output reg empty_pose,
	 output full,
	 
	 
    output [7:0] dout,
	 input load
	 //
	 //data_db
    );

//	wire full;
	wire reset;
	reg flag;
	reg s1;
	reg s2;
	
	
	reg empty_delay;
	reg load_delay;
	reg rd_en;
	
	reg wr_en;
	wire wr_en_fifo;
	
	
	// emapty_pose signal 
	always @(posedge clk) begin
		empty_delay<=empty;
	end
	
	always@(posedge clk) begin
		empty_pose <= (~empty) & empty_delay;
	end 
	
	always@(posedge clk) begin
		load_delay <= load;
	end
	
	always@(posedge clk) begin
		rd_en <= load & (~load_delay);
	end	
	
	always@(posedge CLK_MUXOUT) begin
		wr_en <= en_wr; /////delay one cycle
	end
	
	assign write = ((en_wr==1)&&(full==0)) ? 1'b1 : 1'b0;
	
	

	
	FIFO xmit_fifo(
  .rst(rst), // input rst
  .wr_clk(CLK_MUXOUT), 
  .din(din), // input [7 : 0] din
  .wr_en(write), // input wr_en and delay one cycle
  .full(full),
  
  .rd_clk (clk),
  .dout (dout), // output [7 : 0] dout
  .rd_en (rd_en), // tx_done
  .empty (empty) // output empty
);





//assign reset = ~rst;
	
	
	//always @ (posedge clk) begin
		//if(empty == 1 && full == 0)
			//write <= en_wr;
		//else if(full == 1)
			//write <= 0;
	//end
	//debug
	//assign data_db = s1;
	
	
	/*
	assign write = ((en_wr == 1) && (full == 0)) ? 1'b1 : 1'b0;
	
	always @ (posedge clk) begin
		if(!rst)
			flag <= 1'b0;
		else if(!empty)
			flag <= 1'b1;
		else if(empty)
			flag <= 1'b0;
		else
			flag <= flag;
	end
	
	always @ (posedge clk) begin
		s2 <= s1;
	end
	
	always @ (posedge clk) begin
		if(!busy && flag) //not busy and empty
			s1 <= 1;
		else
			s1 <= 0;
	end

	assign load = s1 & (!s2); */
	
endmodule
