module uart_top
(
    input            I_clk           , // 系统50MHz时钟
    input            I_rst_n         , // 系统全局复位
    input            I_rs232_rxd     , // 接收的串行数据，在硬件上与串口相连
    output           O_rs232_txd     , // 发送的串行数据，在硬件上与串口相连
    output    [3:0]  O_led_out       
);

wire            W_bps_tx_clk                 ;
wire            W_bps_tx_clk_en              ;
wire            W_bps_rx_clk                 ;
wire            W_bps_rx_clk_en              ;
wire            W_rx_done                    ;
wire            W_tx_done                    ;
wire  [7:0]     W_para_data                  ;

assign    O_led_out = W_para_data[3:0]       ;

baudrate_gen U_baudrate_gen
(
    .I_clk              (I_clk              ), // 系统50MHz时钟
    .I_rst_n            (I_rst_n            ), // 系统全局复位
    .I_bps_tx_clk_en    (W_bps_tx_clk_en    ), // 串口发送模块波特率时钟使能信号
    .I_bps_rx_clk_en    (W_bps_rx_clk_en    ), // 串口接收模块波特率时钟使能信号
    .O_bps_tx_clk       (W_bps_tx_clk       ), // 发送模块波特率产生时钟
    .O_bps_rx_clk       (W_bps_rx_clk       )  // 接收模块波特率产生时钟
);

uart_txd U_uart_txd
(
    .I_clk               (I_clk                 ), // 系统50MHz时钟
    .I_rst_n             (I_rst_n               ), // 系统全局复位
    .I_tx_start          (W_rx_done             ), // 发送使能信号
    .I_bps_tx_clk        (W_bps_tx_clk          ), // 波特率时钟
    .I_para_data         (W_para_data           ), // 要发送的并行数据
    .O_rs232_txd         (O_rs232_txd           ), // 发送的串行数据，在硬件上与串口相连
    .O_bps_tx_clk_en     (W_bps_tx_clk_en       ), // 波特率时钟使能信号
    .O_tx_done           (W_tx_done             )  // 发送完成的标志
);

uart_rxd U_uart_rxd
(
    .I_clk              (I_clk                ), // 系统50MHz时钟
    .I_rst_n            (I_rst_n              ), // 系统全局复位
    .I_rx_start         (1'b1                 ), // 接收使能信号
    .I_bps_rx_clk       (W_bps_rx_clk         ), // 接收波特率时钟
    .I_rs232_rxd        (I_rs232_rxd          ), // 接收的串行数据，在硬件上与串口相连  
    .O_bps_rx_clk_en    (W_bps_rx_clk_en      ), // 波特率时钟使能信号
    .O_rx_done          (W_rx_done            ), // 接收完成标志
    .O_para_data        (W_para_data          )  // 接收到的8-bit并行数据
);

endmodule