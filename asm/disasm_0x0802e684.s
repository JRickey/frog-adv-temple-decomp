@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802e684, 0x0802e724)  (160 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802e684 --end 0x802e724 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802e684: b530        push	{r4, r5, lr}
@   0x0802e686: 1c04        adds	r4, r0, #0
@   0x0802e688: 1c0b        adds	r3, r1, #0
@   0x0802e68a: 08e4        lsrs	r4, r4, #3
@   0x0802e68c: 2b01        cmp	r3, #1
@   0x0802e68e: dd01        ble.n	0x2e694
@   0x0802e690: 2b03        cmp	r3, #3
@   0x0802e692: d121        bne.n	0x2e6d8
@   0x0802e694: 4d0d        ldr	r5, [pc, #52]	@ (0x2e6cc)
@   0x0802e696: 6828        ldr	r0, [r5, #0]
@   0x0802e698: 00d9        lsls	r1, r3, #3
@   0x0802e69a: 1840        adds	r0, r0, r1
@   0x0802e69c: 3092        adds	r0, #146	@ 0x92
@   0x0802e69e: 7801        ldrb	r1, [r0, #0]
@   0x0802e6a0: 7004        strb	r4, [r0, #0]
@   0x0802e6a2: 42a1        cmp	r1, r4
@   0x0802e6a4: d035        beq.n	0x2e712
@   0x0802e6a6: 480a        ldr	r0, [pc, #40]	@ (0x2e6d0)
@   0x0802e6a8: 009b        lsls	r3, r3, #2
@   0x0802e6aa: 1818        adds	r0, r3, r0
@   0x0802e6ac: 6802        ldr	r2, [r0, #0]
@   0x0802e6ae: 8811        ldrh	r1, [r2, #0]
@   0x0802e6b0: 4808        ldr	r0, [pc, #32]	@ (0x2e6d4)
@   0x0802e6b2: 4008        ands	r0, r1
@   0x0802e6b4: 0321        lsls	r1, r4, #12
@   0x0802e6b6: 4308        orrs	r0, r1
@   0x0802e6b8: 8010        strh	r0, [r2, #0]
@   0x0802e6ba: 6829        ldr	r1, [r5, #0]
@   0x0802e6bc: 3110        adds	r1, #16
@   0x0802e6be: 18c9        adds	r1, r1, r3
@   0x0802e6c0: 6808        ldr	r0, [r1, #0]
@   0x0802e6c2: 2280        movs	r2, #128	@ 0x80
@   0x0802e6c4: 0092        lsls	r2, r2, #2
@   0x0802e6c6: 4310        orrs	r0, r2
@   0x0802e6c8: 6008        str	r0, [r1, #0]
@   0x0802e6ca: e022        b.n	0x2e712
@   0x0802e6cc: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802e6ce: 0300        lsls	r0, r0, #12
@   0x0802e6d0: da2c        bge.n	0x2e72c
@   0x0802e6d2: 083d        lsrs	r5, r7, #32
@   0x0802e6d4: 0fff        lsrs	r7, r7, #31
@   0x0802e6d6: 0000        movs	r0, r0
@   0x0802e6d8: 2b02        cmp	r3, #2
@   0x0802e6da: d11a        bne.n	0x2e712
@   0x0802e6dc: 4d0e        ldr	r5, [pc, #56]	@ (0x2e718)
@   0x0802e6de: 6828        ldr	r0, [r5, #0]
@   0x0802e6e0: 30a2        adds	r0, #162	@ 0xa2
@   0x0802e6e2: 7801        ldrb	r1, [r0, #0]
@   0x0802e6e4: 7004        strb	r4, [r0, #0]
@   0x0802e6e6: 480d        ldr	r0, [pc, #52]	@ (0x2e71c)
@   0x0802e6e8: 1809        adds	r1, r1, r0
@   0x0802e6ea: 1823        adds	r3, r4, r0
@   0x0802e6ec: 7809        ldrb	r1, [r1, #0]
@   0x0802e6ee: 7818        ldrb	r0, [r3, #0]
@   0x0802e6f0: 4281        cmp	r1, r0
@   0x0802e6f2: d00e        beq.n	0x2e712
@   0x0802e6f4: 480a        ldr	r0, [pc, #40]	@ (0x2e720)
@   0x0802e6f6: 6882        ldr	r2, [r0, #8]
@   0x0802e6f8: 8811        ldrh	r1, [r2, #0]
@   0x0802e6fa: 20ff        movs	r0, #255	@ 0xff
@   0x0802e6fc: 4008        ands	r0, r1
@   0x0802e6fe: 781b        ldrb	r3, [r3, #0]
@   0x0802e700: 0219        lsls	r1, r3, #8
@   0x0802e702: 4308        orrs	r0, r1
@   0x0802e704: 8010        strh	r0, [r2, #0]
@   0x0802e706: 682a        ldr	r2, [r5, #0]
@   0x0802e708: 6990        ldr	r0, [r2, #24]
@   0x0802e70a: 2180        movs	r1, #128	@ 0x80
@   0x0802e70c: 0089        lsls	r1, r1, #2
@   0x0802e70e: 4308        orrs	r0, r1
@   0x0802e710: 6190        str	r0, [r2, #24]
@   0x0802e712: bc30        pop	{r4, r5}
@   0x0802e714: bc01        pop	{r0}
@   0x0802e716: 4700        bx	r0
@   0x0802e718: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802e71a: 0300        lsls	r0, r0, #12
@   0x0802e71c: da3c        bge.n	0x2e798
@   0x0802e71e: 083d        lsrs	r5, r7, #32
@   0x0802e720: da2c        bge.n	0x2e77c
@   0x0802e722: 083d        lsrs	r5, r7, #32

        thumb_func_start sub_0802E684
sub_0802E684: @ 0x0802e684
        .incbin "frog_us_baserom.gba", 0x2e684, 0xa0
        thumb_func_end sub_0802E684
