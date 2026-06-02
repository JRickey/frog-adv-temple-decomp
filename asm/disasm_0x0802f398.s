@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802f398, 0x0802f47c)  (228 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802f398 --end 0x802f47c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802f398: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802f39a: 4647        mov	r7, r8
@   0x0802f39c: b480        push	{r7}
@   0x0802f39e: 1c05        adds	r5, r0, #0
@   0x0802f3a0: 4a19        ldr	r2, [pc, #100]	@ (0x2f408)
@   0x0802f3a2: 6810        ldr	r0, [r2, #0]
@   0x0802f3a4: 30cc        adds	r0, #204	@ 0xcc
@   0x0802f3a6: 6801        ldr	r1, [r0, #0]
@   0x0802f3a8: 00a8        lsls	r0, r5, #2
@   0x0802f3aa: 1840        adds	r0, r0, r1
@   0x0802f3ac: 6800        ldr	r0, [r0, #0]
@   0x0802f3ae: 4684        mov	ip, r0
@   0x0802f3b0: 2800        cmp	r0, #0
@   0x0802f3b2: d077        beq.n	0x2f4a4
@   0x0802f3b4: 8d00        ldrh	r0, [r0, #40]	@ 0x28
@   0x0802f3b6: 0a04        lsrs	r4, r0, #8
@   0x0802f3b8: 2c00        cmp	r4, #0
@   0x0802f3ba: d000        beq.n	0x2f3be
@   0x0802f3bc: 3401        adds	r4, #1
@   0x0802f3be: 4660        mov	r0, ip
@   0x0802f3c0: 302b        adds	r0, #43	@ 0x2b
@   0x0802f3c2: 7800        ldrb	r0, [r0, #0]
@   0x0802f3c4: 4360        muls	r0, r4
@   0x0802f3c6: 0200        lsls	r0, r0, #8
@   0x0802f3c8: 0c04        lsrs	r4, r0, #16
@   0x0802f3ca: 4660        mov	r0, ip
@   0x0802f3cc: 302a        adds	r0, #42	@ 0x2a
@   0x0802f3ce: 7004        strb	r4, [r0, #0]
@   0x0802f3d0: 3012        adds	r0, #18
@   0x0802f3d2: 7803        ldrb	r3, [r0, #0]
@   0x0802f3d4: 6811        ldr	r1, [r2, #0]
@   0x0802f3d6: 31c0        adds	r1, #192	@ 0xc0
@   0x0802f3d8: 00e8        lsls	r0, r5, #3
@   0x0802f3da: 1b40        subs	r0, r0, r5
@   0x0802f3dc: 0080        lsls	r0, r0, #2
@   0x0802f3de: 6809        ldr	r1, [r1, #0]
@   0x0802f3e0: 180f        adds	r7, r1, r0
@   0x0802f3e2: 0619        lsls	r1, r3, #24
@   0x0802f3e4: 0e08        lsrs	r0, r1, #24
@   0x0802f3e6: 283f        cmp	r0, #63	@ 0x3f
@   0x0802f3e8: d816        bhi.n	0x2f418
@   0x0802f3ea: 2040        movs	r0, #64	@ 0x40
@   0x0802f3ec: 1ac0        subs	r0, r0, r3
@   0x0802f3ee: 4907        ldr	r1, [pc, #28]	@ (0x2f40c)
@   0x0802f3f0: 4348        muls	r0, r1
@   0x0802f3f2: 1180        asrs	r0, r0, #6
@   0x0802f3f4: 4906        ldr	r1, [pc, #24]	@ (0x2f410)
@   0x0802f3f6: 1840        adds	r0, r0, r1
@   0x0802f3f8: 4360        muls	r0, r4
@   0x0802f3fa: 1400        asrs	r0, r0, #16
@   0x0802f3fc: 0600        lsls	r0, r0, #24
@   0x0802f3fe: 0e06        lsrs	r6, r0, #24
@   0x0802f400: 4804        ldr	r0, [pc, #16]	@ (0x2f414)
@   0x0802f402: 4358        muls	r0, r3
@   0x0802f404: 1180        asrs	r0, r0, #6
@   0x0802f406: e019        b.n	0x2f43c
@   0x0802f408: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802f40a: 0300        lsls	r0, r0, #12
@   0x0802f40c: 4ac8        ldr	r2, [pc, #800]	@ (0x2f730)
@   0x0802f40e: 0000        movs	r0, r0
@   0x0802f410: b538        push	{r3, r4, r5, lr}
@   0x0802f412: 0000        movs	r0, r0
@   0x0802f414: b818        @ <UNDEFINED> instruction: 0xb818
@   0x0802f416: 0000        movs	r0, r0
@   0x0802f418: 2900        cmp	r1, #0
@   0x0802f41a: db1d        blt.n	0x2f458
@   0x0802f41c: 207f        movs	r0, #127	@ 0x7f
@   0x0802f41e: 1ac0        subs	r0, r0, r3
@   0x0802f420: 490a        ldr	r1, [pc, #40]	@ (0x2f44c)
@   0x0802f422: 4348        muls	r0, r1
@   0x0802f424: 1180        asrs	r0, r0, #6
@   0x0802f426: 4360        muls	r0, r4
@   0x0802f428: 1400        asrs	r0, r0, #16
@   0x0802f42a: 0600        lsls	r0, r0, #24
@   0x0802f42c: 0e06        lsrs	r6, r0, #24
@   0x0802f42e: 1c19        adds	r1, r3, #0
@   0x0802f430: 393f        subs	r1, #63	@ 0x3f
@   0x0802f432: 4807        ldr	r0, [pc, #28]	@ (0x2f450)
@   0x0802f434: 4348        muls	r0, r1
@   0x0802f436: 1180        asrs	r0, r0, #6
@   0x0802f438: 4906        ldr	r1, [pc, #24]	@ (0x2f454)
@   0x0802f43a: 1840        adds	r0, r0, r1
@   0x0802f43c: 4360        muls	r0, r4
@   0x0802f43e: 1400        asrs	r0, r0, #16
@   0x0802f440: 0600        lsls	r0, r0, #24
@   0x0802f442: 0e05        lsrs	r5, r0, #24
@   0x0802f444: 2000        movs	r0, #0
@   0x0802f446: 4680        mov	r8, r0
@   0x0802f448: e00e        b.n	0x2f468
@   0x0802f44a: 0000        movs	r0, r0
@   0x0802f44c: b818        @ <UNDEFINED> instruction: 0xb818
@   0x0802f44e: 0000        movs	r0, r0
@   0x0802f450: 4ac8        ldr	r2, [pc, #800]	@ (0x2f774)
@   0x0802f452: 0000        movs	r0, r0
@   0x0802f454: b538        push	{r3, r4, r5, lr}
@   0x0802f456: 0000        movs	r0, r0
@   0x0802f458: 4808        ldr	r0, [pc, #32]	@ (0x2f47c)
@   0x0802f45a: 4360        muls	r0, r4
@   0x0802f45c: 1400        asrs	r0, r0, #16
@   0x0802f45e: 0600        lsls	r0, r0, #24
@   0x0802f460: 0e05        lsrs	r5, r0, #24
@   0x0802f462: 1c2e        adds	r6, r5, #0
@   0x0802f464: 2101        movs	r1, #1
@   0x0802f466: 4688        mov	r8, r1
@   0x0802f468: 4661        mov	r1, ip
@   0x0802f46a: 6b88        ldr	r0, [r1, #56]	@ 0x38
@   0x0802f46c: 2180        movs	r1, #128	@ 0x80
@   0x0802f46e: 0249        lsls	r1, r1, #9
@   0x0802f470: 4008        ands	r0, r1
@   0x0802f472: 2800        cmp	r0, #0
@   0x0802f474: d004        beq.n	0x2f480
@   0x0802f476: 6810        ldr	r0, [r2, #0]
@   0x0802f478: 30be        adds	r0, #190	@ 0xbe
@   0x0802f47a: e003        b.n	0x2f484

        thumb_func_start sub_0802F398
sub_0802F398: @ 0x0802f398
        .incbin "frog_us_baserom.gba", 0x2f398, 0xe4
        thumb_func_end sub_0802F398
