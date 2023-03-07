
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name SE_UART_TEST -dir "C:/Users/Young Yang/Desktop/22nm_5_1_v1/planAhead_run_3" -part xc5vlx50ff1153-3
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "DFF_TEST_UCF.ucf" [current_fileset -constrset]
add_files [list {ipcore_dir/FIFO.ngc}]
add_files [list {ipcore_dir/R_FIFO.ngc}]
set hdlfile [add_files [list {ipcore_dir/R_FIFO.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ipcore_dir/FIFO.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {XMIT_FIFO.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {uart_rxd.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {uart_new/uart_txd.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {uart_new/baudrate_gen.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {RCV_FIFO.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {CLK_GEN.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {UART_TOP.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {REGISTER.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {LS_CNT.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {DATA_RCV_FPGA.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {DATA_GEN.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {CLK_GEN_TOP.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {DFF_TEST_NEW_TOP.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set_property top DFF_TEST_NEW_TOP $srcset
add_files [list {DFF_TEST_UCF.ucf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/FIFO.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/R_FIFO.ncf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc5vlx50ff1153-3
