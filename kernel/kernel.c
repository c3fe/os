#include <stdarg.h>

#define halt()			for(;;)

extern void _putc(unsigned char);

static inline void print_chr(char ch) {
		_putc(ch);
}

static void print_str(const char *msg) {
		while (*msg != '\0') print_chr(*msg++);
}

static void print_int(int num) {
		int max_digit = sizeof(num) * 2;
		int number_of_digit = max_digit;
		unsigned int mask = (0xf << ((number_of_digit - 1) * 4));

		while ((num & mask) == 0) {
				num <<= 4;
				if (number_of_digit <= 0)
						break;
				number_of_digit--;
		}

		number_of_digit += !number_of_digit;
		for (int i = 0; i < number_of_digit; i++, num <<= 4) {
				char ch = ((num >> (max_digit * 4) - 4) & 0xf) + '0';
				if (ch > '9') ch += ('A' - '9' - 1);
				_putc(ch);
		}
}

static void early_printf(const char *fmt, ...) {
		va_list vl;

		va_start(vl, fmt);
		while (fmt && *fmt) {
				if (*fmt == '%') {
						fmt++;
						switch (*fmt) {
								case 'c':
										_putc(va_arg(vl, int));
										break;
								case 'd':
								case 'x':
								case 'u':
										print_int(va_arg(vl, int));
										break;
								case 's':
										print_str(va_arg(vl, char *));
										break;
								default:
										break;
						}
				} else _putc(*fmt);
				fmt++;
		}
		va_end(vl);
}

static inline void panic(const char *msg) {
		early_printf("Panic!! %s", msg);
		halt();
}

void kernel_start(void) {
		for (int i = 0; i < 10; i++)
				early_printf("Bored0m OS booting...\n");
		panic("fault.\n");
}
