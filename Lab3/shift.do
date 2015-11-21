vlog -reportprogress 300 -work work shiftTest.t.v
vsim -voptargs="+acc" shiftTest

add wave -position insertpoint  \
sim:/shiftTest/clock \
sim:/shiftTest/D \
sim:/shiftTest/Q 
run -all

wave zoom full