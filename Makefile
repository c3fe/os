AS			:= arm-none-eabi-as
LD			:= arm-none-eabi-ld
CC			:= arm-none-eabi-gcc
OBJCOPY	    := arm-none-eabi-objcopy

ARM_QEMU    := qemu-system-arm

all: kernel.bin

kernel.bin: kernel.elf
	${OBJCOPY} -O binary $< $@

kernel.elf: kernel/kernel.o kernel/arch/arm/boot/head.o kernel/arch/arm/kernel.ld
	${LD} -o $@ -T kernel/arch/arm/kernel.ld kernel/kernel.o kernel/arch/arm/boot/head.o

kernel/kernel.o: kernel/kernel.c
	${CC} -c -o $@ $<

kernel/arch/arm/boot/head.o: kernel/arch/arm/boot/head.s
	${AS} -o $@ $<

qemu-run: kernel.bin
	${ARM_QEMU} -M versatileab -m 32M -nographic -kernel $<

clean:
	rm -f *.elf *.bin
	find . -type f -name "*.o" -print | xargs rm -f

