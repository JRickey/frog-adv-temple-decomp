@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802e5d8, 0x0802e684)  (172 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802e5d8 --end 0x802e684 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802e5d8: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802e5da: 1c15        adds	r5, r2, #0
@   0x0802e5dc: 0400        lsls	r0, r0, #16
@   0x0802e5de: 0c03        lsrs	r3, r0, #16
@   0x0802e5e0: 0409        lsls	r1, r1, #16
@   0x0802e5e2: 0c09        lsrs	r1, r1, #16
@   0x0802e5e4: 2d02        cmp	r5, #2
@   0x0802e5e6: dc47        bgt.n	0x2e678
@   0x0802e5e8: 0418        lsls	r0, r3, #16
@   0x0802e5ea: 4c07        ldr	r4, [pc, #28]	@ (0x2e608)
@   0x0802e5ec: 0409        lsls	r1, r1, #16
@   0x0802e5ee: 4f07        ldr	r7, [pc, #28]	@ (0x2e60c)
@   0x0802e5f0: 006e        lsls	r6, r5, #1
@   0x0802e5f2: 2800        cmp	r0, #0
@   0x0802e5f4: da0f        bge.n	0x2e616
@   0x0802e5f6: 22a8        movs	r2, #168	@ 0xa8
@   0x0802e5f8: 03d2        lsls	r2, r2, #15
@   0x0802e5fa: 1880        adds	r0, r0, r2
@   0x0802e5fc: 0c03        lsrs	r3, r0, #16
@   0x0802e5fe: 0418        lsls	r0, r3, #16
@   0x0802e600: 2800        cmp	r0, #0
@   0x0802e602: dbf8        blt.n	0x2e5f6
@   0x0802e604: e007        b.n	0x2e616
@   0x0802e606: 0000        movs	r0, r0
@   0x0802e608: 8de2        ldrh	r2, [r4, #46]	@ 0x2e
@   0x0802e60a: 082f        lsrs	r7, r5, #32
@   0x0802e60c: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802e60e: 0300        lsls	r0, r0, #12
@   0x0802e610: 4b07        ldr	r3, [pc, #28]	@ (0x2e630)
@   0x0802e612: 18d0        adds	r0, r2, r3
@   0x0802e614: 0c03        lsrs	r3, r0, #16
@   0x0802e616: 041a        lsls	r2, r3, #16
@   0x0802e618: 1410        asrs	r0, r2, #16
@   0x0802e61a: 2853        cmp	r0, #83	@ 0x53
@   0x0802e61c: dcf8        bgt.n	0x2e610
@   0x0802e61e: 140a        asrs	r2, r1, #16
@   0x0802e620: 2a00        cmp	r2, #0
@   0x0802e622: d107        bne.n	0x2e634
@   0x0802e624: 0418        lsls	r0, r3, #16
@   0x0802e626: 13c0        asrs	r0, r0, #15
@   0x0802e628: 1900        adds	r0, r0, r4
@   0x0802e62a: 8800        ldrh	r0, [r0, #0]
@   0x0802e62c: 1c04        adds	r4, r0, #0
@   0x0802e62e: e012        b.n	0x2e656
@   0x0802e630: 0000        movs	r0, r0
@   0x0802e632: ffac        0419 	vsri.32	d0, d9, #20
@   0x0802e636: 13c9        asrs	r1, r1, #15
@   0x0802e638: 1909        adds	r1, r1, r4
@   0x0802e63a: 8808        ldrh	r0, [r1, #0]
@   0x0802e63c: 1c04        adds	r4, r0, #0
@   0x0802e63e: 8848        ldrh	r0, [r1, #2]
@   0x0802e640: 8809        ldrh	r1, [r1, #0]
@   0x0802e642: 1a40        subs	r0, r0, r1
@   0x0802e644: 0400        lsls	r0, r0, #16
@   0x0802e646: 1400        asrs	r0, r0, #16
@   0x0802e648: 4350        muls	r0, r2
@   0x0802e64a: 21ff        movs	r1, #255	@ 0xff
@   0x0802e64c: f005        fb62 	bl	0x33d14
@   0x0802e650: 1820        adds	r0, r4, r0
@   0x0802e652: 0400        lsls	r0, r0, #16
@   0x0802e654: 0c04        lsrs	r4, r0, #16
@   0x0802e656: 6838        ldr	r0, [r7, #0]
@   0x0802e658: 30b4        adds	r0, #180	@ 0xb4
@   0x0802e65a: 1980        adds	r0, r0, r6
@   0x0802e65c: 8801        ldrh	r1, [r0, #0]
@   0x0802e65e: 42a1        cmp	r1, r4
@   0x0802e660: d00a        beq.n	0x2e678
@   0x0802e662: 8004        strh	r4, [r0, #0]
@   0x0802e664: 4906        ldr	r1, [pc, #24]	@ (0x2e680)
@   0x0802e666: 00a8        lsls	r0, r5, #2
@   0x0802e668: 1840        adds	r0, r0, r1
@   0x0802e66a: 6802        ldr	r2, [r0, #0]
@   0x0802e66c: 8811        ldrh	r1, [r2, #0]
@   0x0802e66e: 2080        movs	r0, #128	@ 0x80
@   0x0802e670: 01c0        lsls	r0, r0, #7
@   0x0802e672: 4008        ands	r0, r1
@   0x0802e674: 4304        orrs	r4, r0
@   0x0802e676: 8014        strh	r4, [r2, #0]
@   0x0802e678: bcf0        pop	{r4, r5, r6, r7}
@   0x0802e67a: bc01        pop	{r0}
@   0x0802e67c: 4700        bx	r0
@   0x0802e67e: 0000        movs	r0, r0
@   0x0802e680: da1c        bge.n	0x2e6bc
@   0x0802e682: 083d        lsrs	r5, r7, #32

        thumb_func_start sub_0802E5D8
sub_0802E5D8: @ 0x0802e5d8
        .incbin "frog_us_baserom.gba", 0x2e5d8, 0xac
        thumb_func_end sub_0802E5D8
