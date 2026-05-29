@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080018a8, 0x080018f8)  (80 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80018a8 --end 0x80018f8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080018a8: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080018aa: 1c05        adds	r5, r0, #0
@   0x080018ac: 1c0e        adds	r6, r1, #0
@   0x080018ae: 2204        movs	r2, #4
@   0x080018b0: f00a        f832 	bl	0xb918
@   0x080018b4: 490e        ldr	r1, [pc, #56]	@ (0x18f0)
@   0x080018b6: 2004        movs	r0, #4
@   0x080018b8: 8e89        ldrh	r1, [r1, #52]	@ 0x34
@   0x080018ba: 4008        ands	r0, r1
@   0x080018bc: 2800        cmp	r0, #0
@   0x080018be: d114        bne.n	0x18ea
@   0x080018c0: 4c0c        ldr	r4, [pc, #48]	@ (0x18f4)
@   0x080018c2: 7e20        ldrb	r0, [r4, #24]
@   0x080018c4: 7e61        ldrb	r1, [r4, #25]
@   0x080018c6: 2308        movs	r3, #8
@   0x080018c8: 5ee2        ldrsh	r2, [r4, r3]
@   0x080018ca: 270a        movs	r7, #10
@   0x080018cc: 5fe3        ldrsh	r3, [r4, r7]
@   0x080018ce: f00b        fa5b 	bl	0xcd88
@   0x080018d2: 0600        lsls	r0, r0, #24
@   0x080018d4: 0e03        lsrs	r3, r0, #24
@   0x080018d6: 2010        movs	r0, #16
@   0x080018d8: 8a24        ldrh	r4, [r4, #16]
@   0x080018da: 4020        ands	r0, r4
@   0x080018dc: 2800        cmp	r0, #0
@   0x080018de: d004        beq.n	0x18ea
@   0x080018e0: 1c28        adds	r0, r5, #0
@   0x080018e2: 1c31        adds	r1, r6, #0
@   0x080018e4: 2204        movs	r2, #4
@   0x080018e6: f009        ffdf 	bl	0xb8a8
@   0x080018ea: bcf0        pop	{r4, r5, r6, r7}
@   0x080018ec: bc01        pop	{r0}
@   0x080018ee: 4700        bx	r0
@   0x080018f0: 3720        adds	r7, #32
@   0x080018f2: 0300        lsls	r0, r0, #12
@   0x080018f4: 35e0        adds	r5, #224	@ 0xe0
@   0x080018f6: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080018A8
sub_080018A8: @ 0x080018a8
        .incbin "frog_us_baserom.gba", 0x18a8, 0x50
        thumb_func_end sub_080018A8
