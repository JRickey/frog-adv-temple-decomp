@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08032b18, 0x08032bc8)  (176 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8032b18 --end 0x8032bc8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08032b18: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08032b1a: 468c        mov	ip, r1
@   0x08032b1c: 2bff        cmp	r3, #255	@ 0xff
@   0x08032b1e: d00f        beq.n	0x32b40
@   0x08032b20: 4806        ldr	r0, [pc, #24]	@ (0x32b3c)
@   0x08032b22: 6800        ldr	r0, [r0, #0]
@   0x08032b24: 30cc        adds	r0, #204	@ 0xcc
@   0x08032b26: 6801        ldr	r1, [r0, #0]
@   0x08032b28: 0098        lsls	r0, r3, #2
@   0x08032b2a: 1840        adds	r0, r0, r1
@   0x08032b2c: 6800        ldr	r0, [r0, #0]
@   0x08032b2e: 2800        cmp	r0, #0
@   0x08032b30: d002        beq.n	0x32b38
@   0x08032b32: 8e80        ldrh	r0, [r0, #52]	@ 0x34
@   0x08032b34: 4560        cmp	r0, ip
@   0x08032b36: d82e        bhi.n	0x32b96
@   0x08032b38: 1c18        adds	r0, r3, #0
@   0x08032b3a: e02e        b.n	0x32b9a
@   0x08032b3c: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08032b3e: 0300        lsls	r0, r0, #12
@   0x08032b40: 2700        movs	r7, #0
@   0x08032b42: 4663        mov	r3, ip
@   0x08032b44: 3301        adds	r3, #1
@   0x08032b46: 2680        movs	r6, #128	@ 0x80
@   0x08032b48: 0276        lsls	r6, r6, #9
@   0x08032b4a: 4809        ldr	r0, [pc, #36]	@ (0x32b70)
@   0x08032b4c: 6800        ldr	r0, [r0, #0]
@   0x08032b4e: 7842        ldrb	r2, [r0, #1]
@   0x08032b50: 7805        ldrb	r5, [r0, #0]
@   0x08032b52: 42aa        cmp	r2, r5
@   0x08032b54: da19        bge.n	0x32b8a
@   0x08032b56: 30cc        adds	r0, #204	@ 0xcc
@   0x08032b58: 6801        ldr	r1, [r0, #0]
@   0x08032b5a: 0090        lsls	r0, r2, #2
@   0x08032b5c: 1844        adds	r4, r0, r1
@   0x08032b5e: 6820        ldr	r0, [r4, #0]
@   0x08032b60: 2800        cmp	r0, #0
@   0x08032b62: d016        beq.n	0x32b92
@   0x08032b64: 8e81        ldrh	r1, [r0, #52]	@ 0x34
@   0x08032b66: 4299        cmp	r1, r3
@   0x08032b68: d204        bcs.n	0x32b74
@   0x08032b6a: 1c0b        adds	r3, r1, #0
@   0x08032b6c: 8ec6        ldrh	r6, [r0, #54]	@ 0x36
@   0x08032b6e: e007        b.n	0x32b80
@   0x08032b70: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08032b72: 0300        lsls	r0, r0, #12
@   0x08032b74: 4299        cmp	r1, r3
@   0x08032b76: d104        bne.n	0x32b82
@   0x08032b78: 8ec0        ldrh	r0, [r0, #54]	@ 0x36
@   0x08032b7a: 42b0        cmp	r0, r6
@   0x08032b7c: d201        bcs.n	0x32b82
@   0x08032b7e: 1c06        adds	r6, r0, #0
@   0x08032b80: 1c17        adds	r7, r2, #0
@   0x08032b82: 3404        adds	r4, #4
@   0x08032b84: 3201        adds	r2, #1
@   0x08032b86: 42aa        cmp	r2, r5
@   0x08032b88: dbe9        blt.n	0x32b5e
@   0x08032b8a: 4563        cmp	r3, ip
@   0x08032b8c: d803        bhi.n	0x32b96
@   0x08032b8e: 1c38        adds	r0, r7, #0
@   0x08032b90: e003        b.n	0x32b9a
@   0x08032b92: 1c10        adds	r0, r2, #0
@   0x08032b94: e001        b.n	0x32b9a
@   0x08032b96: 2001        movs	r0, #1
@   0x08032b98: 4240        negs	r0, r0
@   0x08032b9a: bcf0        pop	{r4, r5, r6, r7}
@   0x08032b9c: bc02        pop	{r1}
@   0x08032b9e: 4708        bx	r1
@   0x08032ba0: 1c0b        adds	r3, r1, #0
@   0x08032ba2: 2800        cmp	r0, #0
@   0x08032ba4: d002        beq.n	0x32bac
@   0x08032ba6: 2080        movs	r0, #128	@ 0x80
@   0x08032ba8: 0040        lsls	r0, r0, #1
@   0x08032baa: 181b        adds	r3, r3, r0
@   0x08032bac: 4804        ldr	r0, [pc, #16]	@ (0x32bc0)
@   0x08032bae: 6800        ldr	r0, [r0, #0]
@   0x08032bb0: 0051        lsls	r1, r2, #1
@   0x08032bb2: 30ac        adds	r0, #172	@ 0xac
@   0x08032bb4: 1840        adds	r0, r0, r1
@   0x08032bb6: 8800        ldrh	r0, [r0, #0]
@   0x08032bb8: 4298        cmp	r0, r3
@   0x08032bba: d903        bls.n	0x32bc4
@   0x08032bbc: 2000        movs	r0, #0
@   0x08032bbe: e002        b.n	0x32bc6
@   0x08032bc0: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08032bc2: 0300        lsls	r0, r0, #12
@   0x08032bc4: 2001        movs	r0, #1
@   0x08032bc6: 4770        bx	lr

        thumb_func_start sub_08032B18
sub_08032B18: @ 0x08032b18
        .incbin "frog_us_baserom.gba", 0x32b18, 0xb0
        thumb_func_end sub_08032B18
