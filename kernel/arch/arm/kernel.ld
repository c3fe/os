ENTRY(_start)


SECTIONS {
		. = 0x10000;

		.kernel_bootstrap : { kernel/arch/arm/boot/head.o (.text) }

		.text : { *(.text) }
		.data : { *(.data) }
		.bss  : { *(.bss ) }

		. = ALIGN(8);
		. = . + 0x1000;

		kernel_stack = .;
}
