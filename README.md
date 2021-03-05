# Minimal SoC for the Ibex Core

This repository includes the [Ibex repository](https://github.com/lowRISC/ibex)
as a submodule. After cloning you need to initialize the submodule:

    git submodule update --init --recursive


## Preparation of boot RAM files

1. Install the RISC-V GNU toolchain by following the instructions on their
   [GitHub page](https://github.com/riscv/riscv-gnu-toolchain) and add the
   `bin/` directory to your path.

2. Install [SRecord](http://srecord.sourceforge.net/), which is currently
   required to convert `*.bin` files to `*.vmem` files due to
   [a bug in GNU binutils
   ](https://github.com/riscv/riscv-tools/issues/168#issuecomment-554973539).

3. Compile your program by using the Makefile in the `sw/` subdirectory and
   specifying your program name with the variable `PROG` and object files with
   `OBJ` (object files may have `*.c` or `*.S` source files). Example:

       make -f sw/Makefile PROG=test OBJ=test.o

The following program can be used as a simple test program:

```
#include "sw/lib/uart.h"

int main(int argc, char *argv[]) {
    uart_puts("Hello world!\n");
    return 0;
}
```

This program can be compiled as follows:

    make -f sw/Makefile PROG=test OBJ="test.o sw/lib/uart.o"


## Build the Ibex core

1. Install Vivado and add the `bin/` directory to your path.

2. Issue the command `make` in the top-level directory of this repository. This
   generates a Vivado project in a temporary directory (alternatively you can
   specify a directory with `PROJ_DIR`). A boot RAM file can be used to
   initialize the RAM with `RAM_FILE`. Example:

       make PROJ_DIR=build/ RAM_FILE=test.vmem

3. Open the generated project in Vivado, from where you should be able to both
   simulate it and synthesize it.

When simulating the above test program you should start seeing some activity on
the UART transmit line after a while. When synthesizing and executing the test
program on a FPGA, you should be able to read the message from the UART
connection at a baudrate of 115200. Use following commands for this (under the
assumption that `/dev/ttyUSB0` is the device file for the connection):

    stty -F /dev/ttyUSB0 115200
    cat /dev/ttyUSB0


## Interrupts

The SoC generates periodic timer interrupts with a frequency of 100 Hz. Define
a global function called `exception_handler()` to handle interrupts. The
function should be defined as follows:

```
void exception_handler(long mcause, void *mepc, void *mtval, void *frame_ptr)
```

The parameter `mcause` indicates the cause of the interrupt or exception. Its
value corresponds to the content of the `mcause` CSR (see Sect. 3.1.16 of the
[RISC-V Privileged Spec.](https://github.com/riscv/riscv-isa-manual/releases/download/Ratified-IMFDQC-and-Priv-v1.11/riscv-privileged-20190608.pdf).
In particular, the value is negative in case of an interrupt and positive or 0
in case of an exception. Likewise, the parameters `mepc` and `mtval` hold the
corresponding CSR register values and `frame_ptr` is the value of the stack
pointer when the interrupt occured.

Note that the handler must clear the interrupt, otherwise it triggers again
right away. The timer interrupt can be cleared by writing 1 to the memory-
mapped register at address `0xFF000200`.

The following program prints a message whenever a timer interrupt occurs:

```
#include "sw/lib/uart.h"

int main(int argc, char *argv[]) {
    // enable timer interrupt
    asm volatile("csrw mie,     %0" :: "r"(0x00000080));
    asm volatile("csrs mstatus, %0" :: "r"(0x00000008));

    while (1)
        ;

    return 0;
}

void exception_handler(long mcause, void *mepc, void *mtval, void *frame_ptr)
{
    // clear interrupt flag
    volatile long *const interrupt_flags = (volatile long *const)0xFF000200;
    *interrupt_flags = 1;

    uart_puts("Hello world!\n");
}
```
