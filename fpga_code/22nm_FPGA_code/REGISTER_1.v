`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:45:03 11/16/2017 
// Design Name: 
// Module Name:    REGISTER 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// A11itional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
//make the DAT_FPGA could be load to the transmiter port of UART sequently
module REGISTER_1(
    input CLK_50M, CLK_MUXOUT,
	 input RST, //active high
	 input RST_B,
	 input r_rst,
	 
	 input [7:0] DAT_FPGA0, DAT_FPGA1, DAT_FPGA2, DAT_FPGA3, DAT_FPGA4, DAT_FPGA5, DAT_FPGA6, DAT_FPGA7, DAT_FPGA8, DAT_FPGA9, 
		DAT_FPGA10, DAT_FPGA11, DAT_FPGA12, DAT_FPGA13, DAT_FPGA14, DAT_FPGA15, DAT_FPGA16, DAT_FPGA17, DAT_FPGA18, DAT_FPGA19, 
		DAT_FPGA20, DAT_FPGA21, DAT_FPGA22, DAT_FPGA23, DAT_FPGA24, DAT_FPGA25, DAT_FPGA26, DAT_FPGA27, DAT_FPGA28, DAT_FPGA29, 
		DAT_FPGA30, DAT_FPGA31, DAT_FPGA32, DAT_FPGA33, DAT_FPGA34, DAT_FPGA35, DAT_FPGA36, DAT_FPGA37, DAT_FPGA38, DAT_FPGA39,
		DAT_FPGA40, DAT_FPGA41, DAT_FPGA42, DAT_FPGA43, DAT_FPGA44, DAT_FPGA45, DAT_FPGA46, DAT_FPGA47, DAT_FPGA48, DAT_FPGA49,
		DAT_FPGA50, DAT_FPGA51, DAT_FPGA52, DAT_FPGA53, DAT_FPGA54, DAT_FPGA55, 
	 
	 //from fifo
	 input write, EMPTY,
	 
	 output reg en_xmit,
	 output reg [7:0] dout,
	 input start,
	 input uart_reset,
	 output do_fifo_do,
	 
	 //debug
	 output OUT_DB
    );
	 
	 reg [7:0] DAT_FPGA [0:55];
//	 reg [7:0] DATA_REG [0:55];
	 reg [7:0] DAT_UART [0:55];
	 
	 
	 reg [5:0] cnt;
	 	 
	 reg [16:0] cnt_act;
	 reg act;
	 always @ (posedge CLK_MUXOUT or posedge r_rst) begin
	   if(r_rst)
		  cnt_act <= 17'b0;
		else if(cnt_act == 17'd49999)
		  cnt_act <= 0;
		else
		  cnt_act <= cnt_act + 17'b1;
	 end
	 
	 always @ (posedge CLK_MUXOUT or posedge r_rst) begin
	   if(r_rst)
		  act <= 1'b0;
		else if (cnt_act == 17'd49999)
		  act <= 1'b1;
		else act <= 1'b0;
	 end

		 always @ (posedge CLK_MUXOUT) begin
		if(r_rst) begin
			DAT_FPGA[0] <= 0;
			DAT_FPGA[1] <= 0;
			DAT_FPGA[2] <= 0;
			DAT_FPGA[3] <= 0;
			
			DAT_FPGA[4] <= 0;
			DAT_FPGA[5] <= 0;
			DAT_FPGA[6] <= 0;
			DAT_FPGA[7] <= 0;
			
			DAT_FPGA[8] <= 0;
			DAT_FPGA[9] <= 0;
			DAT_FPGA[10] <= 0;
			DAT_FPGA[11] <= 0;
			
			DAT_FPGA[12] <= 0;
			DAT_FPGA[13] <= 0;
			DAT_FPGA[14] <= 0;
			DAT_FPGA[15] <= 0;
			
			DAT_FPGA[16] <= 0;
			DAT_FPGA[17] <= 0;
			DAT_FPGA[18] <= 0;
			DAT_FPGA[19] <= 0;
			
			DAT_FPGA[20] <= 0;
			DAT_FPGA[21] <= 0;
			DAT_FPGA[22] <= 0;
			DAT_FPGA[23] <= 0;
			
			DAT_FPGA[24] <= 0;
			DAT_FPGA[25] <= 0;
			DAT_FPGA[26] <= 0;
			DAT_FPGA[27] <= 0;
			
			DAT_FPGA[28] <= 0;
			DAT_FPGA[29] <= 0;
			DAT_FPGA[30] <= 0;
			DAT_FPGA[31] <= 0;
			
			DAT_FPGA[32] <= 0;
			DAT_FPGA[33] <= 0;
			DAT_FPGA[34] <= 0;
			DAT_FPGA[35] <= 0;
			
			DAT_FPGA[36] <= 0;
			DAT_FPGA[37] <= 0;
			DAT_FPGA[38] <= 0;
			DAT_FPGA[39] <= 0;
			
			DAT_FPGA[40] <= 0;
			DAT_FPGA[41] <= 0;
			DAT_FPGA[42] <= 0;
			DAT_FPGA[43] <= 0;
			
			DAT_FPGA[44] <= 0;
			DAT_FPGA[45] <= 0;
			DAT_FPGA[46] <= 0;
			DAT_FPGA[47] <= 0;
			
			DAT_FPGA[48] <= 0;
			DAT_FPGA[49] <= 0;
			DAT_FPGA[50] <= 0;
			DAT_FPGA[51] <= 0;
			
			DAT_FPGA[52] <= 0;
			DAT_FPGA[53] <= 0;
			DAT_FPGA[54] <= 0;
			DAT_FPGA[55] <= 0;
		
		end
		else begin
			DAT_FPGA[0] <= DAT_FPGA0;
			DAT_FPGA[1] <= DAT_FPGA1;
			DAT_FPGA[2] <= DAT_FPGA2;
			DAT_FPGA[3] <= DAT_FPGA3;
			
			DAT_FPGA[4] <= DAT_FPGA4;
			DAT_FPGA[5] <= DAT_FPGA5;
			DAT_FPGA[6] <= DAT_FPGA6;
			DAT_FPGA[7] <= DAT_FPGA7;
			
			DAT_FPGA[8] <= DAT_FPGA8;
			DAT_FPGA[9] <= DAT_FPGA9;
			DAT_FPGA[10] <= DAT_FPGA10;
			DAT_FPGA[11] <= DAT_FPGA11;
			
			DAT_FPGA[12] <= DAT_FPGA12;
			DAT_FPGA[13] <= DAT_FPGA13;
			DAT_FPGA[14] <= DAT_FPGA14;
			DAT_FPGA[15] <= DAT_FPGA15;
			
			DAT_FPGA[16] <= DAT_FPGA16;
			DAT_FPGA[17] <= DAT_FPGA17;
			DAT_FPGA[18] <= DAT_FPGA18;
			DAT_FPGA[19] <= DAT_FPGA19;
			
			DAT_FPGA[20] <= DAT_FPGA20;
			DAT_FPGA[21] <= DAT_FPGA21;
			DAT_FPGA[22] <= DAT_FPGA22;
			DAT_FPGA[23] <= DAT_FPGA23;
			
			DAT_FPGA[24] <= DAT_FPGA24;
			DAT_FPGA[25] <= DAT_FPGA25;
			DAT_FPGA[26] <= DAT_FPGA26;
			DAT_FPGA[27] <= DAT_FPGA27;
			
			DAT_FPGA[28] <= DAT_FPGA28;
			DAT_FPGA[29] <= DAT_FPGA29;
			DAT_FPGA[30] <= DAT_FPGA30;
			DAT_FPGA[31] <= DAT_FPGA31;
			
			DAT_FPGA[32] <= DAT_FPGA32;
			DAT_FPGA[33] <= DAT_FPGA33;
			DAT_FPGA[34] <= DAT_FPGA34;
			DAT_FPGA[35] <= DAT_FPGA35;
			
			DAT_FPGA[36] <= DAT_FPGA36;
			DAT_FPGA[37] <= DAT_FPGA37;
			DAT_FPGA[38] <= DAT_FPGA38;
			DAT_FPGA[39] <= DAT_FPGA39;
			
			DAT_FPGA[40] <= DAT_FPGA40;
			DAT_FPGA[41] <= DAT_FPGA41;
			DAT_FPGA[42] <= DAT_FPGA42;
			DAT_FPGA[43] <= DAT_FPGA43;
			
			DAT_FPGA[44] <= DAT_FPGA44;
			DAT_FPGA[45] <= DAT_FPGA45;
			DAT_FPGA[46] <= DAT_FPGA46;
			DAT_FPGA[47] <= DAT_FPGA47;
			
			DAT_FPGA[48] <= DAT_FPGA48;
			DAT_FPGA[49] <= DAT_FPGA49;
			DAT_FPGA[50] <= DAT_FPGA50;
			DAT_FPGA[51] <= DAT_FPGA51;
			
			DAT_FPGA[52] <= DAT_FPGA52;
			DAT_FPGA[53] <= DAT_FPGA53;
			DAT_FPGA[54] <= DAT_FPGA54;
			DAT_FPGA[55] <= DAT_FPGA55;
			
		end
	end
	 
	 always @ (posedge CLK_MUXOUT) begin
		if(r_rst) begin
			DAT_UART[0] <= 0;
			DAT_UART[1] <= 0;
			DAT_UART[2] <= 0;
			DAT_UART[3] <= 0;
			  
			DAT_UART[4] <= 0;
			DAT_UART[5] <= 0;
			DAT_UART[6] <= 0;
			DAT_UART[7] <= 0;
				
			DAT_UART[8] <= 0;
			DAT_UART[9] <= 0;
			DAT_UART[10] <= 0;
			DAT_UART[11] <= 0;
				
			DAT_UART[12] <= 0;
			DAT_UART[13] <= 0;
			DAT_UART[14] <= 0;
			DAT_UART[15] <= 0;
				
			DAT_UART[16] <= 0;
			DAT_UART[17] <= 0;
			DAT_UART[18] <= 0;
			DAT_UART[19] <= 0;
				
			DAT_UART[20] <= 0;
			DAT_UART[21] <= 0;
			DAT_UART[22] <= 0;
			DAT_UART[23] <= 0;
				
			DAT_UART[24] <= 0;
			DAT_UART[25] <= 0;
			DAT_UART[26] <= 0;
			DAT_UART[27] <= 0;
				
			DAT_UART[28] <= 0; 
			DAT_UART[29] <= 0;
			DAT_UART[30] <= 0;
			DAT_UART[31] <= 0;
				
			DAT_UART[32] <= 0;
			DAT_UART[33] <= 0;
			DAT_UART[34] <= 0;
			DAT_UART[35] <= 0;
				
			DAT_UART[36] <= 0;
			DAT_UART[37] <= 0;
			DAT_UART[38] <= 0;
			DAT_UART[39] <= 0;
				
			DAT_UART[40] <= 0;
			DAT_UART[41] <= 0;
			DAT_UART[42] <= 0;
			DAT_UART[43] <= 0;
				
			DAT_UART[44] <= 0;
			DAT_UART[45] <= 0;
			DAT_UART[46] <= 0;
			DAT_UART[47] <= 0;
			  
			DAT_UART[48] <= 0;
			DAT_UART[49] <= 0;
			DAT_UART[50] <= 0;
			DAT_UART[51] <= 0;
			  
			DAT_UART[52] <= 0;
			DAT_UART[53] <= 0;
			DAT_UART[54] <= 0;
			DAT_UART[55] <= 0;
			
		end
		else if((EMPTY) && (act) && (start)) begin
			en_xmit <= 1'b1;
			DAT_UART[0] <= DAT_FPGA[0];
			DAT_UART[1] <= DAT_FPGA[1];
			DAT_UART[2] <= DAT_FPGA[2];
			DAT_UART[3] <= DAT_FPGA[3];
			DAT_UART[4] <= DAT_FPGA[4];
			
			DAT_UART[5] <= DAT_FPGA[5];
			DAT_UART[6] <= DAT_FPGA[6];
			DAT_UART[7] <= DAT_FPGA[7];
			DAT_UART[8] <= DAT_FPGA[8];
			DAT_UART[9] <= DAT_FPGA[9];
			
			DAT_UART[10] <= DAT_FPGA[10];
			DAT_UART[11] <= DAT_FPGA[11];
			DAT_UART[12] <= DAT_FPGA[12];
			DAT_UART[13] <= DAT_FPGA[13];
			DAT_UART[14] <= DAT_FPGA[14];
			
			DAT_UART[15] <= DAT_FPGA[15];
			DAT_UART[16] <= DAT_FPGA[16];
			DAT_UART[17] <= DAT_FPGA[17];
			DAT_UART[18] <= DAT_FPGA[18];
			DAT_UART[19] <= DAT_FPGA[19];
			
			DAT_UART[20] <= DAT_FPGA[20];
			DAT_UART[21] <= DAT_FPGA[21];
			DAT_UART[22] <= DAT_FPGA[22];
			DAT_UART[23] <= DAT_FPGA[23];
			DAT_UART[24] <= DAT_FPGA[24];
			
			DAT_UART[25] <= DAT_FPGA[25];
			DAT_UART[26] <= DAT_FPGA[26];
			DAT_UART[27] <= DAT_FPGA[27];
			DAT_UART[28] <= DAT_FPGA[28];
			DAT_UART[29] <= DAT_FPGA[29];
			
			DAT_UART[30] <= DAT_FPGA[30];
			DAT_UART[31] <= DAT_FPGA[31];
			DAT_UART[32] <= DAT_FPGA[32];
			DAT_UART[33] <= DAT_FPGA[33];
			DAT_UART[34] <= DAT_FPGA[34];
			
			DAT_UART[35] <= DAT_FPGA[35];
			DAT_UART[36] <= DAT_FPGA[36];
			DAT_UART[37] <= DAT_FPGA[37];
			DAT_UART[38] <= DAT_FPGA[38];
			DAT_UART[39] <= DAT_FPGA[39];
			
			DAT_UART[40] <= DAT_FPGA[40];
			DAT_UART[41] <= DAT_FPGA[41];
			DAT_UART[42] <= DAT_FPGA[42];
			DAT_UART[43] <= DAT_FPGA[43];
			DAT_UART[44] <= DAT_FPGA[44];
			
			DAT_UART[45] <= DAT_FPGA[45];
			DAT_UART[46] <= DAT_FPGA[46];
			DAT_UART[47] <= DAT_FPGA[47];
			DAT_UART[48] <= DAT_FPGA[48];
			DAT_UART[49] <= DAT_FPGA[49];
			
			DAT_UART[50] <= DAT_FPGA[50];
			DAT_UART[51] <= DAT_FPGA[51];
			DAT_UART[52] <= DAT_FPGA[52];
			DAT_UART[53] <= DAT_FPGA[53];
			DAT_UART[54] <= DAT_FPGA[54];
			DAT_UART[55] <= DAT_FPGA[55];
			
		end
		else if(cnt == 6'd55)
			en_xmit <= 1'b0;
	end
	
	always @ (posedge CLK_MUXOUT) begin
		if(r_rst)
			cnt<=6'b0;
		else if(!write)
			cnt <= 6'b0;
//		else if(cnt==6'd55)
//			cnt <= 6'b0;
		else
			cnt <= cnt + 1'b1;
	end
	
//	always @ (posedge CLK_MUXOUT) begin
always @ (cnt) begin
		case(cnt) 
		
			6'b000000: dout = DAT_UART[3];
			6'b000001: dout = DAT_UART[2];
			6'b000010: dout = DAT_UART[1];
			6'b000011: dout = DAT_UART[0];
			
			6'b000100: dout = DAT_UART[7];
			6'b000101: dout = DAT_UART[6];
			6'b000110: dout = DAT_UART[5];
			6'b000111: dout = DAT_UART[4];
			
			6'b001000: dout = DAT_UART[11];
			6'b001001: dout = DAT_UART[10];
			6'b001010: dout = DAT_UART[9];
			6'b001011: dout = DAT_UART[8];
			
			6'b001100: dout = DAT_UART[15];
			6'b001101: dout = DAT_UART[14];
			6'b001110: dout = DAT_UART[13];
			6'b001111: dout = DAT_UART[12];
			
			6'b010000: dout = DAT_UART[19];
			6'b010001: dout = DAT_UART[18];
			6'b010010: dout = DAT_UART[17];
			6'b010011: dout = DAT_UART[16];
			
			6'b010100: dout = DAT_UART[23];
			6'b010101: dout = DAT_UART[22];
			6'b010110: dout = DAT_UART[21];
			6'b010111: dout = DAT_UART[20];
			
			6'b011000: dout = DAT_UART[27];
			6'b011001: dout = DAT_UART[26];
			6'b011010: dout = DAT_UART[25];
			6'b011011: dout = DAT_UART[24];
			
			6'b011100: dout = DAT_UART[31];
			6'b011101: dout = DAT_UART[30];
			6'b011110: dout = DAT_UART[29];
			6'b011111: dout = DAT_UART[28];
			
			6'b100000: dout = DAT_UART[35];
			6'b100001: dout = DAT_UART[34];
			6'b100010: dout = DAT_UART[33];
			6'b100011: dout = DAT_UART[32];
			
			6'b100100: dout = DAT_UART[39];
			6'b100101: dout = DAT_UART[38];
			6'b100110: dout = DAT_UART[37];
			6'b100111: dout = DAT_UART[36];
			
			6'b101000: dout = DAT_UART[43];
			6'b101001: dout = DAT_UART[42];
			6'b101010: dout = DAT_UART[41];
			6'b101011: dout = DAT_UART[40];
			
			6'b101100: dout = DAT_UART[47];
			6'b101101: dout = DAT_UART[46];
			6'b101110: dout = DAT_UART[45];
			6'b101111: dout = DAT_UART[44];
			
			6'b110000: dout = DAT_UART[51];
			6'b110001: dout = DAT_UART[50];
			6'b110010: dout = DAT_UART[49];
			6'b110011: dout = DAT_UART[48];
			
			6'b110100: dout = DAT_UART[55];
			6'b110101: dout = DAT_UART[54];
			6'b110110: dout = DAT_UART[53];
			6'b110111: dout = DAT_UART[52];
						
			
			default: dout = 8'b0;
		endcase
		
/*	else begin
//		do_fifo <= 0;
		dout <=8'b0;
	end
*/end
endmodule
