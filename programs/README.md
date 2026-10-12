# Assembly Examples

These files target the Symphony assembler in Turing Complete. They are not x86, MIPS, or RISC-V assembly.
Only explanatory comments and formatting have been added to the supplied programs; their executable instruction sequences are preserved.

## Running in the game

1. Use your existing Symphony CPU circuit in the corresponding game level.
2. Open its assembly editor and use the Symphony instruction definitions.
3. Paste the relevant `.asm` program.
4. Reset the CPU, including the register bank (`sp = 0`), and run the level's tests.

A native circuit save and the precise game build are not included. The Verilog export cannot be imported as a native game circuit using these instructions. A new user must supply a compatible in-game CPU implementation to run these examples.

## Stack I/O

[Source](stack_io.asm) · [Task screenshot](../assets/stack-task.png)

| Input | Behavior |
| --- | --- |
| Nonzero value | Subtract 4 from `sp`; store the value at `[sp]` |
| Zero | Load the value at `[sp]`; add 4 to `sp`; output the value |

Example input: `10, 20, 30, 0, 0, 0`.
Expected output: `30, 20, 10`.

The example output is derived from the program logic, not a captured external simulation. Zero is a command rather than a pushable data value. The program has no stack bounds checking and runs an input loop without a HALT instruction. The supplied top-level input port is 8 bits wide.

The source and task statement are available; a dedicated pass-count screenshot for this level was not supplied.

## Recursive Tower of Hanoi

[Source](hanoi.asm) · [Input/output specification](../assets/hanoi-interface.png) · [Passed tests](../assets/hanoi-passed.png)

Four inputs are read in order:

| Input | Meaning |
| --- | --- |
| `disk_nr` | Largest disk index, 2–4 in the game task; disk count is `disk_nr + 1` |
| `source` | Starting peg, numbered 0–2 |
| `dest` | Destination peg |
| `spare` | Remaining peg |

The three peg arguments describe distinct pegs. For each move the program outputs `source, 5, dest, 5`: position the electromagnet, toggle it on, move to the destination, and toggle it off.

Example input: `2, 0, 2, 1` (three disks, source 0, destination 2, spare 1).
The algorithm produces these disk moves: `0→2, 0→1, 2→1, 0→2, 1→0, 1→2, 0→2`.
The first move therefore emits `0, 5, 2, 5`.

### Calling convention used by this program

| Registers | Role |
| --- | --- |
| `r1–r4` | Arguments; recursive calls may overwrite them |
| `r5–r8` | This invocation's saved arguments; preserved by each callee |
| `sp` | Downward-growing stack pointer |
| `flags` | Comparison flags and scratch storage used by call/return expansion |

Every active invocation uses 20 stack bytes: a 4-byte return address plus four saved 32-bit registers. With largest disk index 4, the maximum depth is five invocations, so peak stack usage is **100 bytes**, calculated from the code.

The game provides the recursive algorithm in [pseudocode](../assets/hanoi-pseudocode.png); Kerry Wang wrote the assembly translation. The supplied completion screenshot shows **64/64 tests passed**. The final `end:` label is empty and is not a machine-level halt. A standalone testbench must define its own completion condition.
