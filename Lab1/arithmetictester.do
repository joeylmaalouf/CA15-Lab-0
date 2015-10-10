vlog -reportprogress 300 arithmetic.v
vsim -voptargs="+acc" test
run -all