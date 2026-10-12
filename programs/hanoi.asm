// Recursive Tower of Hanoi for the game's Symphony ISA.
// Written by Kerry Wang from the game's supplied pseudocode.
// Inputs: largest disk index (zero-based), source, destination, spare.
// Assumes the CPU starts with sp = 0. Game test result: 64/64 passed.

const disk_nr = r1
const source = r2
const dest = r3
const spare = r4

in disk_nr
in source
in dest
in spare
call move
jmp end

move:
    // Preserve the caller's saved parameters.
    push r5
    push r6
    push r7
    push r8

    // Keep this invocation's arguments across recursive calls.
    mov r5, disk_nr
    mov r6, source
    mov r7, dest
    mov r8, spare
    cmp r5, 0
    jne conditionnz

    // Base case: move disk 0 from source to destination.
    out r6
    out 5
    out r7
    out 5
    jmp endfunc

conditionnz:
    // Move the smaller disks from source to spare.
    sub disk_nr, r5, 1
    mov source, r6
    mov spare, r7
    mov dest, r8
    call move

    // Move the current largest disk to destination.
    out r6
    out 5
    out r7
    out 5

    // Move the smaller disks from spare to destination.
    sub disk_nr, r5, 1
    mov source, r8
    mov dest, r7
    mov spare, r6
    call move

endfunc:
    // Restore in reverse order, then return to the caller.
    pop r8
    pop r7
    pop r6
    pop r5
    ret

end:
// Empty end label preserved from the in-game solution; not a HALT opcode.
