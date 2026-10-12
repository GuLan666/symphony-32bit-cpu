# Symphony ISA Reference

This reference is transcribed from the game-provided definitions supplied by the project author. The [assembler configuration](../isa/symphony_isa.txt) preserves operand forms and bit patterns, normalizes formatting, and replaces comments with English descriptions. Copy-paste errors in load/store width and immediate-address comments were corrected. This normalized configuration has not been re-imported into the game for a new test run.

## Registers

| ID | Name | Role |
| --- | --- | --- |
| `0000` | `zr` | Zero register |
| `0001` | `r1` | General-purpose register |
| `0010` | `r2` | General-purpose register |
| `0011` | `r3` | General-purpose register |
| `0100` | `r4` | General-purpose register |
| `0101` | `r5` | General-purpose register |
| `0110` | `r6` | General-purpose register |
| `0111` | `r7` | General-purpose register |
| `1000` | `r8` | General-purpose register |
| `1001` | `r9` | General-purpose register |
| `1010` | `r10` | General-purpose register |
| `1011` | `r11` | General-purpose register |
| `1100` | `r12` | General-purpose register |
| `1101` | `r13` | General-purpose register |
| `1110` | `sp` | Stack pointer |
| `1111` | `flags` | Comparison flags / call-return scratch register |

## Encoding conventions

Each base instruction is four bytes. Below, groups are written most-significant byte first. `U16` is an unsigned 16-bit field (0–65535); `label` means that the assembler resolves a label into the encoded operand. Register-target jumps can supply a wider address than immediate-target jumps. Actual large-memory addresses use only the low 24 bits in this implementation.

There are **70 listed assembly forms**, counting register/immediate overloads, aliases, and macros. This is not a claim of 70 distinct hardware operations.

`mov`, `neg`, and `not` are single-instruction aliases of OR, SUB, and NOR with `zr`. `push` and `pop` expand to two instructions each; `call` expands to five; `ret` expands to three. `call` calculates the return address as the current PC plus 20 bytes and, like `ret`, overwrites `flags`.

The flags are comparison results rather than conventional arithmetic carry/overflow flags. Only the explicit `cmp` form is documented as producing them; an ALU instruction with another destination should not be assumed to update `flags`.

The ISA specifies keyboard, screen, and time operations, but their models are not fully represented in the supplied Verilog export. See [export scope](../verilog/README.md).

## Instruction forms

### System and I/O

**`nop`**

```text
00000000 00000000 00000000 00000000
```

No operation.

**`in %a(register)`**

```text
00000001 aaaa0000 00000000 00000000
```

Read standard input into register a.

**`out %b(register)`**

```text
00000010 00000000 0000bbbb 00000000
```

Write register b to standard output.

**`out %a:U16(immediate)`**

```text
00010010 00000000 aaaaaaaa aaaaaaaa
```

Write an unsigned 16-bit immediate to standard output.

**`keyboard %a(register)`**

```text
00000011 aaaa0000 00000000 00000000
```

Read keyboard input into register a.

**`screen %a(register), %b(register)`**

```text
00000100 0000aaaa 0000bbbb 00000000
```

Write register b to the screen option selected by register a.

**`screen %a(register), %b:U16(immediate)`**

```text
00010100 0000aaaa bbbbbbbb bbbbbbbb
```

Write an immediate to the screen option selected by register a.

**`time_0 %a(register)`**

```text
00000101 aaaa0000 00000000 00000000
```

Read the low 32 bits of system time into register a.

**`time_1 %a(register)`**

```text
00000110 aaaa0000 00000000 00000000
```

Read the high 32 bits of system time into register a.

**`counter %a(register)`**

```text
00000111 aaaa0000 00000000 00000000
```

Read the program counter into register a.


### ALU

**`nand %a(register), %b(register), %c(register)`**

```text
00100000 aaaabbbb 0000cccc 00000000
```

Bitwise NAND; store the result in a.

**`or %a(register), %b(register), %c(register)`**

```text
00100001 aaaabbbb 0000cccc 00000000
```

Bitwise OR; store the result in a.

**`and %a(register), %b(register), %c(register)`**

```text
00100010 aaaabbbb 0000cccc 00000000
```

Bitwise AND; store the result in a.

**`nor %a(register), %b(register), %c(register)`**

```text
00100011 aaaabbbb 0000cccc 00000000
```

Bitwise NOR; store the result in a.

**`add %a(register), %b(register), %c(register)`**

```text
00100100 aaaabbbb 0000cccc 00000000
```

Addition; store the result in a.

**`sub %a(register), %b(register), %c(register)`**

```text
00100101 aaaabbbb 0000cccc 00000000
```

Subtraction (b minus c); store the result in a.

**`xor %a(register), %b(register), %c(register)`**

```text
00100110 aaaabbbb 0000cccc 00000000
```

Bitwise XOR; store the result in a.

**`lsl %a(register), %b(register), %c(register)`**

