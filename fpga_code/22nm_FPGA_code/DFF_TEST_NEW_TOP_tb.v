`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2021 11:13:32 AM
// Design Name: 
// Module Name: DFF_TEST_NEW_TOP_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DFF_TEST_NEW_TOP_tb();

reg CLK_50M;
reg RST_PER;

wire CLK_DUT_CHIP1;//
wire CLK_DUT_CHIP2;//
wire DAT_DUT_CHIP1;//
wire DAT_DUT_CHIP2;//
wire DAT_DUT_CHIP22;
reg DB_DFFQ0;
reg DB_DFFQ1;
reg DB_DFFQ2;
reg DB_DFFQ3;
reg DB_DFFQ4;
reg DB_DFFQ5;
reg DB_DFFQ6;
reg DB_DFFQ7;
reg DB_DFFQ8;
reg DB_DFFQ9;
reg DB_DFFQ10;
reg DB_DFFQ11;
reg DB_DFFQ12;
reg DB_DFFQ13;
reg start;
reg SIN; //comes from RaspBErryPi
wire SOUT;

wire comp_out_db;
//debug signal
wire reset;
wire sin_db;
wire CLK_100K;
wire clk_50_db;

parameter       clk_num      = 4330;//=8680;//= 4330;

//initial
    //data = {8'h00, 8'h0c};

initial
    CLK_50M = 1;
always    
    #10 CLK_50M = ~CLK_50M; 

initial begin
    DB_DFFQ0 = 1'b1;
    DB_DFFQ1 = 1'b1;
    DB_DFFQ2 = 1'b1;
    DB_DFFQ3 = 1'b1;
    DB_DFFQ4 = 1'b1;
    DB_DFFQ5 = 1'b1;
    DB_DFFQ6 = 1'b1;
    DB_DFFQ7 = 1'b1;
    DB_DFFQ8 = 1'b1;
    DB_DFFQ9 = 1'b1;
	DB_DFFQ10 = 1'b1;
    DB_DFFQ11 = 1'b1;
    DB_DFFQ12 = 1'b1;
    DB_DFFQ13 = 1'b1;
    
    SIN = 1'b1;
end

task uart_write();
	input [7:0] data_in;
	integer i;
	begin
		//#clk_num;
		SIN = 1'b0;
		#clk_num;
		//#1000;

		for (i=0; i<8; i=i+1) begin
			SIN = data_in[i];
			#clk_num;
		end

		SIN = 1'b1;
		#clk_num;
	end
endtask : uart_write

task rst_gen();
	begin
	RST_PER<=1;
//	repeat(6) @(posedge CLK_50M);
	repeat(43) @(posedge CLK_50M);
	RST_PER<=0;
	end
endtask

initial begin
	rst_gen();
end

initial begin
	#1250000 rst_gen();
end



initial begin
    //RST_PER = 1;
    //#200 RST_PER = 0;
    
	 wait(RST_PER==0);
	 repeat(6) @(posedge CLK_50M);
	 start = 1;
    uart_write(8'hab);
    uart_write(8'hcd);
    
    
end

DFF_TEST_NEW_TOP DTNT1(
.CLK_50M(CLK_50M),
.RST_PER(RST_PER),
.CLK_DUT_CHIP1(CLK_DUT_CHIP1),
.CLK_DUT_CHIP2(CLK_DUT_CHIP2),
.DAT_DUT_CHIP1(DAT_DUT_CHIP1),//
.DAT_DUT_CHIP2(DAT_DUT_CHIP2),//
.DAT_DUT_CHIP22(DAT_DUT_CHIP22),
.DB_DFFQ0(DB_DFFQ0),
.DB_DFFQ1(DB_DFFQ1),
.DB_DFFQ2(DB_DFFQ2),
.DB_DFFQ3(DB_DFFQ3),
.DB_DFFQ4(DB_DFFQ4),
.DB_DFFQ5(DB_DFFQ5),
.DB_DFFQ6(DB_DFFQ6),
.DB_DFFQ7(DB_DFFQ7),
.DB_DFFQ8(DB_DFFQ8),
.DB_DFFQ9(DB_DFFQ9),
.DB_DFFQ10(DB_DFFQ10),
.DB_DFFQ11(DB_DFFQ11),
.DB_DFFQ12(DB_DFFQ12),
.DB_DFFQ13(DB_DFFQ13),
.SIN(SIN), //comes from RaspBErryPi
.SOUT(SOUT),
.comp_out_db(comp_out_db),
.start_uart(start),
	 //debug signal
.reset(reset),
.sin_db(sin_db),
.CLK_100K(CLK_100K),
.clk_50_db(clk_50_db)
);

endmodule
