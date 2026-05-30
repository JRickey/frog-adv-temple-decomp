@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08015a00, 0x08015a2c)  (44 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8015a00 --end 0x8015a2c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08015a00: b530        push	{r4, r5, lr}
@   0x08015a02: b083        sub	sp, #12
@   0x08015a04: 4c08        ldr	r4, [pc, #32]	@ (0x15a28)
@   0x08015a06: 7a20        ldrb	r0, [r4, #8]
@   0x08015a08: 8821        ldrh	r1, [r4, #0]
@   0x08015a0a: 8862        ldrh	r2, [r4, #2]
@   0x08015a0c: 88a3        ldrh	r3, [r4, #4]
@   0x08015a0e: 88e5        ldrh	r5, [r4, #6]
@   0x08015a10: 9500        str	r5, [sp, #0]
@   0x08015a12: 6924        ldr	r4, [r4, #16]
@   0x08015a14: 9401        str	r4, [sp, #4]
@   0x08015a16: 2401        movs	r4, #1
@   0x08015a18: 9402        str	r4, [sp, #8]
@   0x08015a1a: f7fd        f8d3 	bl	0x12bc4
@   0x08015a1e: b003        add	sp, #12
@   0x08015a20: bc30        pop	{r4, r5}
@   0x08015a22: bc01        pop	{r0}
@   0x08015a24: 4700        bx	r0
@   0x08015a26: 0000        movs	r0, r0
@   0x08015a28: 7ce8        ldrb	r0, [r5, #19]
@   0x08015a2a: 0830        lsrs	r0, r6, #32

        thumb_func_start sub_08015A00
sub_08015A00: @ 0x08015a00
        .incbin "frog_us_baserom.gba", 0x15a00, 0x2c
        thumb_func_end sub_08015A00
