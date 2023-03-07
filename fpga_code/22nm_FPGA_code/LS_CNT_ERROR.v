`timescale 1ns / 10ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:02:18 05/13/2015 
// Design Name: 
// Module Name:    LS_CNT 
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
module LS_CNT_ERROR(
    input CLK,
	input clk_100m,
    input RST_PER,//active high
    input CREST_IN,
    input RPG_IN,
	 input [1:0] CLK_CTRL,
    output reg [31:0] ERR_CNT,
	 output comp_out
    );
	 
	 reg crest_sam1;
	 reg crest_sam2;
	 reg comp_in;
	 //wire comp_out;
	 
	 always @ (posedge CLK)
		crest_sam1 <= CREST_IN;
	 
	 always @ (posedge CLK)
		crest_sam2 <= crest_sam1; //one clock delay from crest_sam1
		
	 always @ *
	 if (CLK_CTRL == 2'b00)
		comp_in = crest_sam1;
	 else
		comp_in = crest_sam2;
	 
	 //assign comp_out = comp_in^RPG_IN; //comp_out = 1 if comp_in and rpg_in are different, comp_out=0 if theyre the same
	 assign comp_out = comp_in^~RPG_IN;
	 
	 initial begin
		ERR_CNT <= 0;
	 end
	 
	 always @ (posedge CLK or posedge RST_PER)
	 if (RST_PER)
		ERR_CNT <= 0;
	 else if (comp_out == 1) //if comp_in != rpg_in
		ERR_CNT <= ERR_CNT+1;//+1;


endmodule
