`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:28:00 08/22/2016 
// Design Name: 
// Module Name:    DATA_RCV_FPGA 
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
module DATA_RCV_FPGA(
    input empty_rcv, //from UART_TOP, if empty_rcv = 0, fifo is empty (nothing to read)
    input [7:0] data_rcv,
    input rst, //active low, from ~RST_PER
    input clk, //50MHz
    output reg [1:0] data_cntrl,
    output reg [1:0] clk_cntrl,
	 output reg start,
	 output reg [15:0] data_ex//data excution
    );
	 
	 reg inv_empty;//no use
	 reg [3:0] cnt;
	 //reg [15:0] data_ex;//data excution
	 wire [7:0] data_state;//no use
	 
	 assign data_state = data_rcv;//no use
	 
	/* always @ (posedge clk) begin
		if(!empty_rcv)
			inv_empty <= 1;
		else
			inv_empty <= 0;
		end */
		
		//not sure
		//if RCV_FIFO is empty, which means the data in FIFO buffer has been loaded to the data_RCV so cnt++ to read the next byte
		//if not empty, whivh mean no new data need to be loaded into the data_ex
		always @ (posedge clk or posedge rst) begin
		  if(rst)
		    cnt <= 4'b0;
		  else if(empty_rcv) //there is something to read,FIFO is not empty.
		    cnt <= cnt + 4'b1;
		  else
		    cnt <= cnt;
		end
		
		always @ (*) begin
		  case(cnt)
		  4'd0: data_ex = data_ex;
		  4'd1: data_ex[15:8] = data_rcv;
		  4'd2: data_ex[7:0] = data_rcv;
		  default: data_ex = data_ex;
		  endcase
		end
		
		always @ (*) begin
		  if(rst)
			 start = 1'd0;
		  else if(cnt == 4'd2)
		    start = 1'd1;
		  else start = start;
		end
			 
	 always @ (posedge clk)
		data_cntrl <= data_ex[1:0];

	 always @ (posedge clk)
		clk_cntrl <= data_ex[3:2];

endmodule
