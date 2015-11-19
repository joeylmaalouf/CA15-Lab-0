vlog -reportprogress 300 -work work signExtendsTest.t.v
vsim -voptargs="+acc" signExtendsTest

add wave -position insertpoint  \
sim:/signExtendsTest/clk \
sim:/signExtendsTest/d \
sim:/signExtendsTest/q 
run -all

wave zoom full