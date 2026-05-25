@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802f2fc, 0x0802f398)  (156 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802f2fc --end 0x802f398 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802f2fc: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802f2fe: 4647        mov	r7, r8
@   0x0802f300: b480        push	{r7}
@   0x0802f302: 2500        movs	r5, #0
@   0x0802f304: 4911        ldr	r1, [pc, #68]	@ (0x2f34c)
@   0x0802f306: 6808        ldr	r0, [r1, #0]
@   0x0802f308: 468c        mov	ip, r1
@   0x0802f30a: 7800        ldrb	r0, [r0, #0]
@   0x0802f30c: 4285        cmp	r5, r0
@   0x0802f30e: da3e        bge.n	0x2f38e
@   0x0802f310: 2780        movs	r7, #128	@ 0x80
@   0x0802f312: 01bf        lsls	r7, r7, #6
@   0x0802f314: 6808        ldr	r0, [r1, #0]
@   0x0802f316: 30cc        adds	r0, #204	@ 0xcc
@   0x0802f318: 6801        ldr	r1, [r0, #0]
@   0x0802f31a: 00a8        lsls	r0, r5, #2
@   0x0802f31c: 1840        adds	r0, r0, r1
@   0x0802f31e: 6803        ldr	r3, [r0, #0]
@   0x0802f320: 2b00        cmp	r3, #0
@   0x0802f322: d02e        beq.n	0x2f382
@   0x0802f324: 4698        mov	r8, r3
@   0x0802f326: 8a5c        ldrh	r4, [r3, #18]
@   0x0802f328: 2012        movs	r0, #18
@   0x0802f32a: 5e1a        ldrsh	r2, [r3, r0]
@   0x0802f32c: 2a00        cmp	r2, #0
@   0x0802f32e: d028        beq.n	0x2f382
@   0x0802f330: 260a        movs	r6, #10
@   0x0802f332: 5f99        ldrsh	r1, [r3, r6]
@   0x0802f334: 1c10        adds	r0, r2, #0
@   0x0802f336: 1809        adds	r1, r1, r0
@   0x0802f338: 2a00        cmp	r2, #0
@   0x0802f33a: dd09        ble.n	0x2f350
@   0x0802f33c: 7ed8        ldrb	r0, [r3, #27]
@   0x0802f33e: 0202        lsls	r2, r0, #8
@   0x0802f340: 4291        cmp	r1, r2
@   0x0802f342: db11        blt.n	0x2f368
@   0x0802f344: 1a88        subs	r0, r1, r2
@   0x0802f346: 1a11        subs	r1, r2, r0
@   0x0802f348: e008        b.n	0x2f35c
@   0x0802f34a: 0000        movs	r0, r0
@   0x0802f34c: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802f34e: 0300        lsls	r0, r0, #12
@   0x0802f350: 7e9e        ldrb	r6, [r3, #26]
@   0x0802f352: 0232        lsls	r2, r6, #8
@   0x0802f354: 4291        cmp	r1, r2
@   0x0802f356: dc07        bgt.n	0x2f368
@   0x0802f358: 1a50        subs	r0, r2, r1
@   0x0802f35a: 1811        adds	r1, r2, r0
@   0x0802f35c: 6b98        ldr	r0, [r3, #56]	@ 0x38
@   0x0802f35e: 4038        ands	r0, r7
@   0x0802f360: 2800        cmp	r0, #0
@   0x0802f362: d000        beq.n	0x2f366
@   0x0802f364: 4260        negs	r0, r4
@   0x0802f366: 8258        strh	r0, [r3, #18]
@   0x0802f368: 4640        mov	r0, r8
@   0x0802f36a: 8141        strh	r1, [r0, #10]
@   0x0802f36c: 1208        asrs	r0, r1, #8
@   0x0802f36e: 1c1a        adds	r2, r3, #0
@   0x0802f370: 323c        adds	r2, #60	@ 0x3c
@   0x0802f372: 7811        ldrb	r1, [r2, #0]
@   0x0802f374: 4288        cmp	r0, r1
@   0x0802f376: d004        beq.n	0x2f382
@   0x0802f378: 7010        strb	r0, [r2, #0]
@   0x0802f37a: 6b98        ldr	r0, [r3, #56]	@ 0x38
@   0x0802f37c: 2180        movs	r1, #128	@ 0x80
@   0x0802f37e: 4308        orrs	r0, r1
@   0x0802f380: 6398        str	r0, [r3, #56]	@ 0x38
@   0x0802f382: 3501        adds	r5, #1
@   0x0802f384: 4661        mov	r1, ip
@   0x0802f386: 6808        ldr	r0, [r1, #0]
@   0x0802f388: 7800        ldrb	r0, [r0, #0]
@   0x0802f38a: 4285        cmp	r5, r0
@   0x0802f38c: dbc2        blt.n	0x2f314
@   0x0802f38e: bc08        pop	{r3}
@   0x0802f390: 4698        mov	r8, r3
@   0x0802f392: bcf0        pop	{r4, r5, r6, r7}
@   0x0802f394: bc01        pop	{r0}
@   0x0802f396: 4700        bx	r0

        thumb_func_start sub_0802F2FC
sub_0802F2FC: @ 0x0802f2fc
        .incbin "frog_us_baserom.gba", 0x2f2fc, 0x9c
        thumb_func_end sub_0802F2FC
