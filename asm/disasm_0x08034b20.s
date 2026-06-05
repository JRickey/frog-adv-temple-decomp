@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08034b20, 0x08034bf8)  (216 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8034b20 --end 0x8034bf8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08034b20: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08034b22: b082        sub	sp, #8
@   0x08034b24: 1c02        adds	r2, r0, #0
@   0x08034b26: 1c0e        adds	r6, r1, #0
@   0x08034b28: 6851        ldr	r1, [r2, #4]
@   0x08034b2a: 9100        str	r1, [sp, #0]
@   0x08034b2c: 6810        ldr	r0, [r2, #0]
@   0x08034b2e: 9001        str	r0, [sp, #4]
@   0x08034b30: 466a        mov	r2, sp
@   0x08034b32: 1c0c        adds	r4, r1, #0
@   0x08034b34: 0300        lsls	r0, r0, #12
@   0x08034b36: 0b05        lsrs	r5, r0, #12
@   0x08034b38: 88d3        ldrh	r3, [r2, #6]
@   0x08034b3a: 0458        lsls	r0, r3, #17
@   0x08034b3c: 0d43        lsrs	r3, r0, #21
@   0x08034b3e: 79d2        ldrb	r2, [r2, #7]
@   0x08034b40: 09d0        lsrs	r0, r2, #7
@   0x08034b42: 6070        str	r0, [r6, #4]
@   0x08034b44: 2b00        cmp	r3, #0
@   0x08034b46: d125        bne.n	0x34b94
@   0x08034b48: 4329        orrs	r1, r5
@   0x08034b4a: 2900        cmp	r1, #0
@   0x08034b4c: d102        bne.n	0x34b54
@   0x08034b4e: 2002        movs	r0, #2
@   0x08034b50: 6030        str	r0, [r6, #0]
@   0x08034b52: e049        b.n	0x34be8
@   0x08034b54: 480d        ldr	r0, [pc, #52]	@ (0x34b8c)
@   0x08034b56: 60b0        str	r0, [r6, #8]
@   0x08034b58: 0e23        lsrs	r3, r4, #24
@   0x08034b5a: 022a        lsls	r2, r5, #8
@   0x08034b5c: 1c19        adds	r1, r3, #0
@   0x08034b5e: 4311        orrs	r1, r2
@   0x08034b60: 0220        lsls	r0, r4, #8
@   0x08034b62: 1c0d        adds	r5, r1, #0
@   0x08034b64: 1c04        adds	r4, r0, #0
@   0x08034b66: 2003        movs	r0, #3
@   0x08034b68: 6030        str	r0, [r6, #0]
@   0x08034b6a: 4809        ldr	r0, [pc, #36]	@ (0x34b90)
@   0x08034b6c: 4285        cmp	r5, r0
@   0x08034b6e: d829        bhi.n	0x34bc4
@   0x08034b70: 1c07        adds	r7, r0, #0
@   0x08034b72: 0fe3        lsrs	r3, r4, #31
@   0x08034b74: 006a        lsls	r2, r5, #1
@   0x08034b76: 1c19        adds	r1, r3, #0
@   0x08034b78: 4311        orrs	r1, r2
@   0x08034b7a: 0060        lsls	r0, r4, #1
@   0x08034b7c: 1c0d        adds	r5, r1, #0
@   0x08034b7e: 1c04        adds	r4, r0, #0
@   0x08034b80: 68b0        ldr	r0, [r6, #8]
@   0x08034b82: 3801        subs	r0, #1
@   0x08034b84: 60b0        str	r0, [r6, #8]
@   0x08034b86: 42bd        cmp	r5, r7
@   0x08034b88: d9f3        bls.n	0x34b72
@   0x08034b8a: e01b        b.n	0x34bc4
@   0x08034b8c: fc02        ffff 			@ <UNDEFINED> instruction: 0xfc02ffff
@   0x08034b90: ffff        0fff 			@ <UNDEFINED> instruction: 0xffff0fff
@   0x08034b94: 4804        ldr	r0, [pc, #16]	@ (0x34ba8)
@   0x08034b96: 4283        cmp	r3, r0
@   0x08034b98: d117        bne.n	0x34bca
@   0x08034b9a: 4329        orrs	r1, r5
@   0x08034b9c: 2900        cmp	r1, #0
@   0x08034b9e: d105        bne.n	0x34bac
@   0x08034ba0: 2004        movs	r0, #4
@   0x08034ba2: 6030        str	r0, [r6, #0]
@   0x08034ba4: e020        b.n	0x34be8
@   0x08034ba6: 0000        movs	r0, r0
@   0x08034ba8: 07ff        lsls	r7, r7, #31
@   0x08034baa: 0000        movs	r0, r0
@   0x08034bac: 2280        movs	r2, #128	@ 0x80
@   0x08034bae: 0312        lsls	r2, r2, #12
@   0x08034bb0: 2000        movs	r0, #0
@   0x08034bb2: 1c29        adds	r1, r5, #0
@   0x08034bb4: 4011        ands	r1, r2
@   0x08034bb6: 4301        orrs	r1, r0
@   0x08034bb8: 2900        cmp	r1, #0
@   0x08034bba: d002        beq.n	0x34bc2
@   0x08034bbc: 2001        movs	r0, #1
@   0x08034bbe: 6030        str	r0, [r6, #0]
@   0x08034bc0: e000        b.n	0x34bc4
@   0x08034bc2: 6031        str	r1, [r6, #0]
@   0x08034bc4: 60f4        str	r4, [r6, #12]
@   0x08034bc6: 6135        str	r5, [r6, #16]
@   0x08034bc8: e00e        b.n	0x34be8
@   0x08034bca: 4908        ldr	r1, [pc, #32]	@ (0x34bec)
@   0x08034bcc: 1858        adds	r0, r3, r1
@   0x08034bce: 60b0        str	r0, [r6, #8]
@   0x08034bd0: 2003        movs	r0, #3
@   0x08034bd2: 6030        str	r0, [r6, #0]
@   0x08034bd4: 0e23        lsrs	r3, r4, #24
@   0x08034bd6: 022a        lsls	r2, r5, #8
@   0x08034bd8: 1c19        adds	r1, r3, #0
@   0x08034bda: 4311        orrs	r1, r2
@   0x08034bdc: 0220        lsls	r0, r4, #8
@   0x08034bde: 4a04        ldr	r2, [pc, #16]	@ (0x34bf0)
@   0x08034be0: 4b04        ldr	r3, [pc, #16]	@ (0x34bf4)
@   0x08034be2: 4319        orrs	r1, r3
@   0x08034be4: 60f0        str	r0, [r6, #12]
@   0x08034be6: 6131        str	r1, [r6, #16]
@   0x08034be8: b002        add	sp, #8
@   0x08034bea: bdf0        pop	{r4, r5, r6, r7, pc}
@   0x08034bec: fc01        ffff 			@ <UNDEFINED> instruction: 0xfc01ffff
@   0x08034bf0: 0000        movs	r0, r0
@   0x08034bf2: 0000        movs	r0, r0
@   0x08034bf4: 0000        movs	r0, r0
@   0x08034bf6: 1000        asrs	r0, r0, #32

        thumb_func_start sub_08034B20
sub_08034B20: @ 0x08034b20
        .incbin "frog_us_baserom.gba", 0x34b20, 0xd8
        thumb_func_end sub_08034B20
