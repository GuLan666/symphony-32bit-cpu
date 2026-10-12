// LIFO stack I/O for the game's Symphony ISA.
// Nonzero input: push. Zero input: pop and output.
// Assumes sp = 0 initially and valid input (no empty-stack pop).

start:
    in r1;
    cmp r1, 0;
    je pop;

    // Equivalent to push r1: allocate four bytes, then store.
    sub sp, sp, 4
    store_32 [sp], r1;
    jmp start;

pop:
    // Equivalent to pop r1: load, then release four bytes.
    load_32 r1, [sp];
    add sp, sp, 4;
    out r1;
    jmp start;
