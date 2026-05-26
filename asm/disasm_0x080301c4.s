@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080301c4, 0x08030264)  (160 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80301c4 --end 0x8030264 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080301c4: b530        push	{r4, r5, lr}
@   0x080301c6: 1c04        adds	r4, r0, #0
@   0x080301c8: 0609        lsls	r1, r1, #24
@   0x080301ca: 0e0b        lsrs	r3, r1, #24
@   0x080301cc: 1c19        adds	r1, r3, #0
@   0x080301ce: 0612        lsls	r2, r2, #24
@   0x080301d0: 0e15        lsrs	r5, r2, #24
@   0x080301d2: 7aa0        ldrb	r0, [r4, #10]
@   0x080301d4: 2d00        cmp	r5, #0
@   0x080301d6: d116        bne.n	0x30206
@   0x080301d8: 4283        cmp	r3, r0
@   0x080301da: d011        beq.n	0x30200
@   0x080301dc: 8922        ldrh	r2, [r4, #8]
@   0x080301de: 4298        cmp	r0, r3
@   0x080301e0: d204        bcs.n	0x301ec
@   0x080301e2: 4901        ldr	r1, [pc, #4]	@ (0x301e8)
@   0x080301e4: 1a18        subs	r0, r3, r0
@   0x080301e6: e003        b.n	0x301f0
@   0x080301e8: dadc        bge.n	0x301a4
@   0x080301ea: 083d        lsrs	r5, r7, #32
@   0x080301ec: 4903        ldr	r1, [pc, #12]	@ (0x301fc)
@   0x080301ee: 1ac0        subs	r0, r0, r3
@   0x080301f0: 0040        lsls	r0, r0, #1
@   0x080301f2: 1840        adds	r0, r0, r1
@   0x080301f4: 8800        ldrh	r0, [r0, #0]
@   0x080301f6: 1c03        adds	r3, r0, #0
@   0x080301f8: 4353        muls	r3, r2
@   0x080301fa: e023        b.n	0x30244
@   0x080301fc: dbdc        blt.n	0x301b8
@   0x080301fe: 083d        lsrs	r5, r7, #32
@   0x08030200: 8924        ldrh	r4, [r4, #8]
@   0x08030202: 0323        lsls	r3, r4, #12
@   0x08030204: e01e        b.n	0x30244
@   0x08030206: 4283        cmp	r3, r0
@   0x08030208: d30c        bcc.n	0x30224
@   0x0803020a: 4a05        ldr	r2, [pc, #20]	@ (0x30220)
@   0x0803020c: 1a19        subs	r1, r3, r0
@   0x0803020e: 0048        lsls	r0, r1, #1
@   0x08030210: 1880        adds	r0, r0, r2
@   0x08030212: 8803        ldrh	r3, [r0, #0]
@   0x08030214: 3101        adds	r1, #1
@   0x08030216: 0049        lsls	r1, r1, #1
@   0x08030218: 1889        adds	r1, r1, r2
@   0x0803021a: 8809        ldrh	r1, [r1, #0]
@   0x0803021c: 1ac8        subs	r0, r1, r3
@   0x0803021e: e00b        b.n	0x30238
@   0x08030220: dadc        bge.n	0x301dc
@   0x08030222: 083d        lsrs	r5, r7, #32
@   0x08030224: 4a0d        ldr	r2, [pc, #52]	@ (0x3025c)
@   0x08030226: 1a41        subs	r1, r0, r1
@   0x08030228: 0048        lsls	r0, r1, #1
@   0x0803022a: 1880        adds	r0, r0, r2
@   0x0803022c: 8803        ldrh	r3, [r0, #0]
@   0x0803022e: 3101        adds	r1, #1
@   0x08030230: 0049        lsls	r1, r1, #1
@   0x08030232: 1889        adds	r1, r1, r2
@   0x08030234: 8809        ldrh	r1, [r1, #0]
@   0x08030236: 1a58        subs	r0, r3, r1
@   0x08030238: 4368        muls	r0, r5
@   0x0803023a: 0a00        lsrs	r0, r0, #8
@   0x0803023c: 1818        adds	r0, r3, r0
@   0x0803023e: 8924        ldrh	r4, [r4, #8]
@   0x08030240: 1c23        adds	r3, r4, #0
@   0x08030242: 4343        muls	r3, r0
@   0x08030244: 4806        ldr	r0, [pc, #24]	@ (0x30260)
@   0x08030246: 6800        ldr	r0, [r0, #0]
@   0x08030248: 8841        ldrh	r1, [r0, #2]
@   0x0803024a: 1c18        adds	r0, r3, #0
@   0x0803024c: f003        fe4a 	bl	0x33ee4
@   0x08030250: 1c03        adds	r3, r0, #0
@   0x08030252: 0418        lsls	r0, r3, #16
@   0x08030254: 0c00        lsrs	r0, r0, #16
@   0x08030256: bc30        pop	{r4, r5}
@   0x08030258: bc02        pop	{r1}
@   0x0803025a: 4708        bx	r1
@   0x0803025c: dbdc        blt.n	0x30218
@   0x0803025e: 083d        lsrs	r5, r7, #32
@   0x08030260: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08030262: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080301C4
sub_080301C4: @ 0x080301c4
        .incbin "frog_us_baserom.gba", 0x301c4, 0xa0
        thumb_func_end sub_080301C4
