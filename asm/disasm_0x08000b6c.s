@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08000b6c, 0x08000c98)  (300 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8000b6c --end 0x8000c98 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08000b6c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08000b6e: 4657        mov	r7, sl
@   0x08000b70: 464e        mov	r6, r9
@   0x08000b72: 4645        mov	r5, r8
@   0x08000b74: b4e0        push	{r5, r6, r7}
@   0x08000b76: 1c06        adds	r6, r0, #0
@   0x08000b78: 468a        mov	sl, r1
@   0x08000b7a: 2212        movs	r2, #18
@   0x08000b7c: f00a        fecc 	bl	0xb918
@   0x08000b80: 481d        ldr	r0, [pc, #116]	@ (0xbf8)
@   0x08000b82: 4680        mov	r8, r0
@   0x08000b84: 2004        movs	r0, #4
@   0x08000b86: 4641        mov	r1, r8
@   0x08000b88: 8e89        ldrh	r1, [r1, #52]	@ 0x34
@   0x08000b8a: 4008        ands	r0, r1
@   0x08000b8c: 0400        lsls	r0, r0, #16
@   0x08000b8e: 0c05        lsrs	r5, r0, #16
@   0x08000b90: 2d00        cmp	r5, #0
@   0x08000b92: d171        bne.n	0xc78
@   0x08000b94: 4c19        ldr	r4, [pc, #100]	@ (0xbfc)
@   0x08000b96: 7e20        ldrb	r0, [r4, #24]
@   0x08000b98: 7e61        ldrb	r1, [r4, #25]
@   0x08000b9a: 2308        movs	r3, #8
@   0x08000b9c: 5ee2        ldrsh	r2, [r4, r3]
@   0x08000b9e: 270a        movs	r7, #10
@   0x08000ba0: 5fe3        ldrsh	r3, [r4, r7]
@   0x08000ba2: f00c        f8f1 	bl	0xcd88
@   0x08000ba6: 0600        lsls	r0, r0, #24
@   0x08000ba8: 0e00        lsrs	r0, r0, #24
@   0x08000baa: 4681        mov	r9, r0
@   0x08000bac: 2010        movs	r0, #16
@   0x08000bae: 8a21        ldrh	r1, [r4, #16]
@   0x08000bb0: 4008        ands	r0, r1
@   0x08000bb2: 2800        cmp	r0, #0
@   0x08000bb4: d005        beq.n	0xbc2
@   0x08000bb6: 1c30        adds	r0, r6, #0
@   0x08000bb8: 4651        mov	r1, sl
@   0x08000bba: 2212        movs	r2, #18
@   0x08000bbc: 464b        mov	r3, r9
@   0x08000bbe: f00a        fe73 	bl	0xb8a8
@   0x08000bc2: 2040        movs	r0, #64	@ 0x40
@   0x08000bc4: 8a22        ldrh	r2, [r4, #16]
@   0x08000bc6: 4010        ands	r0, r2
@   0x08000bc8: 2800        cmp	r0, #0
@   0x08000bca: d01f        beq.n	0xc0c
@   0x08000bcc: 7e20        ldrb	r0, [r4, #24]
@   0x08000bce: 7e61        ldrb	r1, [r4, #25]
@   0x08000bd0: 2308        movs	r3, #8
@   0x08000bd2: 5ee2        ldrsh	r2, [r4, r3]
@   0x08000bd4: 260a        movs	r6, #10
@   0x08000bd6: 5fa3        ldrsh	r3, [r4, r6]
@   0x08000bd8: f00c        f8f8 	bl	0xcdcc
@   0x08000bdc: 0600        lsls	r0, r0, #24
@   0x08000bde: 2800        cmp	r0, #0
@   0x08000be0: d014        beq.n	0xc0c
@   0x08000be2: 7e20        ldrb	r0, [r4, #24]
@   0x08000be4: 2800        cmp	r0, #0
@   0x08000be6: d10b        bne.n	0xc00
@   0x08000be8: 2001        movs	r0, #1
@   0x08000bea: 7620        strb	r0, [r4, #24]
@   0x08000bec: 7660        strb	r0, [r4, #25]
@   0x08000bee: 2002        movs	r0, #2
@   0x08000bf0: 4647        mov	r7, r8
@   0x08000bf2: 71b8        strb	r0, [r7, #6]
@   0x08000bf4: 75f8        strb	r0, [r7, #23]
@   0x08000bf6: e009        b.n	0xc0c
@   0x08000bf8: 3720        adds	r7, #32
@   0x08000bfa: 0300        lsls	r0, r0, #12
@   0x08000bfc: 35e0        adds	r5, #224	@ 0xe0
@   0x08000bfe: 0300        lsls	r0, r0, #12
@   0x08000c00: 7625        strb	r5, [r4, #24]
@   0x08000c02: 7665        strb	r5, [r4, #25]
@   0x08000c04: 2003        movs	r0, #3
@   0x08000c06: 4641        mov	r1, r8
@   0x08000c08: 7188        strb	r0, [r1, #6]
@   0x08000c0a: 75c8        strb	r0, [r1, #23]
@   0x08000c0c: 491e        ldr	r1, [pc, #120]	@ (0xc88)
@   0x08000c0e: 2001        movs	r0, #1
@   0x08000c10: 7c09        ldrb	r1, [r1, #16]
@   0x08000c12: 4008        ands	r0, r1
@   0x08000c14: 2800        cmp	r0, #0
@   0x08000c16: d12f        bne.n	0xc78
@   0x08000c18: 4c1c        ldr	r4, [pc, #112]	@ (0xc8c)
@   0x08000c1a: 20cc        movs	r0, #204	@ 0xcc
@   0x08000c1c: 0040        lsls	r0, r0, #1
@   0x08000c1e: 8862        ldrh	r2, [r4, #2]
@   0x08000c20: 4282        cmp	r2, r0
@   0x08000c22: d904        bls.n	0xc2e
@   0x08000c24: 481a        ldr	r0, [pc, #104]	@ (0xc90)
@   0x08000c26: 2180        movs	r1, #128	@ 0x80
@   0x08000c28: 0109        lsls	r1, r1, #4
@   0x08000c2a: f005        ffad 	bl	0x6b88
@   0x08000c2e: 464b        mov	r3, r9
@   0x08000c30: 2b07        cmp	r3, #7
@   0x08000c32: d121        bne.n	0xc78
@   0x08000c34: 2604        movs	r6, #4
@   0x08000c36: 5fa1        ldrsh	r1, [r4, r6]
@   0x08000c38: 20fa        movs	r0, #250	@ 0xfa
@   0x08000c3a: 0080        lsls	r0, r0, #2
@   0x08000c3c: 4281        cmp	r1, r0
@   0x08000c3e: dd0c        ble.n	0xc5a
@   0x08000c40: 8860        ldrh	r0, [r4, #2]
@   0x08000c42: 38aa        subs	r0, #170	@ 0xaa
@   0x08000c44: 0400        lsls	r0, r0, #16
@   0x08000c46: 0c00        lsrs	r0, r0, #16
@   0x08000c48: 2818        cmp	r0, #24
@   0x08000c4a: d806        bhi.n	0xc5a
@   0x08000c4c: 4810        ldr	r0, [pc, #64]	@ (0xc90)
@   0x08000c4e: 2102        movs	r1, #2
@   0x08000c50: f005        ffa0 	bl	0x6b94
@   0x08000c54: 8860        ldrh	r0, [r4, #2]
@   0x08000c56: 3801        subs	r0, #1
@   0x08000c58: 8060        strh	r0, [r4, #2]
@   0x08000c5a: 4c0c        ldr	r4, [pc, #48]	@ (0xc8c)
@   0x08000c5c: 8867        ldrh	r7, [r4, #2]
@   0x08000c5e: 490d        ldr	r1, [pc, #52]	@ (0xc94)
@   0x08000c60: 1878        adds	r0, r7, r1
@   0x08000c62: 0400        lsls	r0, r0, #16
@   0x08000c64: 0c00        lsrs	r0, r0, #16
@   0x08000c66: 2818        cmp	r0, #24
@   0x08000c68: d806        bhi.n	0xc78
@   0x08000c6a: 4809        ldr	r0, [pc, #36]	@ (0xc90)
@   0x08000c6c: 2102        movs	r1, #2
@   0x08000c6e: f005        ff91 	bl	0x6b94
@   0x08000c72: 8860        ldrh	r0, [r4, #2]
@   0x08000c74: 3001        adds	r0, #1
@   0x08000c76: 8060        strh	r0, [r4, #2]
@   0x08000c78: bc38        pop	{r3, r4, r5}
@   0x08000c7a: 4698        mov	r8, r3
@   0x08000c7c: 46a1        mov	r9, r4
@   0x08000c7e: 46aa        mov	sl, r5
@   0x08000c80: bcf0        pop	{r4, r5, r6, r7}
@   0x08000c82: bc01        pop	{r0}
@   0x08000c84: 4700        bx	r0
@   0x08000c86: 0000        movs	r0, r0
@   0x08000c88: 5330        strh	r0, [r6, r4]
@   0x08000c8a: 0300        lsls	r0, r0, #12
@   0x08000c8c: 3720        adds	r7, #32
@   0x08000c8e: 0300        lsls	r0, r0, #12
@   0x08000c90: 35e0        adds	r5, #224	@ 0xe0
@   0x08000c92: 0300        lsls	r0, r0, #12
@   0x08000c94: fefc        ffff 			@ <UNDEFINED> instruction: 0xfefcffff

        thumb_func_start sub_08000B6C
sub_08000B6C: @ 0x08000b6c
        .incbin "frog_us_baserom.gba", 0xb6c, 0x12c
        thumb_func_end sub_08000B6C
