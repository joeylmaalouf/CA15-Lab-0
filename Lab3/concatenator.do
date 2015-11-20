vlog -reportprogress 300 -work work concatenator.t.v
vsim -voptargs="+acc" concatenatorTest

add wave -position insertpoint  \
sim:/concatenatorTest/clk \
sim:/concatenatorTest/jmpinstruction \
sim:/concatenatorTest/PC \
sim:/concatenatorTest/out
run -all

wave zoom full