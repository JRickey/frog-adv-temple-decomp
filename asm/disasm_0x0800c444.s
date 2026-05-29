@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800c444, 0x0800c4a0)  (92 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800c444 --end 0x800c4a0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800c444: b510        push	{r4, lr}
@   0x0800c446: b081        sub	sp, #4
@   0x0800c448: 0600        lsls	r0, r0, #24
@   0x0800c44a: 0e00        lsrs	r0, r0, #24
@   0x0800c44c: 2814        cmp	r0, #20
@   0x0800c44e: d11e        bne.n	0xc48e
@   0x0800c450: 4c11        ldr	r4, [pc, #68]	@ (0xc498)
@   0x0800c452: 1c20        adds	r0, r4, #0
@   0x0800c454: 2105        movs	r1, #5
@   0x0800c456: 2200        movs	r2, #0
@   0x0800c458: f7fa        f9a0 	bl	0x679c
@   0x0800c45c: 0600        lsls	r0, r0, #24
@   0x0800c45e: 2800        cmp	r0, #0
@   0x0800c460: d115        bne.n	0xc48e
@   0x0800c462: 1c20        adds	r0, r4, #0
@   0x0800c464: 2105        movs	r1, #5
@   0x0800c466: 2200        movs	r2, #0
@   0x0800c468: f7fa        f8ca 	bl	0x6600
@   0x0800c46c: 4c0b        ldr	r4, [pc, #44]	@ (0xc49c)
@   0x0800c46e: 7e20        ldrb	r0, [r4, #24]
@   0x0800c470: 7e61        ldrb	r1, [r4, #25]
@   0x0800c472: 220d        movs	r2, #13
@   0x0800c474: 9200        str	r2, [sp, #0]
@   0x0800c476: 2207        movs	r2, #7
@   0x0800c478: 2357        movs	r3, #87	@ 0x57
@   0x0800c47a: f000        fbb5 	bl	0xcbe8
@   0x0800c47e: 7e20        ldrb	r0, [r4, #24]
@   0x0800c480: 7e61        ldrb	r1, [r4, #25]
@   0x0800c482: 220e        movs	r2, #14
@   0x0800c484: 9200        str	r2, [sp, #0]
@   0x0800c486: 2208        movs	r2, #8
@   0x0800c488: 2357        movs	r3, #87	@ 0x57
@   0x0800c48a: f000        fbad 	bl	0xcbe8
@   0x0800c48e: b001        add	sp, #4
@   0x0800c490: bc10        pop	{r4}
@   0x0800c492: bc01        pop	{r0}
@   0x0800c494: 4700        bx	r0
@   0x0800c496: 0000        movs	r0, r0
@   0x0800c498: 6110        str	r0, [r2, #16]
@   0x0800c49a: 0300        lsls	r0, r0, #12
@   0x0800c49c: 35e0        adds	r5, #224	@ 0xe0
@   0x0800c49e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0800C444
sub_0800C444: @ 0x0800c444
        .incbin "frog_us_baserom.gba", 0xc444, 0x5c
        thumb_func_end sub_0800C444
