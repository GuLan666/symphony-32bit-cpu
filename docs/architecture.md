# CPU Architecture

This document describes the supplied Symphony circuit export. It separates the game's ISA contract from facts visible in the exported wiring. The exported HDL has not been compiled or simulated externally.

## Datapath and instruction fields

The arithmetic datapath, program counter, register values, and base instructions are 32 bits wide. Base instructions occupy four bytes; assembler macros occupy multiple base instructions.

For a typical three-register ALU instruction:

| Bits | Role |
| --- | --- |
| 31–24 | Opcode |
| 23–20 | Destination register |
| 19–16 | First source register |
| 15–12 | Reserved zero bits |
| 11–8 | Second source register |
| 7–0 | Reserved zero bits |

In immediate ALU instructions, bits 15–0 encode an unsigned 16-bit immediate. Instruction bit 28 selects the immediate operand path in the export. Other instruction families use different subsets of the register fields; see the [ISA reference](isa.md).

## Register bank

`TC_RAM_BE_L32_L32_S32_1` supplies two 32-bit reads and one 32-bit write. Its storage is 256 bytes (`ADDR_WIDTH=8`). A four-bit register index is shifted left by two to form a byte address, so the ISA's 16 named register slots occupy 64 bytes of that backing storage.

`zr` is index 0; `r1–r13` are the general-purpose registers; `sp` is index 14; `flags` is index 15. The write-enable logic blocks writes to register slot 0. The RAM initializes to zero and clears on reset, making `zr` read as zero and initializing `sp` to zero.

## ALU and flags

The circuit combines addition, subtraction, bitwise operations, and shifts. Subtraction uses addition with the second operand inverted and carry-in set to 1. Enabled output paths feed an OR-combined result bus; disabled switch outputs are zero in the supplied component model.

`TC_Equal_108`, `TC_LessU_106`, and `TC_LessS_107` feed the flag constructor:

| Flag bit | Meaning |
| --- | --- |
| 0 | Operands equal |
| 1 | First operand is less than second, unsigned |
| 2 | First operand is less than second, signed |
| 3 | Zero |

The intended comparison result is a zero-extended flag value. The raw export has an out-of-range part-select on this path; this needs correction and external verification before relying on HDL simulation behavior.

## Program counter and execution

`TC_Register_46` is the 32-bit PC. `TC_Add_47` adds four, and `TC_Mux_48` selects between that sequential address and the branch target. The PC's save input is held high. The main memory's fourth read port supplies the instruction at the low 24 bits of the PC.

The exported structure has combinational instruction decode, ALU and memory reads, with state updated at clock edges. It has no explicit instruction pipeline register or multi-phase controller on the main instruction path. This is consistent with a single-cycle organization for base instructions, but no external timing or cycle-accurate equivalence claim is made.

## Memory organization

| Storage | Capacity | Access |
| --- | --- | --- |
| Main RAM | 16 MiB | 8/16/32-bit data loads and stores; separate 32-bit instruction-read port |
| External RAM | 16 MiB | 32-bit `pload` / `pstore` |
| Register-bank RAM | 256 bytes backing storage | Two 32-bit reads and one 32-bit write |

Both large memories use 24-bit byte addresses. Multi-byte values are big-endian: writing `0x12345678` at address A stores `12`, `34`, `56`, `78` at A through A+3. The exported models perform combinational reads and clocked writes. Their reset inputs suppress writes while reset is asserted; they do not reload the large memories on reset.

Instruction fetch and data operations share the main RAM instance through separate ports. The external RAM is a separate game memory component, not a physical disk interface in this HDL export.

## Stack addressing

The stack starts with `sp = 0`. A push subtracts 4 before writing; a pop reads before adding 4. The first push wraps the 32-bit pointer to `0xFFFFFFFC`. Address truncation maps that to `0xFFFFFC`, using the last four bytes of main RAM.

The stack shares main memory with code and other data. No stack bounds or collision checks are implemented in the examples.

## Peripheral scope

The ISA defines standard I/O, keyboard, screen, and time instructions. The supplied Verilog top level exposes only `clk`, `rst`, 8-bit `in`, `in_en`, 32-bit `out`, and `out_en`.

Keyboard/time-related internal signals are undriven in the top-level export, and there is no exported screen device/interface model. These peripherals therefore cannot be claimed as reproduced by the supplied HDL alone. See [export notes](../verilog/README.md).
