# Day 1 - Introduction to RISC-V ISA and GNU compiler toolchain (20/09/2023)

Contents:
1. Introduction to RISC-V basic keywords
2. Labwork for RISC-V software toolchain
3. Integer number representation
4. Signed and unsigned arithmetic operations

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
