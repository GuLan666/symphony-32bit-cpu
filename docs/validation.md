# Validation and Completion Records

## Evidence and scope

| Item | Status | Evidence |
| --- | --- | --- |
| Recursive Hanoi on the in-game CPU | 64/64 tests passed | [Completion screenshot](../assets/hanoi-passed.png) |
| Stack I/O example | Source and game task reviewed; no separate pass-count screenshot included | [Source](../programs/stack_io.asm), [task](../assets/stack-task.png) |
| Steam achievements | 10/10 unlocked | [Steam screenshot](../assets/achievements.png) |
| All game levels | Completed, as reported by the project author after finishing the remaining 2% | Historical [progress map](../assets/progress-map.png); refreshed 100% profile screenshot not yet included |
| Exported component dependencies | All 28 referenced module types present | `verilog/builtin_components/` |
| Exported memory initialization | Both original files contain 16,777,216 zero bytes as text lines | SHA-256 record in `verilog/memory-images.json` |
| External HDL compilation/simulation | Not yet verified | Raw export has known issues |
| FPGA implementation | Not performed | No board or timing results claimed |

The [historical profile screenshot](../assets/profile-historical.png) shows 98% completion and a Hanoi entry of 1,138 cycles. It predates the author's report that the remaining levels were completed. It is retained as a historical performance record, not presented as proof of 100% completion.

The in-game Hanoi screenshot rounds its slowest-case cycle display to 1.1k. The website's 1,138-cycle entry is a recorded game metric, not measured external hardware performance. Screenshots from different runs need not have identical scoring values.

## Calculated example properties

For largest disk index k, the Hanoi solution moves k+1 disks using `2^(k+1) - 1` moves. At k=4, this is 31 moves and 124 output commands. Each active invocation consumes 20 stack bytes; maximum recursion depth five gives 100 bytes of peak stack use. These values are derived from the assembly, not measurements from a testbench.

## Reproduction limits

The package includes the assembly, ISA definitions, screenshots, and original HDL export. It does not include a native game circuit save, a standalone assembler, encoded example programs, or an HDL testbench. Its zero-filled memory images can be regenerated exactly, but doing so does not load a program.

The evidence demonstrates successful in-game execution of the supplied Hanoi solution. It does not constitute exhaustive verification of every ISA instruction or every possible input.
