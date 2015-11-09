vlog -reportprogress 300 -work work spimemory.t.v
vsim -voptargs="+acc" fault_injection_test

add wave -position insertpoint  \
sim:/fault_injection_test/clk \
sim:/fault_injection_test/sclk_pin \
sim:/fault_injection_test/cs_pin \
sim:/fault_injection_test/miso_pin \
sim:/fault_injection_test/mosi_pin \
sim:/fault_injection_test/fault_pin
run -all

wave zoom full