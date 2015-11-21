### Reflection

## The CPU

The easiest way to review our design is to step thorugh running a command on the processor. The Program Counter is in the top left hand corner, and its output goes directly to the Instruction Memory/Decoder unit (which loads the command at the PC address, and outputs the necessary values in the function to the parts of the CPU). The opcode travels to the command module, where they select the correct setings on all muxes and other adjustable values. If it's a basic jump command, it takes the address and goes through the "jump shifter" and "jump concatenator" to turn that into a propper 32 bit address. If it's a relative jump, with an immediate, it goes through the pc-jumper instead, which computes the relative position.

Any function that requires registers has those broken out by the instruction memory/decoder, and sent to the adress inputs of the register. An immediate will be sent to the immediate extenter, which extends it to the propper number of bits to perform arithmatic on. The ALU can take in either two register values, or the mux can select an immediate, allowing us to use either of those - and it has a zero flag, which it can output if something is equal to zero, for branching. Finally, the last block is data memory, which can take 

## Test Plan

## Performance analysis

## Work Plan Reflection