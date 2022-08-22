.global _putc

_putc:
		ldr r1, =0x101f1000
		str r0, [r1]
		bx lr
