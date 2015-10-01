# CA15-Lab-0

## Computer Architecture Lab 0 Writeup

##### Joey Maalouf, Daniel Bishop, Sean Carter, Gabriel Butterick

### Waveforms
![Waveforms](waveforms.png)
worst case 400ns
...

### Verilog Tests
```
Testing 4-bit Full Adder
Testing Sum:
A    | B    | Sum  | Cout | Overflow
0010 | 0010 | 0100 | 0    | 0
1001 | 0100 | 1101 | 0    | 0
0100 | 1010 | 1110 | 0    | 0
0001 | 0010 | 0011 | 0    | 0
Testing Carryout:
A    | B    | Sum  | Cout | Overflow
0001 | 1111 | 0000 | 1    | 0
0011 | 1110 | 0001 | 1    | 0
1100 | 0110 | 0010 | 1    | 0
0110 | 1101 | 0011 | 1    | 0
Testing Overflow:
A    | B    | Sum  | Cout | Overflow
0101 | 0100 | 1001 | 0    | 1
0111 | 0111 | 1110 | 0    | 1
0110 | 0011 | 1001 | 0    | 1
0101 | 0111 | 1100 | 0    | 1
Testing Everything:
A    | B    | Sum  | Cout | Overflow
1000 | 1000 | 0000 | 1    | 1
1000 | 1111 | 0111 | 1    | 1
1100 | 1010 | 0110 | 1    | 1
1010 | 1001 | 0011 | 1    | 1
```

### FPGA Tests
...
![FPGA Test](fpga.jpg)

### Summary Statistics
...
