`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:34:33 08/18/2016 
// Design Name: 
// Module Name:    XMIT_INTERFACE 
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
module XMIT_INTERFACE(
    input clk,
    input baud,
    input rst_n,
    input load, //from xmit_FIFO, the command of whether allow transmit
	 input [7:0] din, //data need to be transmitted
    output tx_data, //transmit the reuested data to the wire
    output reg tx_busy //indicate the transmiter is transmitting
//	 output ddin
    );
	
	reg [1:0] current_state;
	reg [1:0] next_state;
	reg [3:0] cnt;
//	reg [15:0] cnt2;
	reg [7:0] data_in;
	reg pa_out;
	reg dout;
	
//	wire [7:0] din;
	
//	assign cs = current_state[0];
//	assign ddin = data_in[1];
//	assign ddout = tx_data;
	
	parameter [1:0]
	tx_idle = 2'b01,
	tx_start = 2'b10,
	tx_send = 2'b11;  

	always @ (posedge baud or negedge rst_n or posedge load) begin
		if(!rst_n)
			cnt <= 4'b0;
		else if(load)
			cnt <= 4'b0;
		else
			cnt <= cnt + 1;
	end
	
	always @ (posedge clk or negedge rst_n) begin
		if(!rst_n)
			current_state <= tx_idle;
		else
		current_state <= next_state;
	end
	
	always @ (*) begin
		case(current_state)
		tx_idle: begin
			if(load == 1)
				next_state = tx_start;
			else
				next_state = tx_idle;
		end
		tx_start: begin
			if(cnt == 2) 
				next_state = tx_send;
			else
				next_state = tx_start;
		end
		tx_send: begin
			if(cnt > 9) 
				next_state = tx_idle;
			else
				next_state = tx_send;
		end
		default:
			next_state = tx_idle;
		endcase
		
	end
	
	always @ (posedge clk) begin
		case(next_state)
		tx_idle: begin
			dout <= 1;
			tx_busy <= 0;
		end
		tx_start: begin
			tx_busy <= 1;
			data_in[7:0] <= din;
			pa_out <= ^din[7:0];//for parity bit 
			
			if(cnt == 1) //start bit
				dout <= 0;
			else
				dout <= dout;

			
		end
		tx_send: begin
			tx_busy <= 1;
			if(cnt == 2)
				dout <= data_in[0];
			else if(cnt == 3)
				dout <= data_in[1];
			else if(cnt == 4)
				dout <= data_in[2];
			else if(cnt == 5)
				dout <= data_in[3];
			else if(cnt == 6)
				dout <= data_in[4];
			else if(cnt == 7)
				dout <= data_in[5];
			else if(cnt == 8)
				dout <= data_in[6];
			else if(cnt == 9)
				dout <= data_in[7];	
			//else if(cnt == 11) //parity ssbit
				//dout <= pa_out;
		end
		endcase
	end
	
	assign tx_data = dout;

endmodule

