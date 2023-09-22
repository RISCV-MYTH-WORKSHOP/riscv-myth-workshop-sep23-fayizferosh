![RISC-V_Pipelined_Core_using_TL-Verilog](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/5e9b5052-394a-4269-b730-8988585c94fd)
# RISC-V Pipelined Core using TL-Verilog

![Static Badge](https://img.shields.io/badge/OS-linux-orange)
![Static Badge](https://img.shields.io/badge/Tools-gcc-navy)
![Static Badge](https://img.shields.io/badge/languages-C%2C_TL--Verilog-crimson)
![GitHub last commit](https://img.shields.io/github/last-commit/fayizferosh/risc-v-myth-report)
![GitHub language count](https://img.shields.io/github/languages/count/fayizferosh/risc-v-myth-report)
![GitHub top language](https://img.shields.io/github/languages/top/fayizferosh/risc-v-myth-report)
![GitHub repo size](https://img.shields.io/github/repo-size/fayizferosh/risc-v-myth-report)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/fayizferosh/risc-v-myth-report)
![GitHub repo file count (file type)](https://img.shields.io/github/directory-file-count/fayizferosh/risc-v-myth-report)
<!---
Comments
-->

> A beginner level 5-day workshop on “RISC-V based MYTH” (Microprocessor for You in Thirty Hours). In the workshop the following topics are discussed namely RISC-V specs, RISC-V software, how to implement RISC-V basic specs using TL-Verilog, simulate your own RISC-V core. The final objective by day 5 is to write RTL and build RISC-V core on my own.

A C program which has to be run on a specific hardware layout which is the interior of a chip in your laptop, there is certain flow to be followed. Initially, this particular C program is compiled in it's assembly language program which is nothing but RISC-V ISA (Reduced Instruction Set Compting - V Intruction Set Architecture). Following this, the assembly language program is then converted to machine language program which is the binary language logic 0 and 1 which is understood by the hardware of the computer. Directly after this, we've to implement this RISC-V specification using some RTL (a Hardware Description Language). Finally, from the RTL to Layout it is a standard PnR or RTL to GDSII flow.

![Screenshot (278)](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/7dc4601a-e386-48e5-9d1f-7fa5b47ca0ba)

For an application software to be run on a hardware there are several processes taking place. To begin with, the apps enters into a block called system software and it converts the application program to binary language. There are various layers in system software in which the major layers or components are OS (Operating System), Compiler and Assembler. At first the OS outputs are small function in C, C++, VB or Java language which are taken by the respective compiler and converted into instructions and the syntax of these instructions varies with the hardware architecture on which the system is implemented. Then, the job of the assembler is to take these instructions and convert it into it's binary format which is basically called as a machine language program. Finally, this binary language is fed to the hardware and it understands the specific functions it has to perform based on the binary code it receives.

![Screenshot (279)](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/19e8b634-f209-41a6-928d-6fba66f5b177)

For example, if we take a stopwatch app on RISC-V core, then the output of the OS could be a small C function which enters into the compiler and we get output RISC-V instructions following this, the output of the assembler will be the binary code which enters into your chip layout.

![Screenshot (280)](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/7d4570ca-82a6-4abe-81d2-067ebb9b2c15)

For the above stopwatch the following are the input and output of the compiler and assembler.

![Screenshot (281)](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/d7b7fd1b-21ee-46b7-9a91-8314bd753a51)

The output of the compiler are instructions and the output of the assembler is the binary pattern. Now, we need some RTL (a Hardware Description Language) which understands and implements the particular instructions. Then, this RTL is synthesised into a netlist in form of gates which is fabricated into the chip through a physical design implementation.

![Screenshot (282)](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/e349cb06-45e3-4ae4-b85f-9020a0a62737)

There are mainly 3 different parts in this course. They are:
1. RISC-V ISA
2. RTL and synthesis of RISC-V based CPU core - picorv32
3. Physical design implementation of picorv32

![Screenshot (283)](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/832f0ea6-2d60-4d9a-937c-a2dedd5f8cac)
