`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:10:02 08/22/2016 
// Design Name: 
// Module Name:    UART_TOP 
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
module UART_TOP(
    input clk,
	 input gl_reset, //0 reset, 1 work, from gl_reset <= RST_PER
    input en_wr, //1 means work
    input rd_bit,
    input [7:0] data_in,
    input sin,
	 input start,
	 
	 // add clk_mux 
	 input CLK_MUXOUT,
	 input do_fifo_do, //////from Register if the error count has been changed
	 
	 output uart_reset,
    output empty,
	 output write,
	 output empty_rcv, //if empty_rcv = 0, fifo is empty (nothing to read)
    output sout,
    output [7:0] data_rcv,
	output full,
	 //
	 output data_db
    );

	wire baud;
	wire baud_8x;
	wire load;	
	wire busy; //revise from comment
	wire err;
	wire ready;
	wire [7:0] data_xmit;
	wire [7:0] data_out;
	//wire clk;
	
	
	
	// wire for new uart
	wire empty_pose;
	wire W_tx_done;
	wire W_bps_tx_clk_en;
	wire W_bps_rx_clk_en;
	wire W_bps_tx_clk;
	wire W_bps_rx_clk;
	
	
	reg reset_delay;		
	wire reset_pulse; ////to catch the g1_reset turn down
	reg [7:0]debug_reg;
	wire [7:0]debug_wire;
	
	reg after_pulse;
	wire after_pulse_wire;
	wire do_do_fifo;
	
	assign reset_pulse = !gl_reset & reset_delay;
	assign after_pulse_wire = after_pulse;
	assign uart_reset = after_pulse_wire;
	
	
	initial begin
		after_pulse = 1'b0;
		debug_reg = 8'b0;
	end
	
	always@(posedge clk)
		reset_delay <= gl_reset;
	
	always@(posedge clk)
		if(reset_pulse)
			after_pulse <= 1'b1;
	
	always@(posedge clk)
		if(after_pulse)
			debug_reg <= data_xmit;
		else
			debug_reg <= debug_reg;
	
	
	assign debug_wire = debug_reg;
	
	assign do_do_fifo = after_pulse_wire&do_fifo_do;

	
	
	
	
//	assign ready_db = ready;
//	assign reset_db = gl_reset;
//	assign clk_db = clk;
	
	//generate baud signal based on two different baud rate which allow reading one bit per cycle
	//BAUD_GENERATOR G1( .clk			(clk), //input
	//						 .rst		(gl_reset), //input
	//						 .baud		(baud), //output
	//						 .baud_8x	(baud_8x)); //output
							 
	
	baudrate_gen G1(
								.I_clk              (clk), // system clock
		                  .I_rst            (gl_reset), // system reset work low
		                  .I_bps_tx_clk_en    (1'b1), //   
		                  .I_bps_rx_clk_en    (W_bps_rx_clk_en), //  baud_rx_enable
		                  .O_bps_tx_clk       (W_bps_tx_clk),    // tx_baud_rate
		                  .O_bps_rx_clk       (W_bps_rx_clk));   // rx_baud_rate


	uart_txd U_uart_txd(
								.I_clk               (clk),
                        .I_rst             (reset_delay), // system reset work low
                        .I_bps_tx_clk        (W_bps_tx_clk), // tx baud_rate
                        .I_para_data         (debug_wire), // input data
                        .O_rs232_txd         (sout), // ouput 1 bit data
                        .O_bps_tx_clk_en     (W_bps_tx_clk_en), //    ===> baud_gen enable 
								.FIFO_empty          (empty),
								
								// handshake 
								.I_tx_start          (empty_pose), // fifo use need change
                        .O_tx_done           (W_tx_done));  // 
	
	uart_rxd U_uart_rxd(
								.I_clk	(clk),
								.I_rst (gl_reset),
								.I_rx_start(1'b1),
								.I_bps_rx_clk(W_bps_rx_clk),
								.I_rs232_rxd(sin),
								.start(start),
								.O_bps_rx_clk_en(W_bps_rx_clk_en),
								.O_rx_done(),
								.O_para_data(data_out));
	
	
//	XMIT_INTERFACE I1( .clk			(clk), //input
//							 .baud		(baud), //input from BAUD_GENERATOR
//							 .rst_n		(gl_reset), //input
//							 .load		(load), //input from XMIT_FIFO
//							 .din			(data_xmit), //input from XMIT_FIFO
//							 .tx_data	(sout), //output
//							 .tx_busy	(busy)); //output
							 
//	RCV_INTERFACE I2( .clk			(baud_8x),//input from BAUD_GENERATOR (use for counting the time for reading bits)
//							.din			(sin), //input
//							.gl_reset	(gl_reset), //input
//							.dError		(err), //output
//							.dout			(data_out), //output
//							.dReady		(ready)); //output
	
	
//	status_register R1( .clk		(clk),
//							  .en_write	(en_xmit), 
//							  .busy		(busy), 
//							  .load		(load));



	RCV_FIFO F1(.clk			(clk), //input
					.err			(err), //input from RCV_INTERFACE
					.din			(data_out), //input from RCV_INTERFAC
					.rst			(gl_reset), //input
					.en_rd		(rd_bit), //input
					.en_rcv		(ready), //input from RCV_INTERFAC
					.empty_rcv	(empty_rcv), //output
					.dout			(data_rcv)); //output
					
					
					
					
	XMIT_FIFO F2(.clk			(clk),	//input
					 .CLK_MUXOUT (CLK_MUXOUT),
					 .busy		(busy), //input from XMIT_INTERFACE
					 .din			(data_in), //input 
					 .rst			(gl_reset), //input
					 .en_wr		(en_wr), //1 means work (input)
					 .write		(write), //output
					 .full(full),
					 .empty		(empty), //1 means empty (output)
					 .dout		(data_xmit), //output
					 .load		(W_tx_done), //output
					 .baud_clk   (W_bps_tx_clk),
					 //
					// .data_db   (data_db), //output
					 .empty_pose(empty_pose));
							  
endmodule
