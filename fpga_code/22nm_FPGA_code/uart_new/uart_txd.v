module uart_txd
(
    input          I_clk           , // 50mhz
    input          I_rst         , // ??????
    input          I_tx_start      , // ??????
    input          I_bps_tx_clk    , // ???????
    input   [7:0]  I_para_data     , // ????????
	 input          FIFO_empty,
    output  reg    O_rs232_txd     , // ???????,?????????
    output  reg    O_bps_tx_clk_en , // ?????????
    output  reg    O_tx_done         // ???????
);

reg  [3:0]  R_state ;
reg o_tx_done_delay; //o_tx_done delay one clk
reg R_transmiting ; // ????????


// o_tx_done delay signal 
always@(posedge I_clk) begin
	o_tx_done_delay <= O_tx_done;
end




/////////////////////////////////////////////////////////////////////////////
// ???? R_transmiting ???
/////////////////////////////////////////////////////////////////////////////
always @(posedge I_clk or posedge I_rst)
begin
    if(I_rst)
        R_transmiting <= 1'b0 ;
    else if(O_tx_done)
        R_transmiting <= 1'b0 ;
    else if(I_tx_start|| (o_tx_done_delay && !FIFO_empty))
        R_transmiting <= 1'b1 ;          
end

/////////////////////////////////////////////////////////////////////////////
// ???????
/////////////////////////////////////////////////////////////////////////////
always @(posedge I_clk or posedge I_rst)
begin
    if(I_rst)
        begin
            R_state      <= 4'd0 ;
            O_rs232_txd  <= 1'b1 ; 
            O_tx_done    <= 1'b0 ;
            O_bps_tx_clk_en <= 1'b0 ;  // ???????????
        end 
    else if(R_transmiting) // ?????????,??????
        begin
            O_bps_tx_clk_en <= 1'b1 ;  // ???????????????????????
            if(I_bps_tx_clk) // ????????????????????????,?????????
                begin
                    case(R_state)
                        4'd0  : // ?????
                            begin
										  O_bps_tx_clk_en <= 1'b1 ;
                                O_rs232_txd  <= 1'b0            ;
                                O_tx_done    <= 1'b0            ; 
                                R_state      <= R_state + 1'b1  ;
                            end
                        4'd1  : // ?? I_para_data[0]
                            begin
										  O_bps_tx_clk_en <= 1'b1 ;
                                O_rs232_txd  <= I_para_data[0]  ;
                                O_tx_done    <= 1'b0            ; 
                                R_state      <= R_state + 1'b1  ;
                            end 
                        4'd2  : // ?? I_para_data[1]
                            begin
							           O_bps_tx_clk_en <= 1'b1 ;
                                O_rs232_txd  <= I_para_data[1]   ;
                                O_tx_done    <= 1'b0             ; 
                                R_state      <= R_state + 1'b1   ;
                            end
                        4'd3  : // ?? I_para_data[2]
                            begin
                                O_bps_tx_clk_en <= 1'b1 ;
										  O_rs232_txd  <= I_para_data[2]   ;
                                O_tx_done    <= 1'b0             ; 
                                R_state      <= R_state + 1'b1   ;
                            end
                        4'd4  : // ?? I_para_data[3]
                            begin
                                O_bps_tx_clk_en <= 1'b1 ;
										  O_rs232_txd  <= I_para_data[3]   ;
                                O_tx_done    <= 1'b0             ; 
                                R_state      <= R_state + 1'b1   ;
                            end 
                        4'd5  : // ?? I_para_data[4]
                            begin
                                O_bps_tx_clk_en <= 1'b1 ;
										  O_rs232_txd  <= I_para_data[4]   ;
                                O_tx_done    <= 1'b0             ; 
                                R_state      <= R_state + 1'b1   ;
                            end
                        4'd6  : // ?? I_para_data[5]
                            begin
                                O_bps_tx_clk_en <= 1'b1 ;
										  O_rs232_txd  <= I_para_data[5]   ;
                                O_tx_done    <= 1'b0             ; 
                                R_state      <= R_state + 1'b1   ;
                            end
                        4'd7  : // ?? I_para_data[6]
                            begin
                                O_bps_tx_clk_en <= 1'b1 ;
										  O_rs232_txd  <= I_para_data[6]   ;
                                O_tx_done    <= 1'b0             ; 
                                R_state      <= R_state + 1'b1   ;
                            end
                        4'd8  : // ?? I_para_data[7]
                            begin
                                O_bps_tx_clk_en <= 1'b1 ;
										  O_rs232_txd  <= I_para_data[7]   ;
                                O_tx_done    <= 1'b0             ; 
                                R_state      <= R_state + 1'b1   ;
                            end 
                        4'd9  : // ?? ???
                            begin
										  O_bps_tx_clk_en <= 1'b1 ;
                                O_rs232_txd  <= 1'b1             ;
                                O_tx_done    <= 1'b1             ; 
                                R_state      <= 4'd0          ;
                            end
                        default :R_state      <= 4'd0            ;
          endcase 
        end 
      end 
    else 
      begin 
        //O_bps_tx_clk_en    <= 1'b1  ; // ?????????????????????? 
        R_state         <= 4'd0  ; 
        O_tx_done        <= 1'b0  ; 
        O_rs232_txd      <= 1'b1  ;  
      end 
end 

endmodule 