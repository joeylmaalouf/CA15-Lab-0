vlog -reportprogress 300 -work work doubleLeftShift.t.v
vsim -voptargs="+acc" doubleLeftShiftTest

add wave -position insertpoint  \
sim:/doubleLeftShiftTest/clk \
sim:/doubleLeftShiftTest/d \
sim:/doubleLeftShiftTest/q \
sim:/doubleLeftShiftTest/enable 
run -all

wave zoom full