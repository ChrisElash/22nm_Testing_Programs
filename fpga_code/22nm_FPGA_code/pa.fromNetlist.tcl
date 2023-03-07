
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name SE_UART_TEST -dir "C:/Users/Young Yang/Desktop/22nm_5_1_v1/planAhead_run_1" -part xc5vlx50ff1153-3
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "C:/Users/Young Yang/Desktop/22nm_5_1_v1/DFF_TEST_NEW_TOP.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/Users/Young Yang/Desktop/22nm_5_1_v1} {ipcore_dir} }
add_files [list {ipcore_dir/FIFO.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/R_FIFO.ncf}] -fileset [get_property constrset [current_run]]
set_param project.pinAheadLayout  yes
set_property target_constrs_file "DFF_TEST_UCF.ucf" [current_fileset -constrset]
add_files [list {DFF_TEST_UCF.ucf}] -fileset [get_property constrset [current_run]]
link_design
