# Day 1 - Introduction to RISC-V ISA and GNU compiler toolchain (20/09/2023)

Contents:
1. Introduction to RISC-V basic keywords
2. Labwork for RISC-V software toolchain
3. Integer number representation
4. Signed and unsigned arithmetic operations

## RISC-V ISA

The following are basic C program which will do integer addition, multiplication and division.

![Screenshot (284)](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/0edd3353-be8d-4bf5-93cc-b5af7654ed71)

And these are the output of the compiler for these codes which is nothing but a set of RISC-V instructions which perform the integer addition, multiplication and division.

![Screenshot (285)](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/f8926f6b-18ae-4309-8021-9d3a194b463d)

The following are the different sets of instructions which form the RISC-V ISA:

![Screenshot (286)](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/ba91e6c3-a0e5-4e26-a7b3-977b6d993441)
![Screenshot (287)](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/7dc0afc0-3d44-4669-8694-43e4d48114e0)
![Screenshot (288)](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/448260e4-b3f9-46ce-a9fe-5816733d5ed7)

The following are basic C program which will do floating point addition, multiplication and division.

![Screenshot (289)](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/bc6b7441-9d00-42f4-b095-05bc511e497f)

And these are the output of the compiler for these codes which is nothing but a set of RISC-V instructions which perform the floating point addition, multiplication and division.

![Screenshot (290)](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/253d30fd-f57d-48d2-8400-b6c1d0123449)

The following are the rest of the different sets of instructions which form the RISC-V ISA:

![Screenshot (291)](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/34b6d5a1-75ba-4171-810e-ecfa2ad8c386)

If we look into all the instruction over here these are some interface with which the user can access the RISC-V registers.

![Screenshot (292)](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/54324034-1544-4369-9d32-9e5c5e87c2e1)

In the following highlighted instructions there are some data transfer happening between memory, stack pointer or register.

![Screenshot (293)](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/bc831159-437b-47c3-8725-738136f6cfd3)

## Lab 1

C Program *sum1ton.c*:

```C
#include<stdio.h>
int main()
{
    int i,sum=0,n=9;
    for(i=1;i<=n;i++)
    {
        sum+=i;
    }
    printf("The sum of numbers from 1 to %d is %d\n", n, sum);
    return 0;
}
```

Commands to compile & execute and generate output of C program:

```bash
# Compiling the code
gcc sum1ton.c
# Executing the code
./a.out
```

**Screenshot**

![Screenshot from 2023-09-21 15-47-09](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/28bf2d71-ea12-4e66-9c35-2599045cd8f8)

Commands to compile & execute the same C program using RISC-V simulator:

Details regarding optimization options -O1 & -Ofast can be found [here](https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html).

