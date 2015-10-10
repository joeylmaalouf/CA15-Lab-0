vlog -reportprogress 300 LogicalOps.v
vsim -voptargs="+acc" test
run -all