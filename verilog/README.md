# Original Verilog Export

`symphony.v`, `symphony.json`, and the 28 modules in `builtin_components/` are preserved byte-for-byte from the supplied Turing Complete export. They have not been repaired in this repository.

## Files and initialization

| File | Purpose |
| --- | --- |
| `symphony.v` | Top-level structural circuit |
| `symphony.json` | Port widths and clock/reset metadata; not a native game save |
| `builtin_components/` | Exported implementations of the referenced component types |
| `8272137354285170169.hex` | Main RAM initialization, generated locally |
| `5281115256352676631.hex` | External RAM initialization, generated locally |

The original memory files each contain 16,777,216 lines of `00` followed by LF: 16 MiB of simulated memory in a 48 MiB text file. Both contain only zeros. They are omitted from Git and replaced by an exact reconstruction script.

From the repository root, with Python 3 installed:

```bash
python tools/generate_memory.py
```

On Windows, `py tools/generate_memory.py` is an alternative if Python is installed through the Windows launcher. No third-party Python packages are required.

The script always writes into this `verilog/` directory, independent of the current working directory. It verifies matching existing files and refuses to overwrite a file with different contents. `memory-images.json` records the original filenames, sizes, and SHA-256 hashes.

The HDL uses bare filenames in `$readmemh`, so a future simulator run must resolve those paths from this directory, or deliberately adjust its working directory/loading configuration.

## Known export issues

Static source inspection found the following; no external compiler has confirmed diagnostics yet:

| Location | Observation |
| --- | --- |
| `assign in_en[7:0] = wire_474[7:0]` | Both signals are declared scalar, so the part-selects are invalid |
| Register address shifts | Four-bit signals such as `wire_370` are selected as `[31:0]` rather than explicitly extended |
| Immediate operand mux | The 16-bit `wire_354` is selected as `[31:0]` |
| Comparison-result switch | The four-bit `wire_618` is selected as `[31:0]` |
| Keyboard/time paths | `wire_562`, `wire_560`, and `wire_294` have no driver in the top level; `wire_564` has only its low nine bits driven |
| Peripheral export | No screen device model or screen port is exposed |

These issues may prevent compilation or propagate unknown values. A working game circuit must not be assumed equivalent to an unverified export. Any future repaired HDL should be clearly separated from this original export and checked with program-level tests.

The built-in memory and arithmetic components are game-generated models. Their semantics, including reset behavior, shift amounts, and memory boundary handling, should be reviewed when building an external simulation. FPGA resource usage and achievable clock speed are unknown.
