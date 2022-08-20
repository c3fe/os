#define halt()			for(;;)

// memory map
// https://github.com/qemu/qemu/blob/e630bc7ec9dda656a452ed28cac4d1e9ed605d71/hw/arm/versatilepb.c#L350
#define UART0_TX		(0x101f1000)
#define UART1_TX		(0x101f2000)
#define DEFAULT_UART_TX	UART0_TX

static inline void early_print(const char *msg) {
		volatile unsigned int *uart_tx = (unsigned int *)DEFAULT_UART_TX;

		while (*msg != '\0') {
				*uart_tx = (*msg);
				msg++;
		}
}

static inline void panic(const char *msg) {
		early_print("Panic!! ");
		early_print(msg);

		halt();
}

void kernel_start(void) {
		panic("Bored0m OS...\n");
}
