# Generic Makefile for Ibex applications
# Specify program name with PROG, object files with OBJ

SW_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

RISCV_CC   := riscv64-unknown-elf-gcc
RISCV_DUMP := riscv64-unknown-elf-objdump

LD_SCRIPT := $(SW_DIR)/link.ld

CFLAGS = -march=rv32im -mabi=ilp32 -static -mcmodel=medany \
         -fvisibility=hidden -nostdlib -nostartfiles -Wall \
         -I$(SW_DIR)/lib/

# add crt0 to object files
RISCV_OBJ := $(SW_DIR)/crt0.o $(OBJ)

all: $(PROG).vmem

dump: $(PROG).elf
	$(RISCV_DUMP) -D $<

$(PROG).elf: $(RISCV_OBJ) $(LD_SCRIPT)
	$(RISCV_CC) $(CFLAGS) -T $(LD_SCRIPT) $(RISCV_OBJ) -o $@

%.o: %.c
	$(RISCV_CC) $(CFLAGS) -c -o $@ $<

%.o: %.S
	$(RISCV_CC) $(CFLAGS) -c -o $@ $<

# currently unusable due to problems with byte order
# (see https://github.com/riscv/riscv-tools/issues/168#issuecomment-554973539)
#%.vmem: %.elf
#	$(OBJCOPY) -O verilog --verilog-data-width 4 $^ $@

# workaround (requires srecord):
# note: start address must be reset manually because it is lost in bin file
%.vmem: %.bin
	srec_cat $^ -binary -offset 0x0000 -byte-swap 4 -o $@ -vmem
%.bin: %.elf
	riscv64-unknown-elf-objcopy -O binary $^ $@

clean:
	rm -f *.o *.elf *.bin *.vmem
