@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08013a34, 0x08013a70)  (60 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8013a34 --end 0x8013a70 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08013a34: b570        push	{r4, r5, r6, lr}
@   0x08013a36: b083        sub	sp, #12
@   0x08013a38: 0600        lsls	r0, r0, #24
@   0x08013a3a: 0e00        lsrs	r0, r0, #24
@   0x08013a3c: 4e0b        ldr	r6, [pc, #44]	@ (0x13a6c)
@   0x08013a3e: 0045        lsls	r5, r0, #1
@   0x08013a40: 182d        adds	r5, r5, r0
@   0x08013a42: 00ed        lsls	r5, r5, #3
@   0x08013a44: 19ac        adds	r4, r5, r6
@   0x08013a46: 7a20        ldrb	r0, [r4, #8]
@   0x08013a48: 8821        ldrh	r1, [r4, #0]
@   0x08013a4a: 8862        ldrh	r2, [r4, #2]
@   0x08013a4c: 88a3        ldrh	r3, [r4, #4]
@   0x08013a4e: 88e4        ldrh	r4, [r4, #6]
@   0x08013a50: 9400        str	r4, [sp, #0]
@   0x08013a52: 3610        adds	r6, #16
@   0x08013a54: 19ad        adds	r5, r5, r6
@   0x08013a56: 682c        ldr	r4, [r5, #0]
@   0x08013a58: 9401        str	r4, [sp, #4]
@   0x08013a5a: 2400        movs	r4, #0
@   0x08013a5c: 9402        str	r4, [sp, #8]
@   0x08013a5e: f7ff        f8b1 	bl	0x12bc4
@   0x08013a62: b003        add	sp, #12
@   0x08013a64: bc70        pop	{r4, r5, r6}
@   0x08013a66: bc01        pop	{r0}
@   0x08013a68: 4700        bx	r0
@   0x08013a6a: 0000        movs	r0, r0
@   0x08013a6c: 70ec        strb	r4, [r5, #3]
@   0x08013a6e: 0830        lsrs	r0, r6, #32

        thumb_func_start sub_08013A34
sub_08013A34: @ 0x08013a34
        .incbin "frog_us_baserom.gba", 0x13a34, 0x3c
        thumb_func_end sub_08013A34
