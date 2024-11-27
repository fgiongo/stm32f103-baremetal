CC = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy
CFLAGS = -c -g -nostdlib -mcpu=cortex-m3 -mthumb
LDFLAGS = -Wl,-Tscript.ld -nostartfiles

SRCS = main.c itrtb.c
OBJS = main.o itrtb.o
ELF = blink.elf
BIN = blink.bin

all: $(BIN)

%.o: %.c
	$(CC) $(CFLAGS) -o $@ $<

$(ELF): $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $^

$(BIN): $(ELF)
	$(OBJCOPY) -O binary $< $@

flash: $(BIN)
	sudo stm32flash -w $(BIN) -v -g 0x0 /dev/ttyUSB0

clean:
	rm -f $(OBJS) $(ELF) $(BIN)

.PHONY: all flash clean

