vlog -reportprogress 300 -work work regfile.t.v
vsim -voptargs="+acc" regfiletest

add wave -position insertpoint  \
sim:/regfiletest/Clk \
sim:/regfiletest/ReadData1 \
sim:/regfiletest/ReadData2 \
sim:/regfiletest/ReadRegister1 \
sim:/regfiletest/ReadRegister2 \
sim:/regfiletest/WriteRegister \
sim:/regfiletest/RegWrite \
sim:/regfiletest/WriteData
run -all

wave zoom full