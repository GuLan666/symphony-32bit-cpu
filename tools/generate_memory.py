#!/usr/bin/env python3
"""Reconstruct the two original zero-filled memory images without overwriting data."""
from pathlib import Path
import hashlib
import json
import sys


def digest(path):
    result = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b""):
            result.update(chunk)
    return result.hexdigest()


def main():
    directory = Path(__file__).resolve().parents[1] / "verilog"
    records = json.loads((directory / "memory-images.json").read_text(encoding="utf-8"))
    # Preflight every existing image before creating anything.
    for name, spec in records.items():
        path = directory / name
        if path.exists() and (path.stat().st_size != spec["file_bytes"] or digest(path) != spec["sha256"]):
            raise ValueError(f"Refusing to overwrite differing memory contents: {path}")
    for name, spec in records.items():
        path = directory / name
        if path.exists():
            print(f"Verified existing image: {name}")
            continue
        # Exclusive creation also protects against a file appearing after preflight.
        with path.open("xb") as stream:
            chunk_entries = 65536
            full, remainder = divmod(spec["memory_bytes"], chunk_entries)
            for _ in range(full):
                stream.write(b"00\n" * chunk_entries)
            stream.write(b"00\n" * remainder)
        if path.stat().st_size != spec["file_bytes"] or digest(path) != spec["sha256"]:
            raise ValueError(f"Generated image failed verification: {path}")
        print(f"Created and verified: {name}")
    return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except (OSError, ValueError) as error:
        print(error, file=sys.stderr)
        sys.exit(1)
