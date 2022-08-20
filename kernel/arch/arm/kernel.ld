ENTRY(_start)

/*
+-------------+
| kernel code |
|             |
+-------------+
| padding     |
+-------------+
| stack       |
|             |
|             |
+-------------+
 */

SECTIONS {
		/* QEMU ARMv7 boot address 	*/
		. = 0x10000;

		/* kerne code 				*/
		.kernel_bootstrap : { kernel/arch/arm/boot/head.o (.text) }

		.text : { *(.text) }
		.data : { *(.data) }
		.bss  : { *(.bss ) }

		/* padding 					*/
		. = ALIGN(8);
		. = . + 0x1000;

		/* stack 					*/
		kernel_stack = .;
}
