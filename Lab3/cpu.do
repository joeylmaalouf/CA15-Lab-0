vlog -reportprogress 300 -work work cpu.t.v
vsim -voptargs="+acc" CPUTest

add wave -position insertpoint  \
sim:/CPUTest/clk \
sim:/CPUTest/error_code
run -all

wave zoom full
