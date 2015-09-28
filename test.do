vlog -reportprogress 300 -work work adder.v
vsim -voptargs="+acc" test4bitAdder
run 10000