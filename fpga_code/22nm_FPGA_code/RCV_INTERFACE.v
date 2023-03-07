`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:06:22 08/22/2016 
// Design Name: 
// Module Name:    RCV_INTERFACE 
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
module RCV_INTERFACE(
    input clk, //buad_8x, which request 8 clock cycles to read one bit
    input din,
    input gl_reset,
    output reg dError, //indicate whether error bit generated from transmission
    output [7:0] dout,
    output reg dReady
    );

	reg [7:0] shift_out;
	reg [7:0] data_out;
	reg [3:0] shift_reg; //Question: why need a shift register?
	reg [1:0] current_state;
	reg [1:0] next_state;
	reg [3:0] cnt;
	reg [3:0] bit_cnt;
	reg cntrl_cnt; //all cnt are used for count the time for reading bits
	reg check;
	reg pa_in;
	
	reg valid;
	
//	assign cs = current_state[0];
	
	parameter [1:0]
	rx_idle = 2'b00,
	rx_start = 2'b01,
	rx_data = 2'b10,
	rx_stop = 2'b11;
	
	always @ (posedge clk) begin
		if(!gl_reset) //active low, synchronous reset
			shift_reg = 0;
		else
			shift_reg = {shift_reg[2:0], din};
	end
	
	always @ (posedge clk) begin
		if(valid) begin
			cnt <= 4'b0;
			cntrl_cnt <= 0;
			bit_cnt <= 4'b0;
		end
		else if(cnt == 4'b1000 && cntrl_cnt == 0) begin//time for reading start bit
			cnt <= 4'b0;
			cntrl_cnt <= 1;
		end
		else if(cnt == 4'b0111 && cntrl_cnt == 1) begin//8 baud_8x cycles to read one bit
			cnt <= 4'b0;	
			bit_cnt <= bit_cnt + 1; //count the time for reading data bits and parity bit
		end
		else if(bit_cnt == 4'b1001 && cntrl_cnt == 1) begin//reset bit count and cnt for new counting loop
			cntrl_cnt <= 0;
			bit_cnt <= 3'b0; //after reading the parity bit
		end
		else begin
			cnt <= cnt + 1;
		end
	end
			
	always @ (posedge clk or negedge gl_reset) begin
		if(!gl_reset) //active low, asynchronous reset
			current_state <= rx_idle;
		else
			current_state <= next_state;
		end
	
	always @ (*) begin
		case(current_state)
		rx_idle: begin
			if(valid)//start bit was detected
				next_state = rx_start;
			else
				next_state = rx_idle;
		end
		rx_start: begin
			if(cnt == 4'b1000 && cntrl_cnt == 0)
				next_state = rx_data;
			else
				next_state = rx_start;
		end
		rx_data: begin
			if(bit_cnt == 4'b1000 && cntrl_cnt == 1) //reading data bits
				next_state = rx_stop;
			else
				next_state = rx_data;
		end
		rx_stop: begin
			if(bit_cnt == 4'b1001 && cntrl_cnt == 1) //reading parity bit
				next_state = rx_idle;
			else
				next_state = rx_stop;
		end
		default:
			next_state = rx_idle;
		endcase
	end
	
	always @ (posedge clk /*or negedge gl_reset*/) begin
		case(next_state)
		rx_idle: begin
			valid <= (shift_reg[0] == 0) & (shift_reg[2] == 0) & (shift_reg[3] == 1);//detect the start bit
			dError <= 0;
			dReady <=0;
		end
		rx_start: begin
			valid <= 0;
			dError <= 0;
			dReady <= 0;
			shift_out[7:0] <= 8'b0;
		end
		rx_data: begin
			valid <= 0;
			dError <= 0;
			dReady <= 0;
			if(cnt == 4'b0000)
				shift_out[7:0] <= {din, shift_out[7:1]};
			else
				shift_out[7:0] <= shift_out[7:0];
		end
		rx_stop: begin
			valid <= 0;
			if(cnt == 4'b0001)
				pa_in <= din; //reading parity bit

			else if(cnt == 4'b0010)
				check <= ^{shift_out[7:0], pa_in}; //check whether error generated in the transmission period
				
			else if(cnt == 4'b0100 && check == 1) begin //error
				dError <= 1;
				dReady <= 0;
				data_out[7:0] <= 8'b0;
			end
			else if(cnt == 4'b0100 && check == 0) begin //no error
				dReady <= 1;
				data_out[7:0] <= shift_out[7:0];
			end
			else begin //Question: why need this part?
				pa_in <= pa_in;
				check <= check;
				data_out <= data_out;
				dError <= dError;
			end

		end
		endcase
	end
	
		assign dout = (dReady == 1) ? data_out:8'b0; //if dReady is 1, dout = data_out; else dout = 8'b0
endmodule
