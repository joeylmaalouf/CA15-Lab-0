vlog -reportprogress 300 -work work spimemory.t.v
vsim -voptargs="+acc" fault_injection_test

virtual type {{0 GET} {1 GOT} {2 READ} {3 READ2} {4 READ3} {5 WRITE1} {6 WRITE2} {7 DONE}} state_type
virtual function {(state_type) /fault_injection_test/leds} state_virtual

add wave -position insertpoint \
sim:/fault_injection_test/state_virtual \
sim:/fault_injection_test/clk \
sim:/fault_injection_test/sclk_pin \
sim:/fault_injection_test/cs_pin \
sim:/fault_injection_test/miso_pin \
sim:/fault_injection_test/mosi_pin \
sim:/fault_injection_test/fault_pin \
sim:/fault_injection_test/leds
run -all

wave zoom full
