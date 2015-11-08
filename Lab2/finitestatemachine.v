module FSM(
input reset,
input sclk,
output sr_we,
output addr_we,
output dm_we,
output miso_enable,
output state
);

parameter state_GETTING = 0;
parameter state_GOT     = 1;
parameter state_READ_1  = 2;
parameter state_READ_2  = 3;
parameter state_READ_3  = 4;
parameter state_WRITE_1 = 5;
parameter state_WRITE_2 = 6;
parameter state_DONE    = 7;

endmodule 