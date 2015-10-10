vlog -reportprogress 300 logic.v
vsim -voptargs="+acc" test
run -all