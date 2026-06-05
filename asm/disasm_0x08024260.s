@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08024260, 0x080242ac)  (76 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8024260 --end 0x80242ac --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08024260: b500        push	{lr}
@   0x08024262: b081        sub	sp, #4
@   0x08024264: 490e        ldr	r1, [pc, #56]	@ (0x242a0)
@   0x08024266: 7e88        ldrb	r0, [r1, #26]
@   0x08024268: 2803        cmp	r0, #3
@   0x0802426a: d10e        bne.n	0x2428a
@   0x0802426c: 7ec8        ldrb	r0, [r1, #27]
@   0x0802426e: 2800        cmp	r0, #0
@   0x08024270: d10b        bne.n	0x2428a
@   0x08024272: 2080        movs	r0, #128	@ 0x80
@   0x08024274: 0080        lsls	r0, r0, #2
@   0x08024276: 8e8a        ldrh	r2, [r1, #52]	@ 0x34
@   0x08024278: 4010        ands	r0, r2
@   0x0802427a: 2800        cmp	r0, #0
@   0x0802427c: d105        bne.n	0x2428a
@   0x0802427e: 1c08        adds	r0, r1, #0
@   0x08024280: 2106        movs	r1, #6
@   0x08024282: 2202        movs	r2, #2
@   0x08024284: 2302        movs	r3, #2
@   0x08024286: f7fc        fdc5 	bl	0x20e14
@   0x0802428a: 4906        ldr	r1, [pc, #24]	@ (0x242a4)
@   0x0802428c: 4b06        ldr	r3, [pc, #24]	@ (0x242a8)
@   0x0802428e: 2000        movs	r0, #0
@   0x08024290: 9000        str	r0, [sp, #0]
@   0x08024292: 205f        movs	r0, #95	@ 0x5f
@   0x08024294: 2219        movs	r2, #25
@   0x08024296: f7fd        f93b 	bl	0x21510
@   0x0802429a: b001        add	sp, #4
@   0x0802429c: bc01        pop	{r0}
@   0x0802429e: 4700        bx	r0
@   0x080242a0: 4be8        ldr	r3, [pc, #928]	@ (0x24644)
@   0x080242a2: 0300        lsls	r0, r0, #12
@   0x080242a4: 2210        movs	r2, #16
@   0x080242a6: 0831        lsrs	r1, r6, #32
@   0x080242a8: 6110        str	r0, [r2, #16]
@   0x080242aa: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08024260
sub_08024260: @ 0x08024260
        .incbin "frog_us_baserom.gba", 0x24260, 0x4c
        thumb_func_end sub_08024260
