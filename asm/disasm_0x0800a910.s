@ Auto-peeled by agent — see tools/agent/auto_peel.py
@ Range:  [0x0800a910, 0x0800a9d4)  (0xc4 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800a910 --end 0x800a9d4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800a910: b510        push    {r4, lr}
@   0x0800a912: 4c2f        ldr     r4, [pc, #188]  @ (0x800a9d0)
@   0x0800a914: 1c20        adds    r0, r4, #0
@   0x0800a916: 2105        movs    r1, #5
@   0x0800a918: 2200        movs    r2, #0
@   0x0800a91a: f7fb ff3f   bl      0x800679c
@   0x0800a91e: 0600        lsls    r0, r0, #24
@   0x0800a920: 2800        cmp     r0, #0
@   0x0800a922: d017        beq.n   0x800a954
@   ...
@   0x0800a9c8: bc10        pop     {r4}
@   0x0800a9ca: bc01        pop     {r0}
@   0x0800a9cc: 4700        bx      r0

        thumb_func_start sub_0800A910
sub_0800A910: @ 0x0800a910
        .incbin "frog_us_baserom.gba", 0xa910, 0xc4
        thumb_func_end sub_0800A910
