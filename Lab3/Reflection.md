### Reflection

## The CPU

![alt text](https://raw.githubusercontent.com/joeylmaalouf/CA15-Labs/master/Lab3/circuit.png "CPU Circuit Diagram")

The easiest way to review our design is to step thorugh running a command on the processor. The Program Counter is in the top left hand corner, and its output goes directly to the Instruction Memory/Decoder unit (which loads the command at the PC address, and outputs the necessary values in the function to the parts of the CPU). The opcode travels to the command module, where they select the correct setings on all muxes and other adjustable values. If it's a basic jump command, it takes the address and goes through the "jump shifter" and "jump concatenator" to turn that into a propper 32 bit address. If it's a relative jump, with an immediate, it goes through the pc-jumper instead, which computes the relative position.

Any function that requires registers has those broken out by the instruction memory/decoder, and sent to the adress inputs of the register. An immediate will be sent to the immediate extenter, which extends it to the propper number of bits to perform arithmatic on. The ALU can take in either two register values, or the mux can select an immediate, allowing us to use either of those - and it has a zero flag, which it can output if something is equal to zero, for branching. Finally, the last block is data memory, which can take 

## Test Plan

###MARS assembly Tests
We set up a series of tests to prove the core functionality of our cpu works. It tested load word, store word, jump, jump register, jump and link, branch not equal, exclusive or immediate, add, subtract, and check if less than. 

#### Expected Test Results
* `$v0 == 0` means everything passed
* `$v0 == 1` means LW/SW failed
* `$v0 == 2` means J failed
* `$v0 == 3` means JR/JAL failed
* `$v0 == 4` means BNE failed
* `$v0 == 5` means XORI failed
* `$v0 == 6` means ADD failed
* `$v0 == 7` means SUB failed
* `$v0 == 8` means SLT failed

#### Memory Layout Requirements
None, but if testing in Mars, make sure to go to `Settings -> Memory Configuration... -> Compact, Text at Address 0 -> Apply and Close`

#### Non-Subset Instructions Used
None

###ModelSim test bench

We wrote a large number of test benches to ensure the functionality of the core components of the CPU. 
Concatenator:
We set the concatenator to take four bits of the most significant bits of a mock PC address and told it to concatenate with a jump instruction, to make a 32-bit usable address. We expected this to start with a 4-bit and a 28-bit signal and end with a 32-bit signal with the leading significant bits being the 4-bit.

CPU:
We made a test bench to throw everything together and make the CPU work. We experienced great difficulty attempting to start the CPU and get it to contain anything but undriven wires. We expected to get a zero value on an error flag, meaning the CPU ran without a problem. Results pending.

Data Memory:
We set up the data memory file to be given a variety of information with the addresses to store them, and we expected to find the data where we told the data memory to store it. We successfully found the correct data in the correct location.

Double Left Shift:
We set up the left shifter to take in a 26-bit input and shift it to the left while extending it to a 28-bit output. We gave it a binary number to be shifted, and found that it successfully extended the size of the output as well as shifting the appropriate number of spaces.

Instruction Memory:
We set up a test bench to test the ability of the instruction memory to decode instructions into their respective parts. We gave the test bench a full instruction with the expectation it would divide it into its core parts. It performed exactly as planned.

Mux:
We set up a mux that could take any size input and output a choice based on the controls. We  gave it a variety of options for it to choose between based on a control input, and found it performed as expected every time.

Sign Extender:
We made a signed sign extender designed to take in immediates and output the sign extended version, bearing the sign in mind. We expected it to extend inputs to the appropriate number of bits through sign extension, and found it performed to expectations every time.

## Performance analysis

## Work Plan Reflection
| Task                    | Estimated Time to Complete | Actual Time Elapsed       |
|-------------------------|----------------------------|---------------------------|
| create assembly tests   | 2 hours                    | 1 hour                    |
| test/fix up old modules | 5 hours                    | 6 hours                   |
| design processor base   | 8 hours                    | 6 hours                   |
| LW, SW instr            | 1.5 hours                  | 30 minutes                |
| J, JR instr             | 1.5 hours                  | 30 minutes                |
| JAL, BNE instr          | 1.5 hours                  | 30 minutes                |
| XORI instr              | 1.5 hours                  | 30 minutes                |
| ADD, SUB instr          | 1.5 hours                  | 30 minutes                |
| SLT instr               | 1.5 hours                  | 30 minutes                |
| fit everything together | 4 hours                    | 10 hours                  |

In a lot of regards we were almost right in our expected times, but we did get hung up on a few areas we didn't expect. We hahd anticipated fitting everything together being a difficult task, but actually making the CPU work has proved a tremendous road block. Fixing old modules was something we knew would take time, and we were about right in our estimate. We also had to write new modules that did things a little differently from past implementations, so we went a little over what we anticipated. Getting the instructions together took much less time than we anticipated. Designing the processor base was less intensive than expected, but still took a sizable chunk of time. Being sure the main cpu file talked to the other modules correctly was a lesson in being thorough. Additionally, making sure the port sizes were correct was far more of a trial than anticipated.
