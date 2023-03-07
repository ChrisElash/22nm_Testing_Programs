`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:32:46 08/11/2016 
// Design Name: 
// Module Name:    RCV_FIFO 
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
module RCV_FIFO( 
    input clk,
	input err,
    input [7:0] din, //data_out from RCV_interface
    input rst,
    input en_rd, //rd_bit input from top rd_bit==0
    input en_rcv, //ready from RCV_interface
	output empty_rcv, 
    output [7:0] dout
    );

	wire empty;
	wire full;
	wire write;
	wire read;
	wire reset;
	reg s1;
	reg s2;
	wire ready;
	
	assign reset = rst; //active high
	assign write = en_rcv & (~(err | full)); //ready without error and 
	// the register is not full
	
/*	always @ (posedge clk) begin
		if(cnt == 3'd2)
			empty_rcv <= 1'b0;
		else
			empty_rcv <= 1'b1;
	end */
	
	assign empty_rcv = read; 
	
	always @ (posedge clk) begin 
		s2 <= s1;
		if(write)
			s1 <= 1;
		else
			s1 <= 0;
	end
	//Question: why need s1 and s2? why don't use write signal directly?
	//Because only asserting the wr_en (in the module rcv_fifo) signal 
	//could lead data (din) to be written to the FIFO.
	
	assign ready = s1 & (!s2);
	
	assign read = ~(en_rd |empty); //en_rd is always zero, so read = ~empty 
	//(only read when not empty, dont read when empty)
	//if read = 0, fifo is empty
	
	R_FIFO rcv_fifo (
  .clk(clk), 	// input clk
  .rst(reset),  // input rst
  .din(din), 	// input [7 : 0] din
  .wr_en(ready), //input: Write Enable: If the FIFO is not full,
				// asserting this signal causes data (on DIN) to 
				// be written to the FIFO.
  .rd_en(read), // input: Read Enable: If the FIFO is not empty, asserting 
				// this signal causes data to be read from the FIFO 
				// (output on DOUT).
  .dout(dout), //  output [7 : 0] dout
  .full(full), //  output full: Full Flag: When asserted, this signal indicates 
				// that the FIFO is full. Write requests are ignored when 
				// the FIFO is full, initiating a write when the FIFO is full 
				// is not destructive to the contents of the FIFO.
  .empty(empty) // output empty: Empty Flag: When asserted (empty=1), 
				// this signal indicates that the FIFO is empty. Read requests 
				// are ignored when the FIFO is empty, initiating a read while 
				// empty is not destructive to the FIFO
);

	///////////////////////////////////////////////////////////////////////////////////////
	//count the number of data_in
	///////////////////////////////////////////////////////////////////////////////////////
	
	reg [2:0] cnt;
	 
	always @ (negedge clk or posedge reset) begin
		if(reset)
			cnt <= 3'b0;
		else if(ready)
			cnt <= cnt + 3'd1;
		else
			cnt <= cnt;
	end
	


endmodule
