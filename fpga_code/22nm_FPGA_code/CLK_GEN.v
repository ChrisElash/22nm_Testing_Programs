////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /    Vendor: Xilinx 
// \   \   \/     Version : 14.7
//  \   \         Application : xaw2verilog
//  /   /         Filename : CLK_GEN.v
// /___/   /\     Timestamp : 05/01/2021 19:56:28
// \   \  /  \ 
//  \___\/\___\ 
//
//Command: xaw2verilog -intstyle C:/Users/Young Yang/Desktop/22nm_5_1_v1/ipcore_dir/CLK_GEN.xaw -st CLK_GEN.v
//Design Name: CLK_GEN
//Device: xc5vlx50-3ff1153
//
// Module CLK_GEN
// Generated by Xilinx Architecture Wizard
// Written for synthesis tool: XST
// For block PLL_ADV_INST, Estimated PLL Jitter for CLKOUT0 = 0.365 ns
// For block PLL_ADV_INST, Estimated PLL Jitter for CLKOUT1 = 0.197 ns
// For block PLL_ADV_INST, Estimated PLL Jitter for CLKOUT2 = 0.306 ns
// For block PLL_ADV_INST, Estimated PLL Jitter for CLKOUT3 = 0.151 ns
// For block PLL_ADV_INST, Estimated PLL Jitter for CLKOUT4 = 0.225 ns
`timescale 1ns / 1ps

module CLK_GEN(CLKIN1_IN, 
               CLKOUT0_OUT, 
               CLKOUT1_OUT, 
               CLKOUT2_OUT, 
               CLKOUT3_OUT, 
               CLKOUT4_OUT, 
               LOCKED_OUT);

    input CLKIN1_IN;
   output CLKOUT0_OUT;
   output CLKOUT1_OUT;
   output CLKOUT2_OUT;
   output CLKOUT3_OUT;
   output CLKOUT4_OUT;
   output LOCKED_OUT;
   
   wire CLKFBOUT_CLKFBIN;
   wire CLKIN1_IBUFG;
   wire CLKOUT0_BUF;
   wire CLKOUT1_BUF;
   wire CLKOUT2_BUF;
   wire CLKOUT3_BUF;
   wire CLKOUT4_BUF;
   wire GND_BIT;
   wire [4:0] GND_BUS_5;
   wire [15:0] GND_BUS_16;
   wire VCC_BIT;
   
   assign GND_BIT = 0;
   assign GND_BUS_5 = 5'b00000;
   assign GND_BUS_16 = 16'b0000000000000000;
   assign VCC_BIT = 1;
   IBUFG  CLKIN1_IBUFG_INST (.I(CLKIN1_IN), 
                            .O(CLKIN1_IBUFG));
   BUFG  CLKOUT0_BUFG_INST (.I(CLKOUT0_BUF), 
                           .O(CLKOUT0_OUT));
   BUFG  CLKOUT1_BUFG_INST (.I(CLKOUT1_BUF), 
                           .O(CLKOUT1_OUT));
   BUFG  CLKOUT2_BUFG_INST (.I(CLKOUT2_BUF), 
                           .O(CLKOUT2_OUT));
   BUFG  CLKOUT3_BUFG_INST (.I(CLKOUT3_BUF), 
                           .O(CLKOUT3_OUT));
   BUFG  CLKOUT4_BUFG_INST (.I(CLKOUT4_BUF), 
                           .O(CLKOUT4_OUT));
   PLL_ADV #( .BANDWIDTH("OPTIMIZED"), .CLKIN1_PERIOD(20.000), 
         .CLKIN2_PERIOD(10.000), .CLKOUT0_DIVIDE(100), .CLKOUT1_DIVIDE(4), 
         .CLKOUT2_DIVIDE(40), .CLKOUT3_DIVIDE(1), .CLKOUT4_DIVIDE(8), 
         .CLKOUT0_PHASE(0.000), .CLKOUT1_PHASE(0.000), .CLKOUT2_PHASE(0.000), 
         .CLKOUT3_PHASE(0.000), .CLKOUT4_PHASE(0.000), 
         .CLKOUT0_DUTY_CYCLE(0.500), .CLKOUT1_DUTY_CYCLE(0.500), 
         .CLKOUT2_DUTY_CYCLE(0.500), .CLKOUT3_DUTY_CYCLE(0.500), 
         .CLKOUT4_DUTY_CYCLE(0.500), .COMPENSATION("SYSTEM_SYNCHRONOUS"), 
         .DIVCLK_DIVIDE(1), .CLKFBOUT_MULT(8), .CLKFBOUT_PHASE(0.0), 
         .REF_JITTER(0.000000) ) PLL_ADV_INST (.CLKFBIN(CLKFBOUT_CLKFBIN), 
                         .CLKINSEL(VCC_BIT), 
                         .CLKIN1(CLKIN1_IBUFG), 
                         .CLKIN2(GND_BIT), 
                         .DADDR(GND_BUS_5[4:0]), 
                         .DCLK(GND_BIT), 
                         .DEN(GND_BIT), 
                         .DI(GND_BUS_16[15:0]), 
                         .DWE(GND_BIT), 
                         .REL(GND_BIT), 
                         .RST(GND_BIT), 
                         .CLKFBDCM(), 
                         .CLKFBOUT(CLKFBOUT_CLKFBIN), 
                         .CLKOUTDCM0(), 
                         .CLKOUTDCM1(), 
                         .CLKOUTDCM2(), 
                         .CLKOUTDCM3(), 
                         .CLKOUTDCM4(), 
                         .CLKOUTDCM5(), 
                         .CLKOUT0(CLKOUT0_BUF), 
                         .CLKOUT1(CLKOUT1_BUF), 
                         .CLKOUT2(CLKOUT2_BUF), 
                         .CLKOUT3(CLKOUT3_BUF), 
                         .CLKOUT4(CLKOUT4_BUF), 
                         .CLKOUT5(), 
                         .DO(), 
                         .DRDY(), 
                         .LOCKED(LOCKED_OUT));
endmodule
