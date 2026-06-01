@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08013a70, 0x08013aac)  (60 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8013a70 --end 0x8013aac --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08013a70: b570        push	{r4, r5, r6, lr}
@   0x08013a72: b083        sub	sp, #12
@   0x08013a74: 0600        lsls	r0, r0, #24
@   0x08013a76: 0e00        lsrs	r0, r0, #24
@   0x08013a78: 4e0b        ldr	r6, [pc, #44]	@ (0x13aa8)
@   0x08013a7a: 0045        lsls	r5, r0, #1
@   0x08013a7c: 182d        adds	r5, r5, r0
@   0x08013a7e: 00ed        lsls	r5, r5, #3
@   0x08013a80: 19ac        adds	r4, r5, r6
@   0x08013a82: 7a20        ldrb	r0, [r4, #8]
@   0x08013a84: 8821        ldrh	r1, [r4, #0]
@   0x08013a86: 8862        ldrh	r2, [r4, #2]
@   0x08013a88: 88a3        ldrh	r3, [r4, #4]
@   0x08013a8a: 88e4        ldrh	r4, [r4, #6]
@   0x08013a8c: 9400        str	r4, [sp, #0]
@   0x08013a8e: 3610        adds	r6, #16
@   0x08013a90: 19ad        adds	r5, r5, r6
@   0x08013a92: 682c        ldr	r4, [r5, #0]
@   0x08013a94: 9401        str	r4, [sp, #4]
@   0x08013a96: 2402        movs	r4, #2
@   0x08013a98: 9402        str	r4, [sp, #8]
@   0x08013a9a: f7ff        f893 	bl	0x12bc4
@   0x08013a9e: b003        add	sp, #12
@   0x08013aa0: bc70        pop	{r4, r5, r6}
@   0x08013aa2: bc01        pop	{r0}
@   0x08013aa4: 4700        bx	r0
@   0x08013aa6: 0000        movs	r0, r0
@   0x08013aa8: 70ec        strb	r4, [r5, #3]
@   0x08013aaa: 0830        lsrs	r0, r6, #32

        thumb_func_start sub_08013A70
sub_08013A70: @ 0x08013a70
        .incbin "frog_us_baserom.gba", 0x13a70, 0x3c
        thumb_func_end sub_08013A70
