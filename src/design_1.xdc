#set_property PACKAGE_PIN V22 [get_ports {hil_leds_pin[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {hil_leds_pin[0]}]

set_property IOSTANDARD LVCMOS33 [get_ports SPI1_MOSI_O_0]
#JA1
set_property PACKAGE_PIN Y11 [get_ports SPI1_MOSI_O_0]

set_property IOSTANDARD LVCMOS33 [get_ports SPI1_MISO_I_0]
#JA2
set_property PACKAGE_PIN AA11 [get_ports SPI1_MISO_I_0]

set_property IOSTANDARD LVCMOS33 [get_ports SPI1_SCLK_O_0]
#JA3
set_property PACKAGE_PIN Y10 [get_ports SPI1_SCLK_O_0]

set_property IOSTANDARD LVCMOS33 [get_ports SPI1_SS_O_0]
#JA9
set_property PACKAGE_PIN AB9 [get_ports SPI1_SS_O_0]


set_property IOSTANDARD LVCMOS33 [get_ports SPI0_MOSI_I_0]
#JB1
set_property PACKAGE_PIN W12 [get_ports SPI0_MOSI_I_0]

set_property IOSTANDARD LVCMOS33 [get_ports SPI0_MISO_O_0]
#JB2
set_property PACKAGE_PIN W11 [get_ports SPI0_MISO_O_0]

set_property IOSTANDARD LVCMOS33 [get_ports SPI0_SCLK_I_0]
#JB3
set_property PACKAGE_PIN V10 [get_ports SPI0_SCLK_I_0]

set_property IOSTANDARD LVCMOS33 [get_ports SPI0_SS_I_0]
#JB9
set_property PACKAGE_PIN V9 [get_ports SPI0_SS_I_0]

connect_debug_port u_ila_0/probe0 [get_nets [list design_1_i/processing_system7_0_SPI_0_IO0_I]]
connect_debug_port u_ila_0/probe1 [get_nets [list design_1_i/processing_system7_0_SPI_0_IO0_O]]
connect_debug_port u_ila_0/probe2 [get_nets [list design_1_i/processing_system7_0_SPI_0_IO0_T]]
connect_debug_port u_ila_0/probe3 [get_nets [list design_1_i/processing_system7_0_SPI_0_IO1_I]]
connect_debug_port u_ila_0/probe4 [get_nets [list design_1_i/processing_system7_0_SPI_0_IO1_O]]
connect_debug_port u_ila_0/probe5 [get_nets [list design_1_i/processing_system7_0_SPI_0_IO1_T]]
connect_debug_port u_ila_0/probe6 [get_nets [list design_1_i/processing_system7_0_SPI_0_SCK_I]]
connect_debug_port u_ila_0/probe7 [get_nets [list design_1_i/processing_system7_0_SPI_0_SCK_O]]
connect_debug_port u_ila_0/probe8 [get_nets [list design_1_i/processing_system7_0_SPI_0_SCK_T]]
connect_debug_port u_ila_0/probe9 [get_nets [list design_1_i/processing_system7_0_SPI_0_SS1_O]]
connect_debug_port u_ila_0/probe10 [get_nets [list design_1_i/processing_system7_0_SPI_0_SS2_O]]
connect_debug_port u_ila_0/probe11 [get_nets [list design_1_i/processing_system7_0_SPI_0_SS_I]]
connect_debug_port u_ila_0/probe12 [get_nets [list design_1_i/processing_system7_0_SPI_0_SS_O]]
connect_debug_port u_ila_0/probe13 [get_nets [list design_1_i/processing_system7_0_SPI_0_SS_T]]
connect_debug_port u_ila_0/probe14 [get_nets [list design_1_i/processing_system7_0_SPI_1_IO0_I]]
connect_debug_port u_ila_0/probe15 [get_nets [list design_1_i/processing_system7_0_SPI_1_IO0_O]]
connect_debug_port u_ila_0/probe16 [get_nets [list design_1_i/processing_system7_0_SPI_1_IO0_T]]
connect_debug_port u_ila_0/probe17 [get_nets [list design_1_i/processing_system7_0_SPI_1_IO1_I]]
connect_debug_port u_ila_0/probe18 [get_nets [list design_1_i/processing_system7_0_SPI_1_IO1_O]]
connect_debug_port u_ila_0/probe19 [get_nets [list design_1_i/processing_system7_0_SPI_1_IO1_T]]
connect_debug_port u_ila_0/probe20 [get_nets [list design_1_i/processing_system7_0_SPI_1_SCK_I]]
connect_debug_port u_ila_0/probe21 [get_nets [list design_1_i/processing_system7_0_SPI_1_SCK_O]]
connect_debug_port u_ila_0/probe22 [get_nets [list design_1_i/processing_system7_0_SPI_1_SCK_T]]
connect_debug_port u_ila_0/probe23 [get_nets [list design_1_i/processing_system7_0_SPI_1_SS1_O]]
connect_debug_port u_ila_0/probe24 [get_nets [list design_1_i/processing_system7_0_SPI_1_SS2_O]]
connect_debug_port u_ila_0/probe25 [get_nets [list design_1_i/processing_system7_0_SPI_1_SS_I]]
connect_debug_port u_ila_0/probe26 [get_nets [list design_1_i/processing_system7_0_SPI_1_SS_O]]
connect_debug_port u_ila_0/probe27 [get_nets [list design_1_i/processing_system7_0_SPI_1_SS_T]]


create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 16384 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list design_1_i/processing_system7_0/inst/FCLK_CLK0]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 1 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list design_1_i/processing_system7_0_SPI0_MISO_O]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 1 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list design_1_i/processing_system7_0_SPI1_MOSI_O]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 1 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list design_1_i/processing_system7_0_SPI1_SCLK_O]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 1 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list design_1_i/processing_system7_0_SPI1_SS_O]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 1 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list design_1_i/SPI0_MOSI_I_0_1]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 1 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list design_1_i/SPI0_SCLK_I_0_1]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 1 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list design_1_i/SPI0_SS_I_0_1]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 1 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list design_1_i/SPI1_MISO_I_0_1]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets u_ila_0_FCLK_CLK0]
