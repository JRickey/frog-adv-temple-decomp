@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080139f8, 0x08013a34)  (60 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80139f8 --end 0x8013a34 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080139f8: b570        push	{r4, r5, r6, lr}
@   0x080139fa: b083        sub	sp, #12
@   0x080139fc: 0600        lsls	r0, r0, #24
@   0x080139fe: 0e00        lsrs	r0, r0, #24
@   0x08013a00: 4e0b        ldr	r6, [pc, #44]	@ (0x13a30)
@   0x08013a02: 0045        lsls	r5, r0, #1
@   0x08013a04: 182d        adds	r5, r5, r0
@   0x08013a06: 00ed        lsls	r5, r5, #3
@   0x08013a08: 19ac        adds	r4, r5, r6
@   0x08013a0a: 7a20        ldrb	r0, [r4, #8]
@   0x08013a0c: 8821        ldrh	r1, [r4, #0]
@   0x08013a0e: 8862        ldrh	r2, [r4, #2]
@   0x08013a10: 88a3        ldrh	r3, [r4, #4]
@   0x08013a12: 88e4        ldrh	r4, [r4, #6]
@   0x08013a14: 9400        str	r4, [sp, #0]
@   0x08013a16: 3610        adds	r6, #16
@   0x08013a18: 19ad        adds	r5, r5, r6
@   0x08013a1a: 682c        ldr	r4, [r5, #0]
@   0x08013a1c: 9401        str	r4, [sp, #4]
@   0x08013a1e: 2402        movs	r4, #2
@   0x08013a20: 9402        str	r4, [sp, #8]
@   0x08013a22: f7ff        f8cf 	bl	0x12bc4
@   0x08013a26: b003        add	sp, #12
@   0x08013a28: bc70        pop	{r4, r5, r6}
@   0x08013a2a: bc01        pop	{r0}
@   0x08013a2c: 4700        bx	r0
@   0x08013a2e: 0000        movs	r0, r0
@   0x08013a30: 702c        strb	r4, [r5, #0]
@   0x08013a32: 0830        lsrs	r0, r6, #32

        thumb_func_start sub_080139F8
sub_080139F8: @ 0x080139f8
        .incbin "frog_us_baserom.gba", 0x139f8, 0x3c
        thumb_func_end sub_080139F8
