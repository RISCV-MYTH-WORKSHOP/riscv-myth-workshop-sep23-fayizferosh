#!/bin/bash

echo 'Running.... riscv64-unknown-elf-gcc -c -mabi=ilp32 -march=rv32im -o 1to9_custom.o 1to9_custom.c'
riscv64-unknown-elf-gcc -c -mabi=ilp32 -march=rv32im -o 1to9_custom.o 1to9_custom.c 
echo 'Running.... riscv64-unknown-elf-gcc -c -mabi=ilp32 -march=rv32im -o load.o load.S'
riscv64-unknown-elf-gcc -c -mabi=ilp32 -march=rv32im -o load.o load.S
echo 'Running.... riscv64-unknown-elf-gcc -c -mabi=ilp32 -march=rv32im -o syscalls.o syscalls.c'
riscv64-unknown-elf-gcc -c -mabi=ilp32 -march=rv32im -o syscalls.o syscalls.c
echo 'Running.... riscv64-unknown-elf-gcc -mabi=ilp32 -march=rv32im -Wl,--gc-sections -o firmware.elf load.o 1to9_custom.o syscalls.o -T riscv.ld -lstdc++'
riscv64-unknown-elf-gcc -mabi=ilp32 -march=rv32im -Wl,--gc-sections -o firmware.elf load.o 1to9_custom.o syscalls.o -T riscv.ld -lstdc++
echo 'Running.... chmod -x firmware.elf'
chmod -x firmware.elf
echo 'Running.... riscv64-unknown-elf-gcc -mabi=ilp32 -march=rv32im -nostdlib -o start.elf start.S -T start.ld -lstdc++'
riscv64-unknown-elf-gcc -mabi=ilp32 -march=rv32im -nostdlib -o start.elf start.S -T start.ld -lstdc++
echo 'Running.... chmod -x start.elf'
chmod -x start.elf
echo 'Running.... riscv64-unknown-elf-objcopy -O verilog start.elf start.tmp'
riscv64-unknown-elf-objcopy -O verilog start.elf start.tmp
echo 'Running.... riscv64-unknown-elf-objcopy -O verilog firmware.elf firmware.tmp'
riscv64-unknown-elf-objcopy -O verilog firmware.elf firmware.tmp
echo 'Running.... cat start.tmp firmware.tmp > firmware.hex'
cat start.tmp firmware.tmp > firmware.hex
echo 'Running.... python3 hex8tohex32.py firmware.hex > firmware32.hex'
python3 hex8tohex32.py firmware.hex > firmware32.hex
#rm -f start.tmp firmware.tmp
echo 'Running.... iverilog -o testbench.vvp testbench.v picorv32.v'
iverilog -o testbench.vvp testbench.v picorv32.v
echo 'Running.... chmod -x testbench.vvp'
chmod -x testbench.vvp
echo 'Running.... vvp -N testbench.vvp'
vvp -N testbench.vvp
