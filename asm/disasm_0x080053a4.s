@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080053a4, 0x080053f4)  (80 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80053a4 --end 0x80053f4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080053a4: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080053a6: 1c04        adds	r4, r0, #0
@   0x080053a8: 1c0d        adds	r5, r1, #0
@   0x080053aa: 1c16        adds	r6, r2, #0
@   0x080053ac: 1c1f        adds	r7, r3, #0
@   0x080053ae: f004        fc31 	bl	0x9c14
@   0x080053b2: 2800        cmp	r0, #0
@   0x080053b4: d101        bne.n	0x53ba
@   0x080053b6: 2008        movs	r0, #8
@   0x080053b8: 7020        strb	r0, [r4, #0]
@   0x080053ba: 490d        ldr	r1, [pc, #52]	@ (0x53f0)
@   0x080053bc: 2000        movs	r0, #0
@   0x080053be: 6108        str	r0, [r1, #16]
@   0x080053c0: 1c0a        adds	r2, r1, #0
@   0x080053c2: 322a        adds	r2, #42	@ 0x2a
@   0x080053c4: 7010        strb	r0, [r2, #0]
@   0x080053c6: 3201        adds	r2, #1
@   0x080053c8: 7010        strb	r0, [r2, #0]
@   0x080053ca: 1c08        adds	r0, r1, #0
@   0x080053cc: 3033        adds	r0, #51	@ 0x33
@   0x080053ce: 7800        ldrb	r0, [r0, #0]
@   0x080053d0: 2801        cmp	r0, #1
@   0x080053d2: d109        bne.n	0x53e8
@   0x080053d4: 1c28        adds	r0, r5, #0
@   0x080053d6: 1c31        adds	r1, r6, #0
@   0x080053d8: 221d        movs	r2, #29
@   0x080053da: f006        fd1d 	bl	0xbe18
@   0x080053de: 1c38        adds	r0, r7, #0
@   0x080053e0: 9905        ldr	r1, [sp, #20]
@   0x080053e2: 221e        movs	r2, #30
@   0x080053e4: f006        fd18 	bl	0xbe18
@   0x080053e8: bcf0        pop	{r4, r5, r6, r7}
@   0x080053ea: bc01        pop	{r0}
@   0x080053ec: 4700        bx	r0
@   0x080053ee: 0000        movs	r0, r0
@   0x080053f0: 6110        str	r0, [r2, #16]
@   0x080053f2: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080053A4
sub_080053A4: @ 0x080053a4
        .incbin "frog_us_baserom.gba", 0x53a4, 0x50
        thumb_func_end sub_080053A4