```text
00100111 aaaabbbb 0000cccc 00000000
```

Logical left shift of b by c; store the result in a.

**`lsr %a(register), %b(register), %c(register)`**

```text
00101000 aaaabbbb 0000cccc 00000000
```

Logical right shift of b by c; store the result in a.

**`asr %a(register), %b(register), %c(register)`**

```text
00101001 aaaabbbb 0000cccc 00000000
```

Arithmetic right shift of b by c; store the result in a.

**`nand %a(register), %b(register), %c:U16(immediate | label)`**

```text
00110000 aaaabbbb cccccccc cccccccc
```

Bitwise NAND; store the result in a.

**`or %a(register), %b(register), %c:U16(immediate | label)`**

```text
00110001 aaaabbbb cccccccc cccccccc
```

Bitwise OR; store the result in a.

**`and %a(register), %b(register), %c:U16(immediate | label)`**

```text
00110010 aaaabbbb cccccccc cccccccc
```

Bitwise AND; store the result in a.

**`nor %a(register), %b(register), %c:U16(immediate | label)`**

```text
00110011 aaaabbbb cccccccc cccccccc
```

Bitwise NOR; store the result in a.

**`add %a(register), %b(register), %c:U16(immediate | label)`**

```text
00110100 aaaabbbb cccccccc cccccccc
```

Addition; store the result in a.

**`sub %a(register), %b(register), %c:U16(immediate | label)`**

```text
00110101 aaaabbbb cccccccc cccccccc
```

Subtraction (b minus c); store the result in a.

**`xor %a(register), %b(register), %c:U16(immediate | label)`**

```text
00110110 aaaabbbb cccccccc cccccccc
```

Bitwise XOR; store the result in a.

**`lsl %a(register), %b(register), %c:U16(immediate | label)`**

```text
00110111 aaaabbbb cccccccc cccccccc
```

Logical left shift of b by c; store the result in a.

**`lsr %a(register), %b(register), %c:U16(immediate | label)`**

```text
00111000 aaaabbbb cccccccc cccccccc
```

Logical right shift of b by c; store the result in a.

**`asr %a(register), %b(register), %c:U16(immediate | label)`**

```text
00111001 aaaabbbb cccccccc cccccccc
```

Arithmetic right shift of b by c; store the result in a.


### Compare

**`cmp %a(register), %b(register)`**

```text
00101010 1111aaaa 0000bbbb 00000000
```

Compare a and b; write the result to flags.

**`cmp %a(register), %b:U16(immediate)`**

```text
00111010 1111aaaa bbbbbbbb bbbbbbbb
```

Compare a and b; write the result to flags.


### Branch

**`jmp %a(register)`**

```text
01001000 00001111 0000aaaa 00000000
```

Jump to the address in register a.

**`jmp %a:U16(immediate | label)`**

```text
01011000 00001111 aaaaaaaa aaaaaaaa
```

Always: jump to address a, using the previous comparison where applicable.

**`je %a:U16(immediate | label)`**

```text
01010001 00001111 aaaaaaaa aaaaaaaa
```

Equal: jump to address a, using the previous comparison where applicable.

**`jne %a:U16(immediate | label)`**

```text
01011001 00001111 aaaaaaaa aaaaaaaa
```

Not equal: jump to address a, using the previous comparison where applicable.

**`jb %a:U16(immediate | label)`**

```text
01010010 00001111 aaaaaaaa aaaaaaaa
```

Unsigned less-than: jump to address a, using the previous comparison where applicable.

**`jae %a:U16(immediate | label)`**

```text
01011010 00001111 aaaaaaaa aaaaaaaa
```

Unsigned greater-than or equal: jump to address a, using the previous comparison where applicable.

**`jbe %a:U16(immediate | label)`**

```text
01010011 00001111 aaaaaaaa aaaaaaaa
```

Unsigned less-than or equal: jump to address a, using the previous comparison where applicable.

**`ja %a:U16(immediate | label)`**

```text
01011011 00001111 aaaaaaaa aaaaaaaa
```

Unsigned greater-than: jump to address a, using the previous comparison where applicable.

**`jl %a:U16(immediate | label)`**

```text
01010100 00001111 aaaaaaaa aaaaaaaa
```

Signed less-than: jump to address a, using the previous comparison where applicable.

**`jge %a:U16(immediate | label)`**

```text
01011100 00001111 aaaaaaaa aaaaaaaa
```

Signed greater-than or equal: jump to address a, using the previous comparison where applicable.

**`jle %a:U16(immediate | label)`**

```text
01010101 00001111 aaaaaaaa aaaaaaaa
```

Signed less-than or equal: jump to address a, using the previous comparison where applicable.

**`jg %a:U16(immediate | label)`**

```text
01011101 00001111 aaaaaaaa aaaaaaaa
```

Signed greater-than: jump to address a, using the previous comparison where applicable.


### Memory

**`load_8 %dest(register), [%adr(register)]`**

