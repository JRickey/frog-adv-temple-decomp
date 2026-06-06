@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080318a8, 0x080318f0)  (72 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80318a8 --end 0x80318f0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080318a8: b510        push	{r4, lr}
@   0x080318aa: 1c02        adds	r2, r0, #0
@   0x080318ac: 1c0c        adds	r4, r1, #0
@   0x080318ae: 6820        ldr	r0, [r4, #0]
@   0x080318b0: 2a01        cmp	r2, #1
@   0x080318b2: dc14        bgt.n	0x318de
@   0x080318b4: 7840        ldrb	r0, [r0, #1]
@   0x080318b6: 28ff        cmp	r0, #255	@ 0xff
@   0x080318b8: d10e        bne.n	0x318d8
@   0x080318ba: 480c        ldr	r0, [pc, #48]	@ (0x318ec)
@   0x080318bc: 6800        ldr	r0, [r0, #0]
@   0x080318be: 218c        movs	r1, #140	@ 0x8c
@   0x080318c0: 0049        lsls	r1, r1, #1
@   0x080318c2: 1840        adds	r0, r0, r1
@   0x080318c4: 6800        ldr	r0, [r0, #0]
@   0x080318c6: 3908        subs	r1, #8
@   0x080318c8: 1840        adds	r0, r0, r1
@   0x080318ca: 6801        ldr	r1, [r0, #0]
@   0x080318cc: 0050        lsls	r0, r2, #1
@   0x080318ce: 1880        adds	r0, r0, r2
@   0x080318d0: 0080        lsls	r0, r0, #2
@   0x080318d2: 1840        adds	r0, r0, r1
@   0x080318d4: 7980        ldrb	r0, [r0, #6]
@   0x080318d6: 0940        lsrs	r0, r0, #5
@   0x080318d8: 1c11        adds	r1, r2, #0
@   0x080318da: f7fd        ffc9 	bl	0x2f870
@   0x080318de: 6820        ldr	r0, [r4, #0]
@   0x080318e0: 3002        adds	r0, #2
@   0x080318e2: 6020        str	r0, [r4, #0]
@   0x080318e4: 2001        movs	r0, #1
@   0x080318e6: bc10        pop	{r4}
@   0x080318e8: bc02        pop	{r1}
@   0x080318ea: 4708        bx	r1
@   0x080318ec: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x080318ee: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080318A8
sub_080318A8: @ 0x080318a8
        .incbin "frog_us_baserom.gba", 0x318a8, 0x48
        thumb_func_end sub_080318A8
