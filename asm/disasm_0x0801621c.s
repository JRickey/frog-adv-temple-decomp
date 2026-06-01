@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801621c, 0x0801629c)  (128 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801621c --end 0x801629c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801621c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801621e: 1c14        adds	r4, r2, #0
@   0x08016220: 1c1d        adds	r5, r3, #0
@   0x08016222: 0400        lsls	r0, r0, #16
@   0x08016224: 0c03        lsrs	r3, r0, #16
@   0x08016226: 0409        lsls	r1, r1, #16
@   0x08016228: 0c0a        lsrs	r2, r1, #16
@   0x0801622a: 2080        movs	r0, #128	@ 0x80
@   0x0801622c: 04c0        lsls	r0, r0, #19
@   0x0801622e: 8801        ldrh	r1, [r0, #0]
@   0x08016230: 2010        movs	r0, #16
@   0x08016232: 4008        ands	r0, r1
@   0x08016234: 2800        cmp	r0, #0
@   0x08016236: d006        beq.n	0x16246
@   0x08016238: 0110        lsls	r0, r2, #4
@   0x0801623a: 1a80        subs	r0, r0, r2
@   0x0801623c: 0100        lsls	r0, r0, #4
@   0x0801623e: 21c0        movs	r1, #192	@ 0xc0
@   0x08016240: 04c9        lsls	r1, r1, #19
@   0x08016242: 1840        adds	r0, r0, r1
@   0x08016244: e004        b.n	0x16250
@   0x08016246: 0110        lsls	r0, r2, #4
@   0x08016248: 1a80        subs	r0, r0, r2
@   0x0801624a: 0100        lsls	r0, r0, #4
@   0x0801624c: 4f11        ldr	r7, [pc, #68]	@ (0x16294)
@   0x0801624e: 19c0        adds	r0, r0, r7
@   0x08016250: 181a        adds	r2, r3, r0
@   0x08016252: 7869        ldrb	r1, [r5, #1]
@   0x08016254: 0108        lsls	r0, r1, #4
@   0x08016256: 1a40        subs	r0, r0, r1
@   0x08016258: 0100        lsls	r0, r0, #4
@   0x0801625a: 1820        adds	r0, r4, r0
@   0x0801625c: 782f        ldrb	r7, [r5, #0]
@   0x0801625e: 183b        adds	r3, r7, r0
@   0x08016260: 2400        movs	r4, #0
@   0x08016262: 78e8        ldrb	r0, [r5, #3]
@   0x08016264: 4284        cmp	r4, r0
@   0x08016266: d211        bcs.n	0x1628c
@   0x08016268: 490b        ldr	r1, [pc, #44]	@ (0x16298)
@   0x0801626a: 2680        movs	r6, #128	@ 0x80
@   0x0801626c: 0636        lsls	r6, r6, #24
@   0x0801626e: 600b        str	r3, [r1, #0]
@   0x08016270: 604a        str	r2, [r1, #4]
@   0x08016272: 78af        ldrb	r7, [r5, #2]
@   0x08016274: 0878        lsrs	r0, r7, #1
@   0x08016276: 4330        orrs	r0, r6
@   0x08016278: 6088        str	r0, [r1, #8]
@   0x0801627a: 6888        ldr	r0, [r1, #8]
@   0x0801627c: 33f0        adds	r3, #240	@ 0xf0
@   0x0801627e: 32f0        adds	r2, #240	@ 0xf0
@   0x08016280: 1c60        adds	r0, r4, #1
@   0x08016282: 0400        lsls	r0, r0, #16
@   0x08016284: 0c04        lsrs	r4, r0, #16
@   0x08016286: 78e8        ldrb	r0, [r5, #3]
@   0x08016288: 4284        cmp	r4, r0
@   0x0801628a: d3f0        bcc.n	0x1626e
@   0x0801628c: bcf0        pop	{r4, r5, r6, r7}
@   0x0801628e: bc01        pop	{r0}
@   0x08016290: 4700        bx	r0
@   0x08016292: 0000        movs	r0, r0
@   0x08016294: a000        add	r0, pc, #0	@ (adr r0, 0x16298)
@   0x08016296: 0600        lsls	r0, r0, #24
@   0x08016298: 00d4        lsls	r4, r2, #3
@   0x0801629a: 0400        lsls	r0, r0, #16

        thumb_func_start sub_0801621C
sub_0801621C: @ 0x0801621c
        .incbin "frog_us_baserom.gba", 0x1621c, 0x80
        thumb_func_end sub_0801621C
