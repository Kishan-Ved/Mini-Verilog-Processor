# Mini-Verilog-Processor
This repository contains Verilog code of a Mini Processor made as the final lab assignment in the Digital Systems course at IIT Gandhinagar.

Please check the [report](https://github.com/Kishan-Ved/Mini-Verilog-Processor/blob/main/Report.pdf) for details about the opcode instructions, architecture and working.

## Instruction Table

| Instruction | Opcode | Operation          |
|-------------|--------|--------------------|
| 0000 0000   | NOP    | No operation       |                                                  
| 0001 xxxx   | ADD Ri | Add ACC with Register contents and store the result in ACC. Updates C/B | 
| 0010 xxxx   | SUB Ri | Subtract ACC with Register contents and store the result in ACC. Updates C/B | 
| 0011 xxxx   | MUL Ri | Multiply ACC with Register contents and store the result in ACC. Updates EXT | 
| 0100 xxxx   | DIV Ri | Divide ACC with Register contents and store the Quotient in ACC. Updates EXT with remainder. | 
| 0000 0001   | LSL ACC| Left shift left logical the contents of ACC. Does not update C/B | 
| 0000 0010   | LSR ACC| Left shift right logical the contents of ACC. Does not update C/B | 
| 0000 0011   | CIR ACC| Circuit right shift ACC contents. Does not update C/B | 
| 0000 0100   | CIL ACC| Circuit left shift ACC contents. Does not update C/B | 
| 0000 0101   | ASR ACC| Arithmetic Shift Right ACC contents | 
| 0101 xxxx   | AND Ri | AND ACC with Register contents (bitwise) and store the result in ACC. C/B is not updated | 
| 0110 xxxx   | XRA Ri | XRA ACC with Register contents (bitwise) and store the result in ACC. C/B is not updated | 
| 0111 xxxx   | CMP Ri | CMP ACC with Register contents (ACC-Reg) and update C/B. If ACC>=Reg, C/B=0, else C/B=1 | 
| 0000 0110   | INC ACC| Increment ACC, updates C/B when overflows | 
| 0000 0117   | DEC ACC| Decrement ACC, updates C/B when underflows | 
| 1000 xxxx   | Br <4-bit address> | Update PC and branch to 4-bit address if C/B=1 | 
| 1001 xxxx   | MOV ACC, Ri | Move the contents of Ri to ACC | 
| 1010 xxxx   | MOV Ri, ACC | Move the contents of ACC to Ri | 
| 1011 xxxx   | Ret <4-bit address> | Update PC and return to the called program. | 
| 1111 1111   | HLT    | Stop the program (last instruction) | 

## Installation
Run the code using Vivado or any other equivalent software.

## FPGA Implementation video
Here's a video demonstrating a mathematical operation performed on an FPGA: [Video](https://drive.google.com/file/d/1X0bTufJRHkhalYNaGbHit4fKMBfZsjAH/view?usp=sharing)

## Collaboration
This project was made as a team of 2 (Kishan and Lavanya) for the Digital Systems course offered in Spring 2024 at IIT Gandhinagar, by Prof. Joycee Mekie.
