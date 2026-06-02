@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801a6d4, 0x0801a774)  (160 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801a6d4 --end 0x801a774 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801a6d4: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801a6d6: 464f        mov	r7, r9
@   0x0801a6d8: 4646        mov	r6, r8
@   0x0801a6da: b4c0        push	{r6, r7}
@   0x0801a6dc: 0600        lsls	r0, r0, #24
@   0x0801a6de: 0e00        lsrs	r0, r0, #24
@   0x0801a6e0: 4680        mov	r8, r0
@   0x0801a6e2: 2700        movs	r7, #0
@   0x0801a6e4: 4547        cmp	r7, r8
@   0x0801a6e6: d23a        bcs.n	0x1a75e
@   0x0801a6e8: 4820        ldr	r0, [pc, #128]	@ (0x1a76c)
@   0x0801a6ea: 4684        mov	ip, r0
@   0x0801a6ec: 4e20        ldr	r6, [pc, #128]	@ (0x1a770)
@   0x0801a6ee: 2100        movs	r1, #0
@   0x0801a6f0: 4689        mov	r9, r1
@   0x0801a6f2: 017a        lsls	r2, r7, #5
@   0x0801a6f4: 4660        mov	r0, ip
@   0x0801a6f6: 300c        adds	r0, #12
@   0x0801a6f8: 1814        adds	r4, r2, r0
@   0x0801a6fa: 2102        movs	r1, #2
@   0x0801a6fc: 5e70        ldrsh	r0, [r6, r1]
@   0x0801a6fe: 3878        subs	r0, #120	@ 0x78
@   0x0801a700: 6020        str	r0, [r4, #0]
@   0x0801a702: 4660        mov	r0, ip
@   0x0801a704: 3010        adds	r0, #16
@   0x0801a706: 1815        adds	r5, r2, r0
@   0x0801a708: 2104        movs	r1, #4
@   0x0801a70a: 5e70        ldrsh	r0, [r6, r1]
@   0x0801a70c: 3868        subs	r0, #104	@ 0x68
@   0x0801a70e: 6028        str	r0, [r5, #0]
@   0x0801a710: 2102        movs	r1, #2
@   0x0801a712: 5e70        ldrsh	r0, [r6, r1]
@   0x0801a714: 2878        cmp	r0, #120	@ 0x78
@   0x0801a716: dc01        bgt.n	0x1a71c
@   0x0801a718: 4648        mov	r0, r9
@   0x0801a71a: 6020        str	r0, [r4, #0]
@   0x0801a71c: 2104        movs	r1, #4
@   0x0801a71e: 5e70        ldrsh	r0, [r6, r1]
@   0x0801a720: 2868        cmp	r0, #104	@ 0x68
@   0x0801a722: dc01        bgt.n	0x1a728
@   0x0801a724: 4648        mov	r0, r9
@   0x0801a726: 6028        str	r0, [r5, #0]
@   0x0801a728: 2002        movs	r0, #2
@   0x0801a72a: 5e31        ldrsh	r1, [r6, r0]
@   0x0801a72c: 4660        mov	r0, ip
@   0x0801a72e: 1813        adds	r3, r2, r0
@   0x0801a730: 8b58        ldrh	r0, [r3, #26]
@   0x0801a732: 00c2        lsls	r2, r0, #3
@   0x0801a734: 1c10        adds	r0, r2, #0
@   0x0801a736: 3878        subs	r0, #120	@ 0x78
@   0x0801a738: 4281        cmp	r1, r0
@   0x0801a73a: db01        blt.n	0x1a740
@   0x0801a73c: 3878        subs	r0, #120	@ 0x78
@   0x0801a73e: 6020        str	r0, [r4, #0]
@   0x0801a740: 2004        movs	r0, #4
@   0x0801a742: 5e31        ldrsh	r1, [r6, r0]
@   0x0801a744: 8b1b        ldrh	r3, [r3, #24]
@   0x0801a746: 00da        lsls	r2, r3, #3
@   0x0801a748: 1c10        adds	r0, r2, #0
@   0x0801a74a: 3868        subs	r0, #104	@ 0x68
@   0x0801a74c: 4281        cmp	r1, r0
@   0x0801a74e: db01        blt.n	0x1a754
@   0x0801a750: 3838        subs	r0, #56	@ 0x38
@   0x0801a752: 6028        str	r0, [r5, #0]
@   0x0801a754: 1c78        adds	r0, r7, #1
@   0x0801a756: 0600        lsls	r0, r0, #24
@   0x0801a758: 0e07        lsrs	r7, r0, #24
@   0x0801a75a: 4547        cmp	r7, r8
@   0x0801a75c: d3c9        bcc.n	0x1a6f2
@   0x0801a75e: bc18        pop	{r3, r4}
@   0x0801a760: 4698        mov	r8, r3
@   0x0801a762: 46a1        mov	r9, r4
@   0x0801a764: bcf0        pop	{r4, r5, r6, r7}
@   0x0801a766: bc01        pop	{r0}
@   0x0801a768: 4700        bx	r0
@   0x0801a76a: 0000        movs	r0, r0
@   0x0801a76c: 60a0        str	r0, [r4, #8]
@   0x0801a76e: 0300        lsls	r0, r0, #12
@   0x0801a770: 3720        adds	r7, #32
@   0x0801a772: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0801A6D4
sub_0801A6D4: @ 0x0801a6d4
        .incbin "frog_us_baserom.gba", 0x1a6d4, 0xa0
        thumb_func_end sub_0801A6D4
