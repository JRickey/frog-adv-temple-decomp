@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08009140, 0x08009188)  (72 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8009140 --end 0x8009188 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08009140: b500        push	{lr}
@   0x08009142: 4806        ldr	r0, [pc, #24]	@ (0x915c)
@   0x08009144: 1c02        adds	r2, r0, #0
@   0x08009146: 7e90        ldrb	r0, [r2, #26]
@   0x08009148: 2823        cmp	r0, #35	@ 0x23
@   0x0800914a: d115        bne.n	0x9178
@   0x0800914c: 8e91        ldrh	r1, [r2, #52]	@ 0x34
@   0x0800914e: 2002        movs	r0, #2
@   0x08009150: 4008        ands	r0, r1
@   0x08009152: 2800        cmp	r0, #0
@   0x08009154: d006        beq.n	0x9164
@   0x08009156: 4802        ldr	r0, [pc, #8]	@ (0x9160)
@   0x08009158: 4008        ands	r0, r1
@   0x0800915a: e00c        b.n	0x9176
@   0x0800915c: 3720        adds	r7, #32
@   0x0800915e: 0300        lsls	r0, r0, #12
@   0x08009160: 7fff        ldrb	r7, [r7, #31]
@   0x08009162: 0000        movs	r0, r0
@   0x08009164: 2080        movs	r0, #128	@ 0x80
@   0x08009166: 0200        lsls	r0, r0, #8
@   0x08009168: 4008        ands	r0, r1
@   0x0800916a: 2800        cmp	r0, #0
@   0x0800916c: d004        beq.n	0x9178
@   0x0800916e: 4805        ldr	r0, [pc, #20]	@ (0x9184)
@   0x08009170: 4008        ands	r0, r1
@   0x08009172: 2102        movs	r1, #2
@   0x08009174: 4308        orrs	r0, r1
@   0x08009176: 8690        strh	r0, [r2, #52]	@ 0x34
@   0x08009178: 1c10        adds	r0, r2, #0
@   0x0800917a: f7fc        fc23 	bl	0x59c4
@   0x0800917e: bc01        pop	{r0}
@   0x08009180: 4700        bx	r0
@   0x08009182: 0000        movs	r0, r0
@   0x08009184: 7fff        ldrb	r7, [r7, #31]

        thumb_func_start sub_08009140
sub_08009140: @ 0x08009140
        .incbin "frog_us_baserom.gba", 0x9140, 0x48
        thumb_func_end sub_08009140
