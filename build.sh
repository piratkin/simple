#!/bin/bash

GCCFLAGS="-mcpu=cortex-m4 -mthumb -mthumb-interwork -mlittle-endian -mfpu=fpv4-sp-d16"
CLANGFLAGS="-target arm-none-eabi -mcpu=cortex-m4 -mthumb -mlittle-endian"
DEBUGFLAGS="-O3 -ggdb3"
CHIP_TYPE="-DSTM32F40_41xxx"
LDFLAGS="-T stm32_flash.ld"
INCLUDES="-I /usr/lib/arm-none-eabi/include"
#SOFTLIB="-L /usr/lib/arm-none-eabi/newlib/armv7e-m/softfp -L /usr/lib/gcc/arm-none-eabi/4.9.3/armv7e-m/softfp /usr/lib/gcc/arm-none-eabi/4.9.3/armv7e-m/crti.o /usr/lib/arm-none-eabi/lib/armv7e-m/crt0.o /usr/lib/arm-none-eabi/lib/armv7e-m/libc.a"
HARDLIB="-L /usr/lib/arm-none-eabi/newlib/armv7e-m/fpu -L /usr/lib/gcc/arm-none-eabi/4.9.3/armv7e-m/fpu /usr/lib/gcc/arm-none-eabi/4.9.3/armv7e-m/fpu/crti.o /usr/lib/arm-none-eabi/lib/armv7e-m/fpu/crt0.o /usr/lib/arm-none-eabi/lib/armv7e-m/fpu/libc.a"
FP="-mfloat-abi=hard"

#gcc
echo "start gcc"
arm-none-eabi-gcc -c ${GCCFLAGS} ${FP} ${DEBUGFLAGS} main.c -o gcc/main.o
arm-none-eabi-gcc -c ${GCCFLAGS} ${FP} ${DEBUGFLAGS} startup_stm32f40_41xxx.s -o gcc/startup_stm32f40_41xxx.o
arm-none-eabi-gcc -c ${GCCFLAGS} ${FP} ${DEBUGFLAGS} ${CHIP_TYPE} -ICMSIS system_stm32f4xx.c -o gcc/system_stm32f4xx.o
arm-none-eabi-gcc ${GCCFLAGS} ${FP} ${DEBUGFLAGS} ${LDFLAGS} gcc/main.o gcc/startup_stm32f40_41xxx.o gcc/system_stm32f4xx.o -o gcc/firmware_gcc.elf

echo "start ld"
arm-none-eabi-ld \
${LDFLAGS} \
${HARDLIB} \
gcc/main.o \
gcc/startup_stm32f40_41xxx.o \
gcc/system_stm32f4xx.o \
-o gcc/firmware_arm-none-eabi-ld.elf

echo "start arm-none-eabi-ld.bfd"
arm-none-eabi-ld.bfd \
${LDFLAGS} \
${HARDLIB} \
gcc/main.o \
gcc/startup_stm32f40_41xxx.o \
gcc/system_stm32f4xx.o \
-o gcc/firmware_arm-none-eabi-ld.bfd.elf


#clang
echo "start clang"
clang -c ${CLANGFLAGS} ${FP} ${DEBUGFLAGS} ${INCLUDES} main.c -o clang/main.o
clang -c ${CLANGFLAGS} ${FP} ${DEBUGFLAGS} startup_stm32f40_41xxx.s -o clang/startup_stm32f40_41xxx.o
clang -c ${CLANGFLAGS} ${FP} ${DEBUGFLAGS} ${CHIP_TYPE} -ICMSIS system_stm32f4xx.c -o clang/system_stm32f4xx.o
#clang -fuse-ld=lld -mfloat-abi=hard ${DEBUGFLAGS} ${LDFLAGS} ${HARDLIB} clang/main.o clang/startup_stm32f40_41xxx.o clang/system_stm32f4xx.o -o clang/firmware_clang.elf

echo "start ld.lld-6.0"
ld.lld-6.0 \
${LDFLAGS} \
${HARDLIB} \
--lto-O3 \
clang/main.o \
clang/startup_stm32f40_41xxx.o \
clang/system_stm32f4xx.o \
-o clang/firmware_lld-6.0.elf
