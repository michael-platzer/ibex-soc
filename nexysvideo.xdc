
## Clock Signal
set_property -dict { PACKAGE_PIN R4    IOSTANDARD LVCMOS33 } [get_ports { sys_clk_i }]; #IO_L13P_T2_MRCC_34 Sch=sysclk
create_clock -period 10.000 -name sysclk [get_ports sys_clk_i]
set_property CLOCK_DEDICATED_ROUTE BACKBONE [get_nets sys_clk_i]

## Buttons
set_property -dict { PACKAGE_PIN G4  IOSTANDARD LVCMOS15 } [get_ports { sys_rst_ni }]; #IO_L12N_T1_MRCC_35 Sch=cpu_resetn

## Switches
#set_property -dict { PACKAGE_PIN E22  IOSTANDARD LVCMOS12 } [get_ports { sw[0] }]; #IO_L22P_T3_16 Sch=sw[0]
#set_property -dict { PACKAGE_PIN F21  IOSTANDARD LVCMOS12 } [get_ports { sw[1] }]; #IO_25_16 Sch=sw[1]
#set_property -dict { PACKAGE_PIN G21  IOSTANDARD LVCMOS12 } [get_ports { sw[2] }]; #IO_L24P_T3_16 Sch=sw[2]
#set_property -dict { PACKAGE_PIN G22  IOSTANDARD LVCMOS12 } [get_ports { sw[3] }]; #IO_L24N_T3_16 Sch=sw[3]
#set_property -dict { PACKAGE_PIN H17  IOSTANDARD LVCMOS12 } [get_ports { sw[4] }]; #IO_L6P_T0_15 Sch=sw[4]
#set_property -dict { PACKAGE_PIN J16  IOSTANDARD LVCMOS12 } [get_ports { sw[5] }]; #IO_0_15 Sch=sw[5]
#set_property -dict { PACKAGE_PIN K13  IOSTANDARD LVCMOS12 } [get_ports { sw[6] }]; #IO_L19P_T3_A22_15 Sch=sw[6]
#set_property -dict { PACKAGE_PIN M17  IOSTANDARD LVCMOS12 } [get_ports { sw[7] }]; #IO_25_15 Sch=sw[7]


## LEDs
#set_property -dict { PACKAGE_PIN T14   IOSTANDARD LVCMOS25 } [get_ports { leds[0] }]; #IO_L15P_T2_DQS_13 Sch=led[0]
#set_property -dict { PACKAGE_PIN T15   IOSTANDARD LVCMOS25 } [get_ports { leds[1] }]; #IO_L15N_T2_DQS_13 Sch=led[1]
#set_property -dict { PACKAGE_PIN T16   IOSTANDARD LVCMOS25 } [get_ports { leds[2] }]; #IO_L17P_T2_13 Sch=led[2]
#set_property -dict { PACKAGE_PIN U16   IOSTANDARD LVCMOS25 } [get_ports { leds[3] }]; #IO_L17N_T2_13 Sch=led[3]
#set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS25 } [get_ports { leds[4] }]; #IO_L14N_T2_SRCC_13 Sch=led[4]
#set_property -dict { PACKAGE_PIN W16   IOSTANDARD LVCMOS25 } [get_ports { leds[5] }]; #IO_L16N_T2_13 Sch=led[5]
#set_property -dict { PACKAGE_PIN W15   IOSTANDARD LVCMOS25 } [get_ports { leds[6] }]; #IO_L16P_T2_13 Sch=led[6]
#set_property -dict { PACKAGE_PIN Y13   IOSTANDARD LVCMOS25 } [get_ports { leds[7] }]; #IO_L5P_T0_13 Sch=led[7]

## UART
set_property -dict { PACKAGE_PIN AA19  IOSTANDARD LVCMOS33 } [get_ports { uart_tx_o }]; #IO_L15P_T2_DQS_RDWR_B_14 Sch=uart_rx_out
set_property -dict { PACKAGE_PIN V18   IOSTANDARD LVCMOS33 } [get_ports { uart_rx_i }]; #IO_L14P_T2_SRCC_14 Sch=uart_tx_in

## Configuration options, can be used for all designs
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]
