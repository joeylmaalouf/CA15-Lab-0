vlog -reportprogress 300 -work work signExtenduTest.t.v
vsim -voptargs="+acc" signExtenduTest

add wave -position insertpoint  \
sim:/signExtenduTest/clk \
sim:/signExtenduTest/d \
sim:/signExtenduTest/q 
run -all

wave zoom full