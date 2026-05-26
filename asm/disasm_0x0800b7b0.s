@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800b7b0, 0x0800b8a8)  (248 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800b7b0 --end 0x800b8a8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800b7b0: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800b7b2: 4657        mov	r7, sl
@   0x0800b7b4: 464e        mov	r6, r9
@   0x0800b7b6: 4645        mov	r5, r8
@   0x0800b7b8: b4e0        push	{r5, r6, r7}
@   0x0800b7ba: b084        sub	sp, #16
@   0x0800b7bc: 9001        str	r0, [sp, #4]
@   0x0800b7be: 9102        str	r1, [sp, #8]
@   0x0800b7c0: 0612        lsls	r2, r2, #24
@   0x0800b7c2: 0e16        lsrs	r6, r2, #24
@   0x0800b7c4: 2100        movs	r1, #0
@   0x0800b7c6: 481b        ldr	r0, [pc, #108]	@ (0xb834)
@   0x0800b7c8: 4680        mov	r8, r0
@   0x0800b7ca: 0633        lsls	r3, r6, #24
@   0x0800b7cc: 161c        asrs	r4, r3, #24
@   0x0800b7ce: 0060        lsls	r0, r4, #1
@   0x0800b7d0: 1900        adds	r0, r0, r4
@   0x0800b7d2: 0080        lsls	r0, r0, #2
@   0x0800b7d4: 4440        add	r0, r8
@   0x0800b7d6: 7800        ldrb	r0, [r0, #0]
@   0x0800b7d8: 0600        lsls	r0, r0, #24
@   0x0800b7da: 1600        asrs	r0, r0, #24
@   0x0800b7dc: 4281        cmp	r1, r0
@   0x0800b7de: da53        bge.n	0xb888
@   0x0800b7e0: 46c2        mov	sl, r8
@   0x0800b7e2: 9403        str	r4, [sp, #12]
@   0x0800b7e4: 2204        movs	r2, #4
@   0x0800b7e6: 4442        add	r2, r8
@   0x0800b7e8: 4691        mov	r9, r2
@   0x0800b7ea: 060a        lsls	r2, r1, #24
@   0x0800b7ec: 1551        asrs	r1, r2, #21
@   0x0800b7ee: 9f01        ldr	r7, [sp, #4]
@   0x0800b7f0: 19c9        adds	r1, r1, r7
@   0x0800b7f2: 2000        movs	r0, #0
@   0x0800b7f4: 7108        strb	r0, [r1, #4]
@   0x0800b7f6: 7148        strb	r0, [r1, #5]
@   0x0800b7f8: 7188        strb	r0, [r1, #6]
@   0x0800b7fa: 6008        str	r0, [r1, #0]
@   0x0800b7fc: 480e        ldr	r0, [pc, #56]	@ (0xb838)
@   0x0800b7fe: 1c15        adds	r5, r2, #0
@   0x0800b800: 7a80        ldrb	r0, [r0, #10]
@   0x0800b802: 2801        cmp	r0, #1
@   0x0800b804: d11c        bne.n	0xb840
@   0x0800b806: 480d        ldr	r0, [pc, #52]	@ (0xb83c)
@   0x0800b808: 7e00        ldrb	r0, [r0, #24]
@   0x0800b80a: 1619        asrs	r1, r3, #24
@   0x0800b80c: 004c        lsls	r4, r1, #1
@   0x0800b80e: 1864        adds	r4, r4, r1
@   0x0800b810: 00a4        lsls	r4, r4, #2
@   0x0800b812: 464a        mov	r2, r9
@   0x0800b814: 18a1        adds	r1, r4, r2
@   0x0800b816: 680a        ldr	r2, [r1, #0]
@   0x0800b818: 0da9        lsrs	r1, r5, #22
@   0x0800b81a: 1889        adds	r1, r1, r2
@   0x0800b81c: 2300        movs	r3, #0
@   0x0800b81e: 5eca        ldrsh	r2, [r1, r3]
@   0x0800b820: 2702        movs	r7, #2
@   0x0800b822: 5fcb        ldrsh	r3, [r1, r7]
@   0x0800b824: 4454        add	r4, sl
@   0x0800b826: 7a21        ldrb	r1, [r4, #8]
@   0x0800b828: 9100        str	r1, [sp, #0]
@   0x0800b82a: 2101        movs	r1, #1
@   0x0800b82c: f001        f9a8 	bl	0xcb80
@   0x0800b830: e01b        b.n	0xb86a
@   0x0800b832: 0000        movs	r0, r0
@   0x0800b834: 0b00        lsrs	r0, r0, #12
@   0x0800b836: 080c        lsrs	r4, r1, #32
@   0x0800b838: 5330        strh	r0, [r6, r4]
@   0x0800b83a: 0300        lsls	r0, r0, #12
@   0x0800b83c: 35e0        adds	r5, #224	@ 0xe0
@   0x0800b83e: 0300        lsls	r0, r0, #12
@   0x0800b840: 4818        ldr	r0, [pc, #96]	@ (0xb8a4)
@   0x0800b842: 7e00        ldrb	r0, [r0, #24]
@   0x0800b844: 9903        ldr	r1, [sp, #12]
@   0x0800b846: 004c        lsls	r4, r1, #1
@   0x0800b848: 1864        adds	r4, r4, r1
@   0x0800b84a: 00a4        lsls	r4, r4, #2
@   0x0800b84c: 464a        mov	r2, r9
@   0x0800b84e: 18a1        adds	r1, r4, r2
@   0x0800b850: 680a        ldr	r2, [r1, #0]
@   0x0800b852: 0da9        lsrs	r1, r5, #22
@   0x0800b854: 1889        adds	r1, r1, r2
@   0x0800b856: 2300        movs	r3, #0
@   0x0800b858: 5eca        ldrsh	r2, [r1, r3]
@   0x0800b85a: 2702        movs	r7, #2
@   0x0800b85c: 5fcb        ldrsh	r3, [r1, r7]
@   0x0800b85e: 4454        add	r4, sl
@   0x0800b860: 7a21        ldrb	r1, [r4, #8]
@   0x0800b862: 9100        str	r1, [sp, #0]
@   0x0800b864: 2100        movs	r1, #0
@   0x0800b866: f001        f98b 	bl	0xcb80
@   0x0800b86a: 0631        lsls	r1, r6, #24
@   0x0800b86c: 2080        movs	r0, #128	@ 0x80
@   0x0800b86e: 0440        lsls	r0, r0, #17
@   0x0800b870: 182a        adds	r2, r5, r0
@   0x0800b872: 1c0b        adds	r3, r1, #0
@   0x0800b874: 1619        asrs	r1, r3, #24
@   0x0800b876: 0048        lsls	r0, r1, #1
@   0x0800b878: 1840        adds	r0, r0, r1
@   0x0800b87a: 0080        lsls	r0, r0, #2
@   0x0800b87c: 4440        add	r0, r8
@   0x0800b87e: 0e11        lsrs	r1, r2, #24
@   0x0800b880: 7800        ldrb	r0, [r0, #0]
@   0x0800b882: 0600        lsls	r0, r0, #24
@   0x0800b884: 4282        cmp	r2, r0
@   0x0800b886: dbb0        blt.n	0xb7ea
@   0x0800b888: 2000        movs	r0, #0
@   0x0800b88a: 2100        movs	r1, #0
@   0x0800b88c: 9a02        ldr	r2, [sp, #8]
@   0x0800b88e: 6010        str	r0, [r2, #0]
@   0x0800b890: 6051        str	r1, [r2, #4]
@   0x0800b892: b004        add	sp, #16
@   0x0800b894: bc38        pop	{r3, r4, r5}
@   0x0800b896: 4698        mov	r8, r3
@   0x0800b898: 46a1        mov	r9, r4
@   0x0800b89a: 46aa        mov	sl, r5
@   0x0800b89c: bcf0        pop	{r4, r5, r6, r7}
@   0x0800b89e: bc01        pop	{r0}
@   0x0800b8a0: 4700        bx	r0
@   0x0800b8a2: 0000        movs	r0, r0
@   0x0800b8a4: 35e0        adds	r5, #224	@ 0xe0
@   0x0800b8a6: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0800B7B0
sub_0800B7B0: @ 0x0800b7b0
        .incbin "frog_us_baserom.gba", 0xb7b0, 0xf8
        thumb_func_end sub_0800B7B0
