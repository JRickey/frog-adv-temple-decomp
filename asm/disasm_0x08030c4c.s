@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08030c4c, 0x08030d8c)  (320 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8030c4c --end 0x8030d8c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08030c4c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08030c4e: 4657        mov	r7, sl
@   0x08030c50: 464e        mov	r6, r9
@   0x08030c52: 4645        mov	r5, r8
@   0x08030c54: b4e0        push	{r5, r6, r7}
@   0x08030c56: 1c05        adds	r5, r0, #0
@   0x08030c58: 468a        mov	sl, r1
@   0x08030c5a: 680f        ldr	r7, [r1, #0]
@   0x08030c5c: 2d03        cmp	r5, #3
@   0x08030c5e: dc00        bgt.n	0x30c62
@   0x08030c60: e088        b.n	0x30d74
@   0x08030c62: 3d04        subs	r5, #4
@   0x08030c64: 4a19        ldr	r2, [pc, #100]	@ (0x30ccc)
@   0x08030c66: 6813        ldr	r3, [r2, #0]
@   0x08030c68: 1c18        adds	r0, r3, #0
@   0x08030c6a: 30c8        adds	r0, #200	@ 0xc8
@   0x08030c6c: 01a9        lsls	r1, r5, #6
@   0x08030c6e: 6800        ldr	r0, [r0, #0]
@   0x08030c70: 1840        adds	r0, r0, r1
@   0x08030c72: 4681        mov	r9, r0
@   0x08030c74: 1c19        adds	r1, r3, #0
@   0x08030c76: 31c0        adds	r1, #192	@ 0xc0
@   0x08030c78: 00e8        lsls	r0, r5, #3
@   0x08030c7a: 1b40        subs	r0, r0, r5
@   0x08030c7c: 0080        lsls	r0, r0, #2
@   0x08030c7e: 6809        ldr	r1, [r1, #0]
@   0x08030c80: 180e        adds	r6, r1, r0
@   0x08030c82: 4649        mov	r1, r9
@   0x08030c84: 6b88        ldr	r0, [r1, #56]	@ 0x38
@   0x08030c86: 4912        ldr	r1, [pc, #72]	@ (0x30cd0)
@   0x08030c88: 4008        ands	r0, r1
@   0x08030c8a: 2180        movs	r1, #128	@ 0x80
@   0x08030c8c: 00c9        lsls	r1, r1, #3
@   0x08030c8e: 4308        orrs	r0, r1
@   0x08030c90: 4649        mov	r1, r9
@   0x08030c92: 6388        str	r0, [r1, #56]	@ 0x38
@   0x08030c94: 1c18        adds	r0, r3, #0
@   0x08030c96: 30c4        adds	r0, #196	@ 0xc4
@   0x08030c98: 6801        ldr	r1, [r0, #0]
@   0x08030c9a: 00a8        lsls	r0, r5, #2
@   0x08030c9c: 1840        adds	r0, r0, r1
@   0x08030c9e: 2100        movs	r1, #0
@   0x08030ca0: 6001        str	r1, [r0, #0]
@   0x08030ca2: 218c        movs	r1, #140	@ 0x8c
@   0x08030ca4: 0049        lsls	r1, r1, #1
@   0x08030ca6: 1858        adds	r0, r3, r1
@   0x08030ca8: 6800        ldr	r0, [r0, #0]
@   0x08030caa: 3908        subs	r1, #8
@   0x08030cac: 1840        adds	r0, r0, r1
@   0x08030cae: 6801        ldr	r1, [r0, #0]
@   0x08030cb0: 0068        lsls	r0, r5, #1
@   0x08030cb2: 1940        adds	r0, r0, r5
@   0x08030cb4: 0080        lsls	r0, r0, #2
@   0x08030cb6: 1840        adds	r0, r0, r1
@   0x08030cb8: 3030        adds	r0, #48	@ 0x30
@   0x08030cba: 2101        movs	r1, #1
@   0x08030cbc: 5679        ldrsb	r1, [r7, r1]
@   0x08030cbe: 7980        ldrb	r0, [r0, #6]
@   0x08030cc0: 1844        adds	r4, r0, r1
@   0x08030cc2: 2c00        cmp	r4, #0
@   0x08030cc4: dc06        bgt.n	0x30cd4
@   0x08030cc6: 2401        movs	r4, #1
@   0x08030cc8: e007        b.n	0x30cda
@   0x08030cca: 0000        movs	r0, r0
@   0x08030ccc: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08030cce: 0300        lsls	r0, r0, #12
@   0x08030cd0: e7ff        b.n	0x30cd2
@   0x08030cd2: ffff        2c7f 	vcvt.f16.u16	q9, <illegal reg q15.5>, #1
@   0x08030cd6: dd00        ble.n	0x30cda
@   0x08030cd8: 247f        movs	r4, #127	@ 0x7f
@   0x08030cda: 2203        movs	r2, #3
@   0x08030cdc: 56ba        ldrsb	r2, [r7, r2]
@   0x08030cde: 4690        mov	r8, r2
@   0x08030ce0: 78bf        ldrb	r7, [r7, #2]
@   0x08030ce2: 063f        lsls	r7, r7, #24
@   0x08030ce4: 163f        asrs	r7, r7, #24
@   0x08030ce6: 1bd1        subs	r1, r2, r7
@   0x08030ce8: 2900        cmp	r1, #0
@   0x08030cea: da09        bge.n	0x30d00
@   0x08030cec: 1e48        subs	r0, r1, #1
@   0x08030cee: 0400        lsls	r0, r0, #16
@   0x08030cf0: 217f        movs	r1, #127	@ 0x7f
@   0x08030cf2: f003        f80f 	bl	0x33d14
@   0x08030cf6: 4360        muls	r0, r4
@   0x08030cf8: 1400        asrs	r0, r0, #16
@   0x08030cfa: 4642        mov	r2, r8
@   0x08030cfc: 1811        adds	r1, r2, r0
@   0x08030cfe: e007        b.n	0x30d10
@   0x08030d00: 1c48        adds	r0, r1, #1
@   0x08030d02: 0400        lsls	r0, r0, #16
@   0x08030d04: 217f        movs	r1, #127	@ 0x7f
@   0x08030d06: f003        f805 	bl	0x33d14
@   0x08030d0a: 4360        muls	r0, r4
@   0x08030d0c: 1400        asrs	r0, r0, #16
@   0x08030d0e: 1839        adds	r1, r7, r0
@   0x08030d10: 4648        mov	r0, r9
@   0x08030d12: 302c        adds	r0, #44	@ 0x2c
@   0x08030d14: 2300        movs	r3, #0
@   0x08030d16: 7141        strb	r1, [r0, #5]
@   0x08030d18: 7101        strb	r1, [r0, #4]
@   0x08030d1a: 0209        lsls	r1, r1, #8
@   0x08030d1c: 2400        movs	r4, #0
@   0x08030d1e: 464a        mov	r2, r9
@   0x08030d20: 8591        strh	r1, [r2, #44]	@ 0x2c
@   0x08030d22: 8043        strh	r3, [r0, #2]
@   0x08030d24: 4a0d        ldr	r2, [pc, #52]	@ (0x30d5c)
@   0x08030d26: 6032        str	r2, [r6, #0]
@   0x08030d28: 2104        movs	r1, #4
@   0x08030d2a: 5641        ldrsb	r1, [r0, r1]
@   0x08030d2c: 3110        adds	r1, #16
@   0x08030d2e: 1889        adds	r1, r1, r2
@   0x08030d30: 60f1        str	r1, [r6, #12]
@   0x08030d32: 6071        str	r1, [r6, #4]
@   0x08030d34: 6810        ldr	r0, [r2, #0]
@   0x08030d36: 0840        lsrs	r0, r0, #1
@   0x08030d38: 1808        adds	r0, r1, r0
@   0x08030d3a: 60b0        str	r0, [r6, #8]
@   0x08030d3c: 1a40        subs	r0, r0, r1
@   0x08030d3e: 6130        str	r0, [r6, #16]
@   0x08030d40: 82f3        strh	r3, [r6, #22]
@   0x08030d42: 76b4        strb	r4, [r6, #26]
@   0x08030d44: 4648        mov	r0, r9
@   0x08030d46: 303d        adds	r0, #61	@ 0x3d
@   0x08030d48: 7800        ldrb	r0, [r0, #0]
@   0x08030d4a: 2800        cmp	r0, #0
@   0x08030d4c: d00a        beq.n	0x30d64
@   0x08030d4e: 4904        ldr	r1, [pc, #16]	@ (0x30d60)
@   0x08030d50: 6808        ldr	r0, [r1, #0]
@   0x08030d52: 2287        movs	r2, #135	@ 0x87
@   0x08030d54: 0052        lsls	r2, r2, #1
@   0x08030d56: 1880        adds	r0, r0, r2
@   0x08030d58: 7800        ldrb	r0, [r0, #0]
@   0x08030d5a: e004        b.n	0x30d66
@   0x08030d5c: da4c        bge.n	0x30df8
@   0x08030d5e: 083d        lsrs	r5, r7, #32
@   0x08030d60: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08030d62: 0300        lsls	r0, r0, #12
@   0x08030d64: 2000        movs	r0, #0
@   0x08030d66: 76f0        strb	r0, [r6, #27]
@   0x08030d68: 1c28        adds	r0, r5, #0
@   0x08030d6a: f7fe        fb15 	bl	0x2f398
@   0x08030d6e: 1c28        adds	r0, r5, #0
@   0x08030d70: f7fe        fe76 	bl	0x2fa60
@   0x08030d74: 4651        mov	r1, sl
@   0x08030d76: 6808        ldr	r0, [r1, #0]
@   0x08030d78: 3004        adds	r0, #4
@   0x08030d7a: 6008        str	r0, [r1, #0]
@   0x08030d7c: 2001        movs	r0, #1
@   0x08030d7e: bc38        pop	{r3, r4, r5}
@   0x08030d80: 4698        mov	r8, r3
@   0x08030d82: 46a1        mov	r9, r4
@   0x08030d84: 46aa        mov	sl, r5
@   0x08030d86: bcf0        pop	{r4, r5, r6, r7}
@   0x08030d88: bc02        pop	{r1}
@   0x08030d8a: 4708        bx	r1

        thumb_func_start sub_08030C4C
sub_08030C4C: @ 0x08030c4c
        .incbin "baserom.gba", 0x30c4c, 0x140
        thumb_func_end sub_08030C4C
