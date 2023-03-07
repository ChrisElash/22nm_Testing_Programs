module baudrate_gen
(
    input   I_clk                  , // 系统50MHz时钟
    input   I_rst                , // 系统全局复位
    input   I_bps_tx_clk_en        , // 串口发送模块波特率时钟使能信号
    input   I_bps_rx_clk_en        , // 串口接收模块波特率时钟使能信号
    output  O_bps_tx_clk           , // 发送模块波特率产生时钟
    output  O_bps_rx_clk             // 接收模块波特率产生时钟
);

parameter       C_BPS9600         = 5207         ,    //波特率为9600bps
                C_BPS19200        = 2603         ,    //波特率为19200bps
                C_BPS38400        = 1301         ,    //波特率为38400bps
                C_BPS57600        = 867          ,    //波特率为57600bps
                C_BPS115200       = 433          ;    //波特率为115200bps
                
parameter       C_BPS_SELECT      = C_BPS115200  ;    //波特率选择
                

reg [12:0]  R_bps_tx_cnt       ;
reg [12:0]  R_bps_rx_cnt       ;

///////////////////////////////////////////////////////////    
// 功能：串口发送模块的波特率时钟产生逻辑
///////////////////////////////////////////////////////////
always @(posedge I_clk or posedge I_rst)
begin
    if(I_rst)
        R_bps_tx_cnt <= 13'd0 ;
    else if(I_bps_tx_clk_en == 1'b1)
        begin
            if(R_bps_tx_cnt == C_BPS_SELECT)
                R_bps_tx_cnt <= 13'd0 ;
            else
                R_bps_tx_cnt <= R_bps_tx_cnt + 1'b1 ;                 
        end    
    else
        R_bps_tx_cnt <= 13'd0 ;        
end

assign O_bps_tx_clk = (R_bps_tx_cnt == 13'd1) ? 1'b1 : 1'b0 ;

///////////////////////////////////////////////////////////    
// 功能：串口接收模块的波特率时钟产生逻辑
///////////////////////////////////////////////////////////
always @(posedge I_clk or posedge I_rst)
begin
    if(I_rst)
        R_bps_rx_cnt <= 13'd0 ;
    else if(I_bps_rx_clk_en == 1'b1)
        begin
            if(R_bps_rx_cnt == C_BPS_SELECT)
                R_bps_rx_cnt <= 13'd0 ;
            else
                R_bps_rx_cnt <= R_bps_rx_cnt + 1'b1 ;                 
        end    
    else
        R_bps_rx_cnt <= 13'd0 ;        
end

assign O_bps_rx_clk = (R_bps_rx_cnt == C_BPS_SELECT >> 1'b1) ? 1'b1 : 1'b0 ;

endmodule