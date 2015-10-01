vlog -reportprogress 300 -work work adder.v
vsim -voptargs="+acc" test4bitAdder
add wave -position insertpoint \
sim:/test4bitAdder/a \
sim:/test4bitAdder/b \
sim:/test4bitAdder/sum \
sim:/test4bitAdder/carryout \
sim:/test4bitAdder/overflow
run -all
wave zoom full
