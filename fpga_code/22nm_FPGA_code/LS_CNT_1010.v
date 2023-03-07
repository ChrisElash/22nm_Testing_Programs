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
module LS_CNT(
    input CLK,
	input clk_100m,//new 0425
    input RST_PER,//active high
    input CREST_IN,
    input RPG_IN,
	 input [1:0] CLK_CTRL,
    output reg [31:0] ERR_CNT,
	 output reg comp_out
    );
	/////////////////////////////////////////////////////////////////	 
	 reg crest_sam1;
	 reg crest_sam2;
	 reg comp_in,comp_in_1,comp_in_2,comp_in_3,comp_in_4,comp_in_5,comp_in_6;
	 wire comp_in_pulse;
	 reg [7:0] cnt,cnt_1;
	 wire  error_clk;
	 
	 reg [16:0] ns_ck_cnt, self_cnt;//for generating the checking pattern
	 reg dat_ck;
	 reg dat_halfclk;
	 reg comp_en;
	 reg pulse_delay;
	 reg pulse;
	 reg self_cnt_en;
	 reg comp_start1,comp_start2;
	 //wire comp_out;
	
	 initial begin
	 crest_sam1<=1'b0;
	 crest_sam2<=1'b0;
	 end
	 
	 always @ (posedge CLK)
		crest_sam1 <= CREST_IN;
	 
	 always @ (posedge CLK)
		crest_sam2 <= crest_sam1; //one clock delay from crest_sam1

	 always @ *
	 if (CLK_CTRL == 2'b00)
		comp_in = crest_sam1;
	 else
		comp_in = crest_sam2;
		
/*	 initial
		dat_halfclk = 0;	 
	 always @ (posedge CLK or posedge RST_PER)
	 if (RST_PER)
		dat_halfclk <= 0;
	 else
		dat_halfclk <= ~dat_halfclk;
*/
	 always @(posedge CLK or posedge RST_PER ) begin
		if (RST_PER)begin
		comp_in_1 <= 1'b0;
		comp_in_2 <= 1'b0;
		comp_in_3 <= 1'b0;
		comp_in_4 <= 1'b0;
		comp_in_5 <= 1'b0;
		comp_in_6 <= 1'b0;
		end
		else begin
		comp_in_1 <= comp_in;
		comp_in_2 <= comp_in_1;
		comp_in_3 <= comp_in_2;
		comp_in_4 <= comp_in_3;
		comp_in_5 <= comp_in_4;
		comp_in_6 <= comp_in_5;
		end
	  end
	 
	 assign	comp_in_pulse = comp_in_2 & ~comp_in_3;
	 
	 always @(posedge CLK or posedge RST_PER)begin
		if (RST_PER)
		comp_en <= 1'b0;
		else if (comp_in_pulse )
		comp_en <= 1'b1;
		else
		comp_en <= comp_en;
		end
	 always @(posedge CLK)begin
	    pulse_delay <= comp_en;
		pulse <= comp_en & ~ pulse_delay;	
	 end	
/*	always @ (posedge CLK )begin //this is for 010101 pattern
		if(comp_en)
			comp_out <= comp_in_3 ^ RPG_IN;
		else
			comp_out <= comp_in_3 ^ comp_in_3;	 
	 end
*/	 always @(posedge CLK or posedge RST_PER)begin
		if (RST_PER)begin
		comp_start1 <= 1'b0;
		end
		else if (pulse&RPG_IN )
		comp_start1 <= 1'b1;
		else
		comp_start1 <= comp_start1;
		end
	 always @(posedge CLK or posedge RST_PER)begin
		if (RST_PER)begin
		comp_start2 <= 1'b0;
		end
		else if (pulse&~RPG_IN )
		comp_start2 <= 1'b1;
		else
		comp_start2 <= comp_start2;
		end
	 always @ (posedge CLK )begin
		if(comp_start1)
			comp_out <= comp_in_4 ^ RPG_IN;
		else if (comp_start2)
			comp_out <= comp_in_3 ^ RPG_IN;
		else
			comp_out <= 1'b0;	 
	 end	
	
	
	
	
	
	
	
	 
	 //assign comp_out = comp_in^RPG_IN; //comp_out = 1 if comp_in and rpg_in are different, comp_out=0 if theyre the same
/*	 assign comp_out = comp_in^RPG_IN;
	always @ (posedge clk_100m or posedge RST_PER) begin 
	  if (RST_PER)
		cnt <= 8'd249;
	  else if (cnt==8'd0)
	    cnt<=8'd249;
		else
		cnt <= cnt -1; 
	  end
	 assign error_clk = (cnt == 8'd1) ? 1'b1 : 1'b0 ;
	 always @ (posedge error_clk or posedge RST_PER) begin 
	  if (RST_PER)
		cnt_1 <= 0;
		else if (cnt_1==8'd7)
	    cnt_1<=1'b0;
		else
		cnt_1 <= cnt_1 +1; 
	  end
	 
	 always @ (posedge clk_100m) begin 
	  if (RST_PER)
	  comp_out <= 0;
	  else if (cnt_1==8'd6)
	  comp_out <= comp_in^RPG_IN;
	  else 
	  comp_out <= comp_out;
	  end
*/	 
	  
	 initial begin
		ERR_CNT <= 0;
	 end
	 
	 always @ (posedge CLK or posedge RST_PER)
	 if (RST_PER)
		ERR_CNT <= 0;
	 else if (comp_out == 1) //if comp_in != rpg_in
		ERR_CNT <= ERR_CNT+1;//+1;


endmodule
