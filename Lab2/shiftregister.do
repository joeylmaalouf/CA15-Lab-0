vlog -reportprogress 300 -work work shiftregister.t.v
vsim -voptargs="+acc" testshiftregister

add wave -position insertpoint  \
sim:/testshiftregister/peripheralClkEdge \
sim:/testshiftregister/parallelLoad \
sim:/testshiftregister/parallelDataIn \
sim:/testshiftregister/serialDataIn \
sim:/testshiftregister/parallelDataOut \
sim:/testshiftregister/serialDataOut \
sim:/testshiftregister/clk
run -all

wave zoom full