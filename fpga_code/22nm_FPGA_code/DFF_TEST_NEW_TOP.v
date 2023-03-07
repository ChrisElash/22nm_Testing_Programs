`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:17:05 05/14/2015 
// Design Name: 
// Module Name:    DFF_TEST_NEW_TOP 
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
module DFF_TEST_NEW_TOP(
    input CLK_50M,//
    input save_data_dff_pi,// active high		// RST_PER
	 
    output CLK_DUT_CHIP1,//
	 output CLK_DUT_CHIP2,//CLOCK chip in
    output DAT_DUT_CHIP1,//
	 output DAT_DUT_CHIP2,//data chip in 
	 output DAT_DUT_CHIP22,
     
	 input DB_DFFQ0,
	 input DB_DFFQ1,
	 input DB_DFFQ2,
	 input DB_DFFQ3,
	 input DB_DFFQ4,
	 input DB_DFFQ5,
	 input DB_DFFQ6,
	 input DB_DFFQ7,
	 input DB_DFFQ8,
	 input DB_DFFQ9,
	 input DB_DFFQ10,
	 input DB_DFFQ11,
	 input DB_DFFQ12,
	 input DB_DFFQ13,
	 
	 
	 input data_clk_dff_pi, //comes from RaspBErryPi		//SIN
	 input start_uart,
	 output data_out_dff_pi,						//SOUT
	 
	 output comp_out_db,
	 
	 
	 //debug signal
	 output reset,
	 output sin_db,
	 output CLK_100K,
	 output clk_50_db,
	 
	 // signals for rpi data_input and sram_test #######
	 input reset_sram_RO_pi,
	 input data_pi,
	 input data_clk_pi,
	 output sram_error_pi,
	 input clear_error,
	 input sram_data_out_clk_pi,
	 output sram_data_out_pi,
	 
	 // SRAM DUT signals
	 output [7:0] SRAM_DATA_IN,
	 output [14:0] SRAM_ADDRESS,
	 input [7:0] SRAM_DATA_OUT,
	 output SRAM_CLK,
	 output RDWEN,
	 
	 // RO signals ####
	 input read_data_RO_pi,
	 input data_clk_RO_pi,
	 output data_out_RO_pi,
	 input O_INV,
	 input O_NAND,
	 input O_NOR,
	 output [1:0] C,
	 
	 output [1:0] SAWL
    );
	 
	 assign SAWL = 2'b00;

	 
	 wire RST_B;
	 wire CLK_MUXOUT;
	 wire DAT_DUT;
	 wire CLK_400M;
	 wire clk_100m;
//	 wire CLK_100K;
	 wire clk_50m_sys;
	 
	 wire [1:0] DAT_CTL, CLK_CTRL; //user input from pi
	 
	 wire [31:0] ERR_CNT_DFFQ0;
	 wire [31:0] ERR_CNT_DFFQ1;
     wire [31:0] ERR_CNT_DFFQ2;
	 wire [31:0] ERR_CNT_DFFQ3;
	 wire [31:0] ERR_CNT_DFFQ4;
	 wire [31:0] ERR_CNT_DFFQ5;
	 wire [31:0] ERR_CNT_DFFQ6;
	 wire [31:0] ERR_CNT_DFFQ7;
	 wire [31:0] ERR_CNT_DFFQ8;
	 wire [31:0] ERR_CNT_DFFQ9;
	 wire [31:0] ERR_CNT_DFFQ10;
	 wire [31:0] ERR_CNT_DFFQ11;
	 wire [31:0] ERR_CNT_DFFQ12;
	 wire [31:0] ERR_CNT_DFFQ13;
	 
	 
	 
	 wire compout_DFFQ0,compout_DFFQ1, compout_DFFQ2, compout_DFFQ3, compout_DFFQ4, compout_DFFQ5, compout_DFFQ6, 
	 compout_DFFQ7, compout_DFFQ8, compout_DFFQ9, compout_DFFQ10, compout_DFFQ11, compout_DFFQ12, compout_DFFQ13;
	 
	 wire empty_xmit;
	 wire en_xmit;
	 wire write_xmit;
	 wire [7:0] data_fpga;
	 
	 wire empty_rcv;
	 wire [7:0] data_rcv;
	 wire [15:0] data_ex;
	 wire out_db;
	 wire data_db;

	 
	 wire uart_reset;
	 wire do_fifo_do;
	 
	 wire w_rst;
	 wire RST_PER;
	 assign RST_PER = ~reset_sram_RO_pi;
	 assign w_rst = ~(RST_B & ~RST_PER); 
	 
	 //debug
	 assign sin_db = reset;
	 assign clk_50_db = comp_out_db;
	 
	 // reset the LS_CNT chain
	 reg act;
	 
	 always @ (*) begin
		if (en_xmit)
			act = 1;
		else act = 0;
	 end
	 
	 assign reset = act || RST_PER;
	 
	 CLK_GEN_TOP CLK_GEN_TOP(
    .CLK_50M (CLK_50M), //input
    .CLK_CTL (2'b10), //input from DATA_RCV_FPGA (clock control: the select line of multiplexer)
    .CLK_400M (CLK_400M), //input from
	.clk_100m (clk_100m), // new 0425
    .CLK_MUXOUT (CLK_MUXOUT), //output (multiplexer: use CLK_CTL to select different frequency: 00_100M, 01_10M, 10_1M, 11_100K)
	 .CLK_100K (CLK_100K), //output
	 .CLK_REG (clk_50m_sys), //output
	 .RST_B (RST_B) //output( high when the PLL has achived phase allignment and frequency matching)
    );
	 assign CLK_DUT_CHIP1 = CLK_MUXOUT;
	 assign CLK_DUT_CHIP2 = CLK_MUXOUT;
	 
	 DATA_GEN DATA_GEN(
     .CLK(CLK_MUXOUT), //input from CLK_GEN_TOP (clock generated from CLK_GEN_top)
     .RST_B(~w_rst), //input from CLK_GEN_TOP
     .NS_DAT_CTL(2'b01), //input from DATA_RCV_FPGA (Data control: the select line of NS_DAT_OUT)
     .NS_DAT_OUT(DAT_DUT) //output: use DAT_CTL to select different frequency data clk: 00_0, 01_1, 10_CLK/2, 11_CLK/20000;
    );
	 assign DAT_DUT_CHIP1 = DAT_DUT;
	 assign DAT_DUT_CHIP2 = DAT_DUT;
	 assign DAT_DUT_CHIP22 = DAT_DUT;
	 
//to compare the testing result and standard result?

	LS_CNT LS_CNT_DFFQ0(
	 .clk_100m (clk_100m),
    .CLK (CLK_MUXOUT), //input from CLK_GEN_TOP
    .RST_PER (w_rst),//input (active high)
    .CREST_IN (DB_DFFQ0), //input
    .RPG_IN (DAT_DUT), //input from DATA_GEN
    .ERR_CNT (ERR_CNT_DFFQ0), //output
	 .CLK_CTRL(CLK_CTRL), //input from DATA_RCV_FPGA
	 .comp_out(compout_DFFQ0) //output
    );

	 LS_CNT LS_CNT_DFFQ1(
	 .clk_100m (clk_100m),
    .CLK (CLK_MUXOUT), //input from CLK_GEN_TOP (clock generatd from CLK_GEN_top)
    .RST_PER (w_rst), //input from peripheral: active high
    .CREST_IN (DB_DFFQ1), //input
    .RPG_IN (DAT_DUT), //input from DATA_GEN (signal generated from DATA_GEN)
    .ERR_CNT (ERR_CNT_DFFQ1), //output (32 bits output: compare result?)
	 .CLK_CTRL(CLK_CTRL), //input from DATA_RCV_FPGA
	 .comp_out(compout_DFFQ1) //output for debug
    );
	 
			 
	 LS_CNT LS_CNT_DFFQ2(
	 .clk_100m (clk_100m),
    .CLK (CLK_MUXOUT), //input from CLK_GEN_TOP
    .RST_PER (w_rst),//input (active high)
    .CREST_IN (DB_DFFQ2), //input
    .RPG_IN (DAT_DUT), //input from DATA_GEN
    .ERR_CNT (ERR_CNT_DFFQ2), //output
	 .CLK_CTRL(CLK_CTRL), //input from DATA_RCV_FPGA
	 .comp_out(compout_DFFQ2) //output
    );
	 
	 LS_CNT LS_CNT_DFFQ3(
	 .clk_100m (clk_100m),
    .CLK (CLK_MUXOUT), //input from CLK_GEN_TOP
    .RST_PER (w_rst),//input (active high)
    .CREST_IN (DB_DFFQ3), //input
    .RPG_IN (DAT_DUT), //input from DATA_GEN
    .ERR_CNT (ERR_CNT_DFFQ3), //output
	 .CLK_CTRL(CLK_CTRL), //input from DATA_RCV_FPGA
	 .comp_out(compout_DFFQ3) //output
    );
	 
	 LS_CNT LS_CNT_DFFQ4(
	 .clk_100m (clk_100m),
    .CLK (CLK_MUXOUT), //input from CLK_GEN_TOP
    .RST_PER (w_rst), //input (active high)
    .CREST_IN (DB_DFFQ4), //input
    .RPG_IN (DAT_DUT), //input from DATA_GEN
    .ERR_CNT (ERR_CNT_DFFQ4), //output
	 .CLK_CTRL(CLK_CTRL), //input from DATA_RCV_FPGA
	 .comp_out(compout_DFFQ4) //output
    );
	 
	 LS_CNT LS_CNT_DFFQ5(
	 .clk_100m (clk_100m),
    .CLK (CLK_MUXOUT), //input from CLK_GEN_TOP
    .RST_PER (w_rst),//input (active high)
    .CREST_IN (DB_DFFQ5), //input
    .RPG_IN (DAT_DUT), //input from DATA_GEN
    .ERR_CNT (ERR_CNT_DFFQ5), //output
	 .CLK_CTRL(CLK_CTRL), //input from DATA_RCV_FPGA
	 .comp_out(compout_DFFQ5) //output
    );
	 
	 LS_CNT LS_CNT_DFFQ6(
	 .clk_100m (clk_100m),
    .CLK (CLK_MUXOUT), //input from CLK_GEN_TOP
    .RST_PER (w_rst),//input (active high)
    .CREST_IN (DB_DFFQ6), //input
    .RPG_IN (DAT_DUT), //input from DATA_GEN
    .ERR_CNT (ERR_CNT_DFFQ6), //output
	 .CLK_CTRL(CLK_CTRL), //input from DATA_RCV_FPGA
	 .comp_out(compout_DFFQ6) //output
    );
	 
	 LS_CNT LS_CNT_DFFQ7(
	 .clk_100m (clk_100m),
    .CLK (CLK_MUXOUT), //input from CLK_GEN_TOP
    .RST_PER (w_rst),//input (active high)
    .CREST_IN (DB_DFFQ7), //input
    .RPG_IN (DAT_DUT), //input from DATA_GEN
    .ERR_CNT (ERR_CNT_DFFQ7), //output
	 .CLK_CTRL(CLK_CTRL), //input from DATA_RCV_FPGA
	 .comp_out(compout_DFFQ7) //output
    );
	 
	 LS_CNT LS_CNT_DFFQ8(
	 .clk_100m (clk_100m),
    .CLK (CLK_MUXOUT), //input from CLK_GEN_TOP
    .RST_PER (w_rst),//input (active high)
    .CREST_IN (DB_DFFQ8), //input
    .RPG_IN (DAT_DUT), //input from DATA_GEN
    .ERR_CNT (ERR_CNT_DFFQ8), //output
	 .CLK_CTRL(CLK_CTRL), //input from DATA_RCV_FPGA
	 .comp_out(compout_DFFQ8) //output
    );
	 LS_CNT LS_CNT_DFFQ9(
	 .clk_100m (clk_100m),
    .CLK (CLK_MUXOUT), //input from CLK_GEN_TOP
    .RST_PER (w_rst),//input (active high)
    .CREST_IN (DB_DFFQ9), //input
    .RPG_IN (DAT_DUT), //input from DATA_GEN
    .ERR_CNT (ERR_CNT_DFFQ9), //output
	 .CLK_CTRL(CLK_CTRL), //input from DATA_RCV_FPGA
	 .comp_out(compout_DFFQ9) //output
    );
	 LS_CNT LS_CNT_DFFQ10(
	 .clk_100m (clk_100m),
    .CLK (CLK_MUXOUT), //input from CLK_GEN_TOP
    .RST_PER (w_rst),//input (active high)
    .CREST_IN (DB_DFFQ10), //input
    .RPG_IN (DAT_DUT), //input from DATA_GEN
    .ERR_CNT (ERR_CNT_DFFQ10), //output
	 .CLK_CTRL(CLK_CTRL), //input from DATA_RCV_FPGA
	 .comp_out(compout_DFFQ10) //output
    );
	 LS_CNT LS_CNT_DFFQ11(
	 .clk_100m (clk_100m),
    .CLK (CLK_MUXOUT), //input from CLK_GEN_TOP
    .RST_PER (w_rst),//input (active high)
    .CREST_IN (DB_DFFQ11), //input
    .RPG_IN (DAT_DUT), //input from DATA_GEN
    .ERR_CNT (ERR_CNT_DFFQ11), //output
	 .CLK_CTRL(CLK_CTRL), //input from DATA_RCV_FPGA
	 .comp_out(compout_DFFQ11) //output
    );
	 LS_CNT LS_CNT_DFFQ12(
	 .clk_100m (clk_100m),
    .CLK (CLK_MUXOUT), //input from CLK_GEN_TOP
    .RST_PER (w_rst),//input (active high)
    .CREST_IN (DB_DFFQ12), //input
    .RPG_IN (DAT_DUT), //input from DATA_GEN
    .ERR_CNT (ERR_CNT_DFFQ12), //output
	 .CLK_CTRL(CLK_CTRL), //input from DATA_RCV_FPGA
	 .comp_out(compout_DFFQ12)//output
    );
	 LS_CNT LS_CNT_DFFQ13(
	 .clk_100m (clk_100m),
    .CLK (CLK_MUXOUT), //input from CLK_GEN_TOP
    .RST_PER (w_rst),//input (active high)
    .CREST_IN (DB_DFFQ13), //input
    .RPG_IN (DAT_DUT), //input from DATA_GEN
    .ERR_CNT (ERR_CNT_DFFQ13), //output
	 .CLK_CTRL(CLK_CTRL), //input from DATA_RCV_FPGA
	 .comp_out(compout_DFFQ13) //output
    );
	 
	 /*
	 UART_TOP UART (
    //.clk(clk_50m_sys), //input from CLK_GEN_TOP
//	 .CLK_MUXOUT(CLK_MUXOUT),
	 .CLK_MUXOUT(CLK_100K),
	 .clk(clk_50m_sys),
	 
	 .start(start_uart),
	 .uart_reset(uart_reset),
	 .do_fifo_do(do_fifo_do),
    .gl_reset(w_rst), //input
    .en_wr(en_xmit), //input from REGISTER
    .rd_bit(1'b0), //input
    .data_in(data_fpga), //input from REGISTER
    .sin(SIN), //input
	.full(full_wire),
    .empty(empty_xmit), //output
    .write(write_xmit), //output
    .empty_rcv(empty_rcv), //output
    .sout(SOUT), //output
    .data_rcv(data_rcv), //output
	 //
	 .data_db(data_db)
    );
	 
	 DATA_RCV_FPGA CONF (
    .empty_rcv(empty_rcv), //input from UART_TOP
    .data_rcv(data_rcv), //input from UART_TOP
    .rst(w_rst), //input 
    .clk(clk_50m_sys), //input from CLK_GEN_TOP
    .data_cntrl(DAT_CTL), //output
    .clk_cntrl(CLK_CTRL), //output
	 .start(start), //output
	 .data_ex(data_ex)
    );
	 
	 

// the rest is for debugging only
	 //checking inputs
	 
	REGISTER REGISTER (
    .CLK_50M(clk_50m_sys), //input from CLK_GEN_TOP
//	.CLK_100K(CLK_100K),
	  .CLK_MUXOUT(CLK_100K), //input from CLK_GEN_TOP
//    .CLK_MUXOUT(CLK_MUXOUT), //input from CLK_GEN_TOP
	 .RST_B(RST_B),
     .r_rst(w_rst), //active high
	 .uart_reset(uart_reset),
	 .do_fifo_do(do_fifo_do),
     .DAT_FPGA0(ERR_CNT_DFFQ0[7:0]),
	 .DAT_FPGA1(ERR_CNT_DFFQ0[15:8]),
	 .DAT_FPGA2(ERR_CNT_DFFQ0[23:16]),
	 .DAT_FPGA3(ERR_CNT_DFFQ0[31:24]),
	 
	 .DAT_FPGA4(ERR_CNT_DFFQ1[7:0]),
	 .DAT_FPGA5(ERR_CNT_DFFQ1[15:8]),
	 .DAT_FPGA6(ERR_CNT_DFFQ1[23:16]),
	 .DAT_FPGA7(ERR_CNT_DFFQ1[31:24]),
	 
	 .DAT_FPGA8(ERR_CNT_DFFQ2[7:0]),
	 .DAT_FPGA9(ERR_CNT_DFFQ2[15:8]),
	 .DAT_FPGA10(ERR_CNT_DFFQ2[23:16]),
	 .DAT_FPGA11(ERR_CNT_DFFQ2[31:24]),
	 
	 .DAT_FPGA12(ERR_CNT_DFFQ3[7:0]),
	 .DAT_FPGA13(ERR_CNT_DFFQ3[15:8]),
	 .DAT_FPGA14(ERR_CNT_DFFQ3[23:16]),
	 .DAT_FPGA15(ERR_CNT_DFFQ3[31:24]),
	 
	 .DAT_FPGA16(ERR_CNT_DFFQ4[7:0]),
	 .DAT_FPGA17(ERR_CNT_DFFQ4[15:8]),
	 .DAT_FPGA18(ERR_CNT_DFFQ4[23:16]),
	 .DAT_FPGA19(ERR_CNT_DFFQ4[31:24]),
	 
	 .DAT_FPGA20(ERR_CNT_DFFQ5[7:0]),
	 .DAT_FPGA21(ERR_CNT_DFFQ5[15:8]),
	 .DAT_FPGA22(ERR_CNT_DFFQ5[23:16]),
	 .DAT_FPGA23(ERR_CNT_DFFQ5[31:24]),
	 
	 .DAT_FPGA24(ERR_CNT_DFFQ6[7:0]),
	 .DAT_FPGA25(ERR_CNT_DFFQ6[15:8]),
	 .DAT_FPGA26(ERR_CNT_DFFQ6[23:16]),
	 .DAT_FPGA27(ERR_CNT_DFFQ6[31:24]),
	 
	 .DAT_FPGA28(ERR_CNT_DFFQ7[7:0]),
	 .DAT_FPGA29(ERR_CNT_DFFQ7[15:8]),
	 .DAT_FPGA30(ERR_CNT_DFFQ7[23:16]),
	 .DAT_FPGA31(ERR_CNT_DFFQ7[31:24]),
	 
	 .DAT_FPGA32(ERR_CNT_DFFQ8[7:0]),
	 .DAT_FPGA33(ERR_CNT_DFFQ8[15:8]),
	 .DAT_FPGA34(ERR_CNT_DFFQ8[23:16]),
	 .DAT_FPGA35(ERR_CNT_DFFQ8[31:24]), 
	 
	 .DAT_FPGA36(ERR_CNT_DFFQ9[7:0]),
	 .DAT_FPGA37(ERR_CNT_DFFQ9[15:8]),
	 .DAT_FPGA38(ERR_CNT_DFFQ9[23:16]),
	 .DAT_FPGA39(ERR_CNT_DFFQ9[31:24]),
	 
	 .DAT_FPGA40(ERR_CNT_DFFQ10[7:0]),
	 .DAT_FPGA41(ERR_CNT_DFFQ10[15:8]),
	 .DAT_FPGA42(ERR_CNT_DFFQ10[23:16]),
	 .DAT_FPGA43(ERR_CNT_DFFQ10[31:24]),
	 
	 .DAT_FPGA44(ERR_CNT_DFFQ11[7:0]),
	 .DAT_FPGA45(ERR_CNT_DFFQ11[15:8]),
	 .DAT_FPGA46(ERR_CNT_DFFQ11[23:16]),
	 .DAT_FPGA47(ERR_CNT_DFFQ11[31:24]),
	 
	 .DAT_FPGA48(ERR_CNT_DFFQ12[7:0]),
	 .DAT_FPGA49(ERR_CNT_DFFQ12[15:8]),
	 .DAT_FPGA50(ERR_CNT_DFFQ12[23:16]),
	 .DAT_FPGA51(ERR_CNT_DFFQ12[31:24]),
	 
	 .DAT_FPGA52(ERR_CNT_DFFQ13[7:0]),
	 .DAT_FPGA53(ERR_CNT_DFFQ13[15:8]),
	 .DAT_FPGA54(ERR_CNT_DFFQ13[23:16]),
	 .DAT_FPGA55(ERR_CNT_DFFQ13[31:24]),
	 
	
	 
	 
	 
    .write(write_xmit), //input from UART_TOP
    .EMPTY(empty_xmit), //input from UART_TOP (to ensure the lat data has been sent entirely?)
    .en_xmit(en_xmit), //output
    .dout(data_fpga), //output
	 
	 //need to change
 	 .start(1'b1), //input from DATA_RCV_FPGA
	 //debug
	 .OUT_DB(out_db) //output for debugging
    );
	 
	 */
	 
	 
	 // Files for SRAM and RO tests here ###########################################
	 
	 // Signals for modules
	 assign SRAM_CLK = CLK_MUXOUT & read_data_RO_pi;
	 
	 wire [63:0] data_count;
	 wire [14:0] SRAM_ADDRESS_START;
	 wire [14:0] SRAM_ADDRESS_END;
	 wire [31:0] INV_COUNT;
	 wire [31:0] NAND_COUNT;
	 wire [31:0] NOR_COUNT;
	 
	 
	 // Brings in sram test data from the pi and keeps track of when to start the tests
	 SRAM_DATA_GEN SRAM_DATA_GEN_1 (
		.reset(reset_sram_RO_pi),
		.data(data_pi),
		.data_clk(data_clk_pi),
		.SRAM_DATA_IN(SRAM_DATA_IN),
		.SRAM_ADDRESS_START(SRAM_ADDRESS_START),
		.SRAM_ADDRESS_END(SRAM_ADDRESS_END),
		.data_count(data_count)
	);
	
	// module to run the sram test
	SRAM_DATA_CMPR SRAM_DATA_CMPR_1 (
		.CLK(CLK_MUXOUT),
		.sram_data_clk(sram_data_out_clk_pi),
		.reset(reset_sram_RO_pi),
		.data_count(data_count),
		.clear_error(clear_error),
		.SRAM_DATA_IN(SRAM_DATA_IN),
		.SRAM_DATA_OUT(SRAM_DATA_OUT),
		.SRAM_ADDRESS_START(SRAM_ADDRESS_START),
		.SRAM_ADDRESS_END(SRAM_ADDRESS_END),
		.SRAM_ADDRESS(SRAM_ADDRESS),
		.error(sram_error_pi),
		.sram_data_pi(sram_data_out_pi),
		.RDWEN(RDWEN)
	);
	
	
	// module to collect RO frequencies
	RO_FREQ_COUNTER RO_FREQ_COUNTER_1 (
		.CLK(CLK_MUXOUT),
		.read_data(read_data_RO_pi),
		.O_INV(O_INV),
		.O_NAND(O_NAND),
		.O_NOR(O_NOR),
		.INV_COUNT(INV_COUNT),
		.NAND_COUNT(NAND_COUNT),
		.NOR_COUNT(NOR_COUNT)
	);
	
	//module to output the RO data to the pi
	RO_DATA_OUTPUT	RO_DATA_OUTPUT_1 (
		.data_clk(data_clk_RO_pi),
		.reset(reset_sram_RO_pi),
		.INV_COUNT(INV_COUNT),
		.NAND_COUNT(NAND_COUNT),
		.NOR_COUNT(NOR_COUNT),
		.C(C),
		.DATA_OUT(data_out_RO_pi)
	);
	
	
	// new file for outputting DFF data
	DFF_DATA_OUTPUT DFF_DATA_OUTPUT_1 (
		.data_clk(data_clk_dff_pi),
		.reset(reset_sram_RO_pi),
		.save_data(save_data_dff_pi),
		.DFF_ERROR_0(ERR_CNT_DFFQ0),
		.DFF_ERROR_1(ERR_CNT_DFFQ1),
		.DFF_ERROR_2(ERR_CNT_DFFQ2),
		.DFF_ERROR_3(ERR_CNT_DFFQ3),
		.DFF_ERROR_4(ERR_CNT_DFFQ4),
		.DFF_ERROR_5(ERR_CNT_DFFQ5),
		.DFF_ERROR_6(ERR_CNT_DFFQ6),
		.DFF_ERROR_7(ERR_CNT_DFFQ7),
		.DFF_ERROR_8(ERR_CNT_DFFQ8),
		.DFF_ERROR_9(ERR_CNT_DFFQ9),
		.DFF_ERROR_10(ERR_CNT_DFFQ10),
		.DFF_ERROR_11(ERR_CNT_DFFQ11),
		.DFF_ERROR_12(ERR_CNT_DFFQ12),
		.DFF_ERROR_13(ERR_CNT_DFFQ13),
		.DATA_OUT(data_out_dff_pi)
	);
		
	 
	 
	 
	endmodule