```text
01100000 dddd0000 0000aaaa 00000000
```

Load 8 bits from main memory at adr into dest.

**`load_8 %dest(register), [%adr:U16(immediate)]`**

```text
01110000 dddd0000 aaaaaaaa aaaaaaaa
```

Load 8 bits from main memory at adr into dest.

**`load_16 %dest(register), [%adr(register)]`**

```text
01100001 dddd0000 0000aaaa 00000000
```

Load 16 bits from main memory at adr into dest.

**`load_16 %dest(register), [%adr:U16(immediate)]`**

```text
01110001 dddd0000 aaaaaaaa aaaaaaaa
```

Load 16 bits from main memory at adr into dest.

**`load_32 %dest(register), [%adr(register)]`**

```text
01100010 dddd0000 0000aaaa 00000000
```

Load 32 bits from main memory at adr into dest.

**`load_32 %dest(register), [%adr:U16(immediate)]`**

```text
01110010 dddd0000 aaaaaaaa aaaaaaaa
```

Load 32 bits from main memory at adr into dest.

**`pload %dest(register), [%adr(register)]`**

```text
01100011 dddd0000 0000aaaa 00000000
```

Load 32 bits from external memory at adr into dest.

**`pload %dest(register), [%adr:U16(immediate)]`**

```text
01110011 dddd0000 aaaaaaaa aaaaaaaa
```

Load 32 bits from external memory at adr into dest.

**`store_8 [%adr(register)], %value(register)`**

```text
01100100 0000vvvv 0000aaaa 00000000
```

Store the low 8 bits of value to main memory at adr.

**`store_8 [%adr:U16(immediate)], %value(register)`**

```text
01110100 0000vvvv aaaaaaaa aaaaaaaa
```

Store the low 8 bits of value to main memory at adr.

**`store_16 [%adr(register)], %value(register)`**

```text
01100101 0000vvvv 0000aaaa 00000000
```

Store the low 16 bits of value to main memory at adr.

**`store_16 [%adr:U16(immediate)], %value(register)`**

```text
01110101 0000vvvv aaaaaaaa aaaaaaaa
```

Store the low 16 bits of value to main memory at adr.

**`store_32 [%adr(register)], %value(register)`**

```text
01100110 0000vvvv 0000aaaa 00000000
```

Store the low 32 bits of value to main memory at adr.

**`store_32 [%adr:U16(immediate)], %value(register)`**

```text
01110110 0000vvvv aaaaaaaa aaaaaaaa
```

Store the low 32 bits of value to main memory at adr.

**`pstore [%adr(register)], %value(register)`**

```text
01100111 0000vvvv 0000aaaa 00000000
```

Store the low 32 bits of value to external memory at adr.

**`pstore [%adr:U16(immediate)], %value(register)`**

```text
01110111 0000vvvv aaaaaaaa aaaaaaaa
```

Store the low 32 bits of value to external memory at adr.


### Alias

**`mov %a(register), %b(register)`**

```text
00100001 aaaa0000 0000bbbb 00000000
```

Copy b into a (OR with zr).

**`mov %a(register), %b:U16(immediate | label)`**

```text
00110001 aaaa0000 bbbbbbbb bbbbbbbb
```

Copy b into a (OR with zr).

**`neg %a(register), %b(register)`**

```text
00100101 aaaa0000 0000bbbb 00000000
```

Negate b into a (subtract from zr).

**`neg %a(register), %b:U16(immediate | label)`**

```text
00110101 aaaa0000 bbbbbbbb bbbbbbbb
```

Negate b into a (subtract from zr).

**`not %a(register), %b(register)`**

```text
00100011 aaaa0000 0000bbbb 00000000
```

Bitwise invert b into a (NOR with zr).

**`not %a(register), %b:U16(immediate | label)`**

```text
00110011 aaaa0000 bbbbbbbb bbbbbbbb
```

Bitwise invert b into a (NOR with zr).


### Macro

**`push %a(register)`**

```text
00110101 11101110 00000000 00000100   01100110 0000aaaa 00001110 00000000
```

sub sp, sp, 4; store_32 [sp], a

**`pop %a(register)`**

```text
01100010 aaaa0000 00001110 00000000   00110100 11101110 00000000 00000100
```

load_32 a, [sp]; add sp, sp, 4

**`call %a(label)`**

```text
00000111 11110000 00000000 00000000   00110100 11111111 00000000 00010100   00110101 11101110 00000000 00000100   01100110 00001111 00001110 00000000   01011000 00001111 aaaaaaaa aaaaaaaa
```

counter flags; add flags, flags, 20; sub sp, sp, 4; store_32 [sp], flags; jmp a. Clobbers flags.

**`ret`**

```text
01100010 11110000 00001110 00000000   00110100 11101110 00000000 00000100   01001000 00001111 00001111 00000000
```

load_32 flags, [sp]; add sp, sp, 4; jmp flags. Clobbers flags.