Details regarding rest of the options -mabi, -march and so on can be found [here](https://gcc.gnu.org/onlinedocs/gcc/RISC-V-Options.html).

```bash
# Compiling code on RISC-V simulator in -O1 optimization
riscv64-unknown-elf-gcc -O1 -mabi=lp64 -march=rv64i -o sum1ton_O1.o sum1ton.c
# Disassembling compiled code
riscv64-unknown-elf-objdump -d sum1ton_O1.o > sum1ton_O1_d.txt
# Compiling code on RISC-V simulator in -Ofast optimization
riscv64-unknown-elf-gcc -Ofast -mabi=lp64 -march=rv64i -o sum1ton_Ofast.o sum1ton.c
# Disassembling compiled code
riscv64-unknown-elf-objdump -d sum1ton_Ofast.o > sum1ton_Ofast_d.txt
```

**Screenshots**

![Screenshot from 2023-09-21 15-53-36](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/6e0951cd-37aa-40d5-b842-a96e31cca153)

**-O1 and -Ofast optimizations instruction count in main() function**

![Screenshot from 2023-09-21 15-59-04](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/8e98c586-6ad6-453c-80fb-f5aca9f7e07b)
![Screenshot from 2023-09-21 16-01-49](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/434f32c8-5300-4e1d-9699-d65ae9c6d588)


```bash
# Executing the code
spike pk sum1ton_O1.o
# To debug type
spike -d pk sum1ton_O1.o
```
```bash
# In debug mode
# Run until program counter "10184"
(spike) until pc 0 10184
# Display value of stack pointer "sp"
(spike) reg 0 sp
# Just press "Enter" to run the next instruction
(spike)
# Checking stack pointer "sp" value again
(spike) reg 0 sp
# Just press "Enter" to run the next instruction
(spike)
(spike)
(spike)
# Display value of register "a0"
(spike) reg 0 a0
# Just press "Enter" to run the next instruction
(spike)
# Checking register "a0" value again
(spike) reg 0 a0
# Just press "Enter" to run the next instruction
(spike)
# Checking register "a0" value again
(spike) reg 0 a0
# Exiting debug mode
(spike) q
```

**Screenshot**

![Screenshot from 2023-09-21 17-05-55](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/56001275-49b5-4b08-8a69-8d019a10c739)

```bash
# Executing the code
spike pk sum1ton_Ofast.o
# To debug type
spike -d pk sum1ton_Ofast.o
```
```bash
# In debug mode
# Run until program counter "100b0"
(spike) until pc 0 100b0
# Display value of register "a0"
(spike) reg 0 a0
# Just press "Enter" to run the next instruction
(spike)
# Checking register "a0" value again
(spike) reg 0 a0
# Display value of stack pointer "sp"
(spike) reg 0 sp
# Just press "Enter" to run the next instruction
(spike)
# Checking stack pointer "sp" value again
(spike) reg 0 sp
# Just press "Enter" to run the next instruction
(spike)
(spike)
# Display value of register "a0"
(spike) reg 0 a0
# Just press "Enter" to run the next instruction
(spike)
# Checking register "a0" value again
(spike) reg 0 a0
# Exiting debug mode
(spike) q
```

**Screenshot**

![Screenshot from 2023-09-21 17-19-41](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/ff6374e0-6d4e-4db5-a2d2-4d44d6c5235e)


***lui* command**

![Screenshot (294)](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/1c4648d0-1583-4e24-ab0d-c78a17400c5f)

***addi* command**

![Screenshot (296)](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/2fce31ac-2214-42c3-a97f-2cb43127302b)

**Important Terms**

![Screenshot (297)](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/bff11b16-04a5-4326-9d38-d89dcb6f8447)

**Maximum amount of numbers that can be expressed in 64bit**

![Screenshot (299)](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/60cdd2dd-5f3d-4ae0-96e6-37df0c2546fb)

**Unsigned 64bit limits**

![Screenshot (300)](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/46e95ff8-57e2-43e5-bc5a-eefc637366e9)

**Signed postive representation and signed negative in two's compliment representation**

![Screenshot (301)](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/04b6f7d6-ea3e-4fe3-86b3-f4bf56683e0b)
![Screenshot (302)](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/496d4bef-014e-4c35-9778-fe7177636a26)
![Screenshot (303)](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/4fba20b7-1195-4876-83fb-dc761b077ed3)
![Screenshot (304)](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/9e6bd23a-2f93-493f-a733-b1c5af359dda)
![Screenshot (305)](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/d051d15d-3843-4b23-88e6-5ad7a15755d6)
![Screenshot (306)](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/4786b124-d725-4856-a6af-51b1969d12c1)

**Signed 64bit limits**

![Screenshot (308)](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/1b1050d0-2e92-45b8-b3a9-291d1ab1b63d)
![Screenshot (309)](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/054d1483-9558-428a-9ec1-8864f27d18af)

## Lab 2

C Program *unshighlow.c*:

```C
#include<stdio.h>
#include<math.h>

int main()
{
    unsigned long long int max = (unsigned long long int)(pow(2,64)-1); 
    unsigned long long int maxover = (unsigned long long int)(pow(2,127));
    unsigned long long int min = (unsigned long long int)(0);
    unsigned long long int minover = (unsigned long long int)(pow(2,64)*-1);
    printf("Highest number represented by unsigned long long int is %llu which is calculated by (2^64 - 1)\n", max);
    printf("Proving by overflowing above limit (2^127) value of variable still is %llu\n", maxover);
    printf("Lowest number represented by unsigned long long int is %llu\n", min);
    printf("Proving by overflowing below limit (2^64 * -1) value of variable still is %llu\n", minover);
    return 0;
}
```

Commands to compile & execute the same C program using RISC-V simulator:

```bash
# Compiling code on RISC-V simulator in -Ofast optimization
riscv64-unknown-elf-gcc -Ofast -mabi=lp64 -march=rv64i -o unshighlow_Ofast.o unshighlow.c
# Executing the code
spike pk unshighlow_Ofast.o
```

**Screenshot**

![Screenshot from 2023-09-21 17-33-21](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/d58cbe25-231e-4abb-8b6a-a664dec8f20c)

C Program *signhighlow.c*:

```C
#include<stdio.h>
#include<math.h>

int main()
{
    long long int max = (long long int)(pow(2,63)-1); 
    long long int maxover = (long long int)(pow(2,127));
    long long int min = (long long int)(pow(2,63)*-1);
    long long int minover = (long long int)(pow(2,127)*-1);
    printf("Highest positive number represented by signed long long int is %lld which is calculated by (2^63 - 1)\n", max);
    printf("Proving by overflowing above limit (2^127) value of variable still is %lld\n", maxover);
    printf("Lowest negative number represented by signed long long int is %lld which is calculated by (2^63 * -1)\n", min);
    printf("Proving by overflowing below limit (2^127 * -1) value of variable still is %lld\n", minover);
    return 0;
}
```

Commands to compile & execute the same C program using RISC-V simulator:

```bash
# Compiling code on RISC-V simulator in -Ofast optimization
riscv64-unknown-elf-gcc -Ofast -mabi=lp64 -march=rv64i -o signhighlow_Ofast.o signhighlow.c
# Executing the code
spike pk signhighlow_Ofast.o
```

**Screenshot**

![Screenshot from 2023-09-21 17-37-11](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/161e5477-2cc5-4413-b786-ef5fe13b7b06)

# Day 2 - Introduction to ABI and basic verification flow (21/09/2023)

Contents:
1. Application Binary interface (ABI)
2. Lab work using ABI function calls
3. Basic verification flow using iverilog

## Application Binary Interface (ABI)

There are some portions of the ISA that is directly accessible to the user namely a programmer and operating system through a *System Call* using which a user can access and utilize these portions of the ISA namely the registers thereby getting direct access to the hardware of the system. And the *System Call* is performed through or using the *Application Binary Interface (ABI)* also called as *System Call Interface*. The portion of the ISA available to user is called the *User ISA* and the portion available to both system and user is called the *User and System ISA*.

![Screenshot (310)](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/aa9edd28-d0b3-4c23-b417-bab3e0d04e18)
![Screenshot (323)](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/85d5e481-4a83-4c95-83fe-fab54c5f4e61)
![Screenshot (324)](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/f665d290-390c-40e8-8dd9-0ea9ef0c4631)

There are only 32 registers in both riscv64 and riscv32 architecture and each register in riscv64 is 64 bit but memory each unit stores only a byte (8 bits) so 8 units of memory is required to store the data in a riscv64 register and it is done by splitting the data into 8 bytes which is stored in such a way that the *Least Significant Byte* is stored in the lowest address memory and moving up with each byte. This system where LSB is stored in lowest address memory is called *little-endian* memory addressing system.

![Screenshot (311)](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/a4237954-27b1-47c9-87ad-9e283d97e16c)
![Screenshot (312)](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/2c4f62cd-f4c9-4d2f-982b-114fdaa050fb)

All the instruction sizes in both riscv64 and riscv32 architecture are 32 bit only. Of which 5 bit is the maximum length for indicating and register and using the formula [0 - (2^5 - 1)], 0 to 31 are the register numbers that can be represented which is why there are only 32 registers in both riscv64 and riscv32.

![Screenshot (322)](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/6ca2d728-6834-45fe-8232-cb64f3182194)

## Some RISC-V ISA instructions

### ld (load doubleword)

This instruction is used to load data into register from memory. In it's 32bits, opcode or the assembly language instruction or command which in this case is *ld* is recognized by the using 10 bits of which 3 are of *funct3* and the rest 7 are of *opcode*.

![Screenshot (314)](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/fdf26322-03a0-4487-b833-678bba55be49)
![Screenshot (315)](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/6319d8ad-5b2d-4312-8c70-52be12da2789)

### add (addition)

This instruction is used to add contents of 2 registers and store the output in another register. In it's 32bits, opcode or the assembly language instruction or command which in this case is *add* is recognized by the using 17 bits of which 3 are of *funct3*, 7 are of *funct7* and the rest 7 are of *opcode*.

![Screenshot (316)](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/7f589bc4-da75-4686-9d2b-2b70c5fe702c)

### sd (store doubleword)

This instruction is used to store data from register into memory. In it's 32bits, opcode or the assembly language instruction or command which in this case is *sd* is recognized by the using 10 bits of which 3 are of *funct3* and the rest 7 are of *opcode*.

![Screenshot (317)](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/d55d1f29-6b2b-4902-b4f1-419714705ac6)

### addi (addition immediate)

This instruction is used to add contents of a register to an immediate or constant value and store the output in a register. The basic syntax is `addi rd, rs1, imm` where *rd* is the destination register, *rs1* is the source register and *imm* is the immediate or constant value.

### blt (branch if less than)

This instruction is used to compare two registers and if source register content is less than destination register content then branch the code to the address pointed by the label. The basic syntax is `blt rd, rs1, label` where *rd* is the destination register, *rs1* is the source register and *label* is the user-defined label that points to a specific address of a line of code.

### lui (load upper immediate)

This instruction is used to load an immediate or constant value to the *upper-immediate* (bits 12 to 31) of a register. The basic syntax is `lui rd, imm` where *rd* is the destination register and *imm* is the immediate or constant value.

### ret (return)

This instruction is used to return back the parent program along with returning a value of register.

## Classifications other than Base Integer Instructions (RV64I)

### R-type Instructions

Instructions that operate only on registers are called *R-type* instructions.

![Screenshot (318)](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/b5ec7563-2072-4fee-a915-a092d1ab64a5)

### I-type Instructions

Instructions that operate on registers and an immediate are called *I-type* instructions.

![Screenshot (319)](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/4b6461ff-a320-4c32-993f-17107ddbcc0f)

### S-type Instructions

Instructions that operate only on source registers and an immediate and are generally used for storing something are called *S-type* instructions.

![Screenshot (320)](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/53c89492-e3de-4788-97a1-c54b4e9b02ab)

## Lab 3

C Program *1to9_custom.c*:

```C
#include <stdio.h>

extern int load(int x, int y); 

int main()
{
	int result = 0;
       	int count = 2;
    	result = load(0x0, count+1);
    	printf("Sum of number from 1 to %d is %d\n", count, result); 
}

```

ASM Program *load.S*:

```asm
.section .text
.global load
.type load, @function

load:
	add 	a4, a0, zero //Initialize sum register a4 with 0x0
	add 	a2, a0, a1   // store count of 10 in register a2. Register a1 is loaded with 0xa (decimal 10) from main program
	add	a3, a0, zero // initialize intermediate sum register a3 by 0
loop:	add 	a4, a3, a4   // Incremental addition
	addi 	a3, a3, 1    // Increment intermediate register by 1	
	blt 	a3, a2, loop // If a3 is less than a2, branch to label named <loop>
	add	a0, a4, zero // Store final result to register a0 so that it can be read by main program
	ret
```

Commands to compile & execute the same C program using RISC-V simulator:

```bash
# Compiling code on RISC-V simulator in -Ofast optimization
riscv64-unknown-elf-gcc -Ofast -mabi=lp64 -march=rv64i -o 1to9_custom_Ofast.o 1to9_custom.c load.S
# Executing the code
spike pk 1to9_custom_Ofast.o
# Disassembling compiled code
riscv64-unknown-elf-objdump -d 1to9_custom_Ofast.o > 1to9_custom_Ofast_d.txt
```

**Screenshot**

![Screenshot from 2023-09-21 23-48-27](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/4f7b5396-bb74-46b0-b760-175b2d0026c3)

## Lab 4

Running the *1to9_custom.c* on *picorv32.v* microprocessor verilog code by passing the the C code as .hex file.

Commands to compile & execute the same C program on *picorv32.v* microprocessor code:

```bash
# List all files
ls
# Change permission of all files in current folder to 755
chmod 755 rv32im.sh
# Execute the bash script
./rv32im.sh
# List all files
ls
```

**Screenshot**

![Screenshot from 2023-09-22 00-46-34](https://github.com/fayizferosh/risc-v-myth-report/assets/63997454/bf502eb4-3b2b-42b1-9297-a3fe73645f35)
