vlog -reportprogress 300 -work work regfile.t.v
vsim -voptargs="+acc" regfileTest

add wave -position insertpoint  \
sim:/regfileTest/Clk \
sim:/regfileTest/ReadData1 \
sim:/regfileTest/ReadData2 \
sim:/regfileTest/ReadRegister1 \
sim:/regfileTest/ReadRegister2 \
sim:/regfileTest/WriteRegister \
sim:/regfileTest/RegWrite \
sim:/regfileTest/WriteData
run -all

wave zoom full