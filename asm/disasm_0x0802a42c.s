@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802a42c, 0x0802a4a4)  (120 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802a42c --end 0x802a4a4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802a42c: b510        push	{r4, lr}
@   0x0802a42e: b087        sub	sp, #28
@   0x0802a430: a903        add	r1, sp, #12
@   0x0802a432: 2400        movs	r4, #0
@   0x0802a434: 2001        movs	r0, #1
@   0x0802a436: 8008        strh	r0, [r1, #0]
@   0x0802a438: 1c08        adds	r0, r1, #0
@   0x0802a43a: 8044        strh	r4, [r0, #2]
@   0x0802a43c: 8084        strh	r4, [r0, #4]
@   0x0802a43e: 2008        movs	r0, #8
@   0x0802a440: f7d6        f990 	bl	0x764
@   0x0802a444: aa03        add	r2, sp, #12
@   0x0802a446: 3001        adds	r0, #1
@   0x0802a448: 0041        lsls	r1, r0, #1
@   0x0802a44a: 1809        adds	r1, r1, r0
@   0x0802a44c: 00c9        lsls	r1, r1, #3
@   0x0802a44e: 310b        adds	r1, #11
@   0x0802a450: 8111        strh	r1, [r2, #8]
@   0x0802a452: 2005        movs	r0, #5
@   0x0802a454: f7d6        f986 	bl	0x764
@   0x0802a458: aa03        add	r2, sp, #12
@   0x0802a45a: 3002        adds	r0, #2
@   0x0802a45c: 0041        lsls	r1, r0, #1
@   0x0802a45e: 1809        adds	r1, r1, r0
@   0x0802a460: 00c9        lsls	r1, r1, #3
@   0x0802a462: 310b        adds	r1, #11
@   0x0802a464: 8151        strh	r1, [r2, #10]
@   0x0802a466: 1c11        adds	r1, r2, #0
@   0x0802a468: 480b        ldr	r0, [pc, #44]	@ (0x2a498)
@   0x0802a46a: 8188        strh	r0, [r1, #12]
@   0x0802a46c: 480b        ldr	r0, [pc, #44]	@ (0x2a49c)
@   0x0802a46e: 9000        str	r0, [sp, #0]
@   0x0802a470: 2005        movs	r0, #5
@   0x0802a472: 9001        str	r0, [sp, #4]
@   0x0802a474: 9402        str	r4, [sp, #8]
@   0x0802a476: 2010        movs	r0, #16
@   0x0802a478: 2210        movs	r2, #16
@   0x0802a47a: 230c        movs	r3, #12
@   0x0802a47c: f7f6        fe60 	bl	0x21140
@   0x0802a480: f7d6        fa3e 	bl	0x900
@   0x0802a484: 4906        ldr	r1, [pc, #24]	@ (0x2a4a0)
@   0x0802a486: 22eb        movs	r2, #235	@ 0xeb
@   0x0802a488: 0092        lsls	r2, r2, #2
@   0x0802a48a: 1889        adds	r1, r1, r2
@   0x0802a48c: 6008        str	r0, [r1, #0]
@   0x0802a48e: b007        add	sp, #28
@   0x0802a490: bc10        pop	{r4}
@   0x0802a492: bc01        pop	{r0}
@   0x0802a494: 4700        bx	r0
@   0x0802a496: 0000        movs	r0, r0
@   0x0802a498: 0303        lsls	r3, r0, #12
@   0x0802a49a: 0000        movs	r0, r0
@   0x0802a49c: 0151        lsls	r1, r2, #5
@   0x0802a49e: 0000        movs	r0, r0
@   0x0802a4a0: 3720        adds	r7, #32
@   0x0802a4a2: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0802A42C
sub_0802A42C: @ 0x0802a42c
        .incbin "frog_us_baserom.gba", 0x2a42c, 0x78
        thumb_func_end sub_0802A42C
