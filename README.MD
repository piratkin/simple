clang -c 
-target arm-none-eabi 
-mcpu=cortex-m4 
-O0 
-mfloat-abi=hard 
-g 
main.c 
-o main.o

arm-none-eabi-gcc 
-c 
-g 
-mcpu=cortex-m4 
-mthumb 
-mlittle-endian 
-mfpu=fpv4-sp-d16 
-mfloat-abi=hard 
-mthumb-interwork  
-Os 
-I /opt/gcc-arm-none-eabi-7-2017-q4-major/arm-none-eabi/include/ 
-o main.o 
main.c

clang-6.0 
-c 
-target arm-none-eabi 
-mcpu=cortex-m4 
-O0 
-mfloat-abi=hard 
-I /opt/gcc-arm-none-eabi-7-2017-q4-major/arm-none-eabi/include/ 
-g main.c 
-o main.o

arm-none-eabi-gcc 
-mcpu=cortex-m4 
-mthumb 
-mlittle-endian 
-mfpu=fpv4-sp-d16 
-mfloat-abi=hard 
-mthumb-interwork  
-Os  
-DUSE_STDPERIPH_DRIVER 
-DSTM32F4XX 
-DMANGUSTA_DISCOVERY 
-DUSE_USB_OTG_FS 
-DHSE_VALUE=8000000 
-I./ 
-I./ 
-I../../Utilities/STM32F4-Discovery 
-I../../Libraries/CMSIS/ST/STM32F4xx/Include/ 
-I../../Libraries/CMSIS/Include/ 
-I../../Libraries/STM32F4xx_StdPeriph_Driver/inc/ 
-I../../Libraries/STM32_USB_Device_Library/Class/hid/inc 
-I../../Libraries/STM32_USB_Device_Library/Core/inc/ 
-I../../Libraries/STM32_USB_OTG_Driver/inc/  
-Wl,
-T,stm32_flash.ld 
main.c 
stm32f4xx_it.c 
system_stm32f4xx.c 
../../Utilities/STM32F4-Discovery/stm32f4_discovery.c 
../../Libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_syscfg.c 
../../Libraries/STM32F4xx_StdPeriph_Driver/src/misc.c 
../../Libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_gpio.c 
../../Libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_rcc.c 
../../Libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_exti.c 
startup_stm32f4xx.S 
-o demo.elf
