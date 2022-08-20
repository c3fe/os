.global _start

_start:
		ldr sp,=kernel_stack 
		bl  kernel_start
halt:
		b halt
