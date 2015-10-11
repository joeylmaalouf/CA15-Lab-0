vlog -reportprogress 300 alu.v
vsim -voptargs="+acc" testALU
run -all
