@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800a26c, 0x0800a2d8)  (108 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800a26c --end 0x800a2d8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800a26c: b510        push	{r4, lr}
@   0x0800a26e: 4a15        ldr	r2, [pc, #84]	@ (0xa2c4)
@   0x0800a270: 2001        movs	r0, #1
@   0x0800a272: 4240        negs	r0, r0
@   0x0800a274: 17c1        asrs	r1, r0, #31
@   0x0800a276: 6150        str	r0, [r2, #20]
@   0x0800a278: 6191        str	r1, [r2, #24]
@   0x0800a27a: 61d0        str	r0, [r2, #28]
@   0x0800a27c: 6211        str	r1, [r2, #32]
@   0x0800a27e: f000        f94f 	bl	0xa520
@   0x0800a282: 4911        ldr	r1, [pc, #68]	@ (0xa2c8)
@   0x0800a284: 4c11        ldr	r4, [pc, #68]	@ (0xa2cc)
@   0x0800a286: 7aa2        ldrb	r2, [r4, #10]
@   0x0800a288: 0090        lsls	r0, r2, #2
@   0x0800a28a: 1840        adds	r0, r0, r1
@   0x0800a28c: 6800        ldr	r0, [r0, #0]
@   0x0800a28e: f029        fd23 	bl	0x33cd8
@   0x0800a292: 490f        ldr	r1, [pc, #60]	@ (0xa2d0)
@   0x0800a294: 7aa2        ldrb	r2, [r4, #10]
@   0x0800a296: 0090        lsls	r0, r2, #2
@   0x0800a298: 1840        adds	r0, r0, r1
@   0x0800a29a: 6800        ldr	r0, [r0, #0]
@   0x0800a29c: f029        fd1c 	bl	0x33cd8
@   0x0800a2a0: 480c        ldr	r0, [pc, #48]	@ (0xa2d4)
@   0x0800a2a2: 7aa4        ldrb	r4, [r4, #10]
@   0x0800a2a4: 1820        adds	r0, r4, r0
@   0x0800a2a6: 7800        ldrb	r0, [r0, #0]
@   0x0800a2a8: f004        ffd0 	bl	0xf24c
@   0x0800a2ac: f7ff        fbd4 	bl	0x9a58
@   0x0800a2b0: f7fe        ff6a 	bl	0x9188
@   0x0800a2b4: f7f6        fb12 	bl	0x8dc
@   0x0800a2b8: f000        f836 	bl	0xa328
@   0x0800a2bc: bc10        pop	{r4}
@   0x0800a2be: bc01        pop	{r0}
@   0x0800a2c0: 4700        bx	r0
@   0x0800a2c2: 0000        movs	r0, r0
@   0x0800a2c4: 6110        str	r0, [r2, #16]
@   0x0800a2c6: 0300        lsls	r0, r0, #12
@   0x0800a2c8: 0cb8        lsrs	r0, r7, #18
@   0x0800a2ca: 080c        lsrs	r4, r1, #32
@   0x0800a2cc: 5330        strh	r0, [r6, r4]
@   0x0800a2ce: 0300        lsls	r0, r0, #12
@   0x0800a2d0: 0cfc        lsrs	r4, r7, #19
@   0x0800a2d2: 080c        lsrs	r4, r1, #32
@   0x0800a2d4: 0d84        lsrs	r4, r0, #22
@   0x0800a2d6: 080c        lsrs	r4, r1, #32

        thumb_func_start sub_0800A26C
sub_0800A26C: @ 0x0800a26c
        .incbin "frog_us_baserom.gba", 0xa26c, 0x6c
        thumb_func_end sub_0800A26C
