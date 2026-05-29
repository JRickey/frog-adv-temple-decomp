@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08004c04, 0x08004c30)  (44 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8004c04 --end 0x8004c30 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08004c04: b530        push	{r4, r5, lr}
@   0x08004c06: 1c03        adds	r3, r0, #0
@   0x08004c08: 1c0c        adds	r4, r1, #0
@   0x08004c0a: 1c15        adds	r5, r2, #0
@   0x08004c0c: 4907        ldr	r1, [pc, #28]	@ (0x4c2c)
@   0x08004c0e: 200e        movs	r0, #14
@   0x08004c10: 7288        strb	r0, [r1, #10]
@   0x08004c12: 2005        movs	r0, #5
@   0x08004c14: 1c19        adds	r1, r3, #0
@   0x08004c16: f001        ffcd 	bl	0x6bb4
@   0x08004c1a: 1c20        adds	r0, r4, #0
@   0x08004c1c: 1c29        adds	r1, r5, #0
@   0x08004c1e: 2211        movs	r2, #17
@   0x08004c20: f006        fdc6 	bl	0xb7b0
@   0x08004c24: bc30        pop	{r4, r5}
@   0x08004c26: bc01        pop	{r0}
@   0x08004c28: 4700        bx	r0
@   0x08004c2a: 0000        movs	r0, r0
@   0x08004c2c: 5330        strh	r0, [r6, r4]
@   0x08004c2e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08004C04
sub_08004C04: @ 0x08004c04
        .incbin "frog_us_baserom.gba", 0x4c04, 0x2c
        thumb_func_end sub_08004C04
