vlog -reportprogress 300 -work work registerfile.t.v
vsim -voptargs="+acc" registerfiletest

add wave -position insertpoint  \
sim:/registerfiletest/Clk \
sim:/registerfiletest/ReadData1 \
sim:/registerfiletest/ReadData2 \
sim:/registerfiletest/ReadRegister1 \
sim:/registerfiletest/ReadRegister2 \
sim:/registerfiletest/WriteRegister \
sim:/registerfiletest/RegWrite \
sim:/registerfiletest/WriteData
run -all

wave zoom full