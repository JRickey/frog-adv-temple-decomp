@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802bdbc, 0x0802bf58)  (412 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802bdbc --end 0x802bf58 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802bdbc: b530        push	{r4, r5, lr}
@   0x0802bdbe: 4d2c        ldr	r5, [pc, #176]	@ (0x2be70)
@   0x0802bdc0: 1c28        adds	r0, r5, #0
@   0x0802bdc2: 302b        adds	r0, #43	@ 0x2b
@   0x0802bdc4: 7800        ldrb	r0, [r0, #0]
@   0x0802bdc6: 2805        cmp	r0, #5
@   0x0802bdc8: d900        bls.n	0x2bdcc
@   0x0802bdca: e0b9        b.n	0x2bf40
@   0x0802bdcc: 1c28        adds	r0, r5, #0
@   0x0802bdce: 2103        movs	r1, #3
@   0x0802bdd0: 2205        movs	r2, #5
@   0x0802bdd2: f7da        fce3 	bl	0x679c
@   0x0802bdd6: 0600        lsls	r0, r0, #24
@   0x0802bdd8: 2800        cmp	r0, #0
@   0x0802bdda: d01f        beq.n	0x2be1c
@   0x0802bddc: f7e9        f9da 	bl	0x15194
@   0x0802bde0: 4924        ldr	r1, [pc, #144]	@ (0x2be74)
@   0x0802bde2: 4825        ldr	r0, [pc, #148]	@ (0x2be78)
@   0x0802bde4: 180a        adds	r2, r1, r0
@   0x0802bde6: 2300        movs	r3, #0
@   0x0802bde8: 2001        movs	r0, #1
@   0x0802bdea: 8010        strh	r0, [r2, #0]
@   0x0802bdec: 4a23        ldr	r2, [pc, #140]	@ (0x2be7c)
@   0x0802bdee: 1888        adds	r0, r1, r2
@   0x0802bdf0: 7003        strb	r3, [r0, #0]
@   0x0802bdf2: 4b23        ldr	r3, [pc, #140]	@ (0x2be80)
@   0x0802bdf4: 18ca        adds	r2, r1, r3
@   0x0802bdf6: 2002        movs	r0, #2
@   0x0802bdf8: 8813        ldrh	r3, [r2, #0]
@   0x0802bdfa: 4318        orrs	r0, r3
@   0x0802bdfc: 8010        strh	r0, [r2, #0]
@   0x0802bdfe: 4821        ldr	r0, [pc, #132]	@ (0x2be84)
@   0x0802be00: 1809        adds	r1, r1, r0
@   0x0802be02: 4821        ldr	r0, [pc, #132]	@ (0x2be88)
@   0x0802be04: 6800        ldr	r0, [r0, #0]
@   0x0802be06: 6008        str	r0, [r1, #0]
@   0x0802be08: 1c28        adds	r0, r5, #0
@   0x0802be0a: 2103        movs	r1, #3
@   0x0802be0c: 2205        movs	r2, #5
@   0x0802be0e: f7da        fc59 	bl	0x66c4
@   0x0802be12: 1c28        adds	r0, r5, #0
@   0x0802be14: 2103        movs	r1, #3
@   0x0802be16: 2206        movs	r2, #6
@   0x0802be18: f7da        fc54 	bl	0x66c4
@   0x0802be1c: 4915        ldr	r1, [pc, #84]	@ (0x2be74)
@   0x0802be1e: 4a16        ldr	r2, [pc, #88]	@ (0x2be78)
@   0x0802be20: 188c        adds	r4, r1, r2
@   0x0802be22: 8823        ldrh	r3, [r4, #0]
@   0x0802be24: 2b02        cmp	r3, #2
@   0x0802be26: d111        bne.n	0x2be4c
@   0x0802be28: 4817        ldr	r0, [pc, #92]	@ (0x2be88)
@   0x0802be2a: 322a        adds	r2, #42	@ 0x2a
@   0x0802be2c: 1889        adds	r1, r1, r2
@   0x0802be2e: 6800        ldr	r0, [r0, #0]
@   0x0802be30: 6809        ldr	r1, [r1, #0]
@   0x0802be32: 1a40        subs	r0, r0, r1
@   0x0802be34: 28b4        cmp	r0, #180	@ 0xb4
@   0x0802be36: d909        bls.n	0x2be4c
@   0x0802be38: f7e9        f836 	bl	0x14ea8
@   0x0802be3c: 8820        ldrh	r0, [r4, #0]
@   0x0802be3e: 3001        adds	r0, #1
@   0x0802be40: 8020        strh	r0, [r4, #0]
@   0x0802be42: 1c28        adds	r0, r5, #0
@   0x0802be44: 2103        movs	r1, #3
@   0x0802be46: 2206        movs	r2, #6
@   0x0802be48: f7da        fbda 	bl	0x6600
@   0x0802be4c: f7e8        fa8e 	bl	0x1436c
@   0x0802be50: 0600        lsls	r0, r0, #24
@   0x0802be52: 2800        cmp	r0, #0
@   0x0802be54: d04f        beq.n	0x2bef6
@   0x0802be56: 4907        ldr	r1, [pc, #28]	@ (0x2be74)
@   0x0802be58: 4b07        ldr	r3, [pc, #28]	@ (0x2be78)
@   0x0802be5a: 18c8        adds	r0, r1, r3
@   0x0802be5c: 2200        movs	r2, #0
@   0x0802be5e: 5e80        ldrsh	r0, [r0, r2]
@   0x0802be60: 1c0a        adds	r2, r1, #0
@   0x0802be62: 2804        cmp	r0, #4
@   0x0802be64: d847        bhi.n	0x2bef6
@   0x0802be66: 0080        lsls	r0, r0, #2
@   0x0802be68: 4908        ldr	r1, [pc, #32]	@ (0x2be8c)
@   0x0802be6a: 1840        adds	r0, r0, r1
@   0x0802be6c: 6800        ldr	r0, [r0, #0]
@   0x0802be6e: 4687        mov	pc, r0
@   0x0802be70: 6110        str	r0, [r2, #16]
@   0x0802be72: 0300        lsls	r0, r0, #12
@   0x0802be74: 3720        adds	r7, #32
@   0x0802be76: 0300        lsls	r0, r0, #12
@   0x0802be78: 0af2        lsrs	r2, r6, #11
@   0x0802be7a: 0000        movs	r0, r0
@   0x0802be7c: 04ea        lsls	r2, r5, #19
@   0x0802be7e: 0000        movs	r0, r0
@   0x0802be80: 0504        lsls	r4, r0, #20
@   0x0802be82: 0000        movs	r0, r0
@   0x0802be84: 0b1c        lsrs	r4, r3, #12
@   0x0802be86: 0000        movs	r0, r0
@   0x0802be88: 5330        strh	r0, [r6, r4]
@   0x0802be8a: 0300        lsls	r0, r0, #12
@   0x0802be8c: be90        bkpt	0x0090
@   0x0802be8e: 0802        lsrs	r2, r0, #32
@   0x0802be90: bef6        bkpt	0x00f6
@   0x0802be92: 0802        lsrs	r2, r0, #32
@   0x0802be94: beae        bkpt	0x00ae
@   0x0802be96: 0802        lsrs	r2, r0, #32
@   0x0802be98: bef6        bkpt	0x00f6
@   0x0802be9a: 0802        lsrs	r2, r0, #32
@   0x0802be9c: bea4        bkpt	0x00a4
@   0x0802be9e: 0802        lsrs	r2, r0, #32
@   0x0802bea0: bec8        bkpt	0x00c8
@   0x0802bea2: 0802        lsrs	r2, r0, #32
@   0x0802bea4: 4805        ldr	r0, [pc, #20]	@ (0x2bebc)
@   0x0802bea6: 1811        adds	r1, r2, r0
@   0x0802bea8: 4805        ldr	r0, [pc, #20]	@ (0x2bec0)
@   0x0802beaa: 6800        ldr	r0, [r0, #0]
@   0x0802beac: 6008        str	r0, [r1, #0]
@   0x0802beae: 4b05        ldr	r3, [pc, #20]	@ (0x2bec4)
@   0x0802beb0: 18d1        adds	r1, r2, r3
@   0x0802beb2: 8808        ldrh	r0, [r1, #0]
@   0x0802beb4: 3001        adds	r0, #1
@   0x0802beb6: 8008        strh	r0, [r1, #0]
@   0x0802beb8: e01d        b.n	0x2bef6
@   0x0802beba: 0000        movs	r0, r0
@   0x0802bebc: 0b1c        lsrs	r4, r3, #12
@   0x0802bebe: 0000        movs	r0, r0
@   0x0802bec0: 5330        strh	r0, [r6, r4]
@   0x0802bec2: 0300        lsls	r0, r0, #12
@   0x0802bec4: 0af2        lsrs	r2, r6, #11
@   0x0802bec6: 0000        movs	r0, r0
@   0x0802bec8: 4a07        ldr	r2, [pc, #28]	@ (0x2bee8)
@   0x0802beca: 1c11        adds	r1, r2, #0
@   0x0802becc: 312b        adds	r1, #43	@ 0x2b
@   0x0802bece: 7808        ldrb	r0, [r1, #0]
@   0x0802bed0: 3001        adds	r0, #1
@   0x0802bed2: 7008        strb	r0, [r1, #0]
@   0x0802bed4: 0600        lsls	r0, r0, #24
@   0x0802bed6: 0e00        lsrs	r0, r0, #24
@   0x0802bed8: 2806        cmp	r0, #6
@   0x0802beda: d107        bne.n	0x2beec
@   0x0802bedc: 1c10        adds	r0, r2, #0
@   0x0802bede: 2103        movs	r1, #3
@   0x0802bee0: 2206        movs	r2, #6
@   0x0802bee2: f7da        fb8d 	bl	0x6600
@   0x0802bee6: e006        b.n	0x2bef6
@   0x0802bee8: 6110        str	r0, [r2, #16]
@   0x0802beea: 0300        lsls	r0, r0, #12
@   0x0802beec: 1c10        adds	r0, r2, #0
@   0x0802beee: 2103        movs	r1, #3
@   0x0802bef0: 2205        movs	r2, #5
@   0x0802bef2: f7da        fb85 	bl	0x6600
@   0x0802bef6: 4914        ldr	r1, [pc, #80]	@ (0x2bf48)
@   0x0802bef8: 2001        movs	r0, #1
@   0x0802befa: 7c09        ldrb	r1, [r1, #16]
@   0x0802befc: 4008        ands	r0, r1
@   0x0802befe: 2800        cmp	r0, #0
@   0x0802bf00: d11e        bne.n	0x2bf40
@   0x0802bf02: 4912        ldr	r1, [pc, #72]	@ (0x2bf4c)
@   0x0802bf04: 2004        movs	r0, #4
@   0x0802bf06: 8e8a        ldrh	r2, [r1, #52]	@ 0x34
@   0x0802bf08: 4010        ands	r0, r2
@   0x0802bf0a: 2800        cmp	r0, #0
@   0x0802bf0c: d118        bne.n	0x2bf40
@   0x0802bf0e: 4b10        ldr	r3, [pc, #64]	@ (0x2bf50)
@   0x0802bf10: 18c8        adds	r0, r1, r3
@   0x0802bf12: 8800        ldrh	r0, [r0, #0]
@   0x0802bf14: 3802        subs	r0, #2
@   0x0802bf16: 0400        lsls	r0, r0, #16
@   0x0802bf18: 0c00        lsrs	r0, r0, #16
@   0x0802bf1a: 2801        cmp	r0, #1
@   0x0802bf1c: d810        bhi.n	0x2bf40
@   0x0802bf1e: 480d        ldr	r0, [pc, #52]	@ (0x2bf54)
@   0x0802bf20: 2208        movs	r2, #8
@   0x0802bf22: 5e81        ldrsh	r1, [r0, r2]
@   0x0802bf24: 2901        cmp	r1, #1
@   0x0802bf26: d007        beq.n	0x2bf38
@   0x0802bf28: 290c        cmp	r1, #12
@   0x0802bf2a: d005        beq.n	0x2bf38
@   0x0802bf2c: 230a        movs	r3, #10
@   0x0802bf2e: 5ec1        ldrsh	r1, [r0, r3]
@   0x0802bf30: 2904        cmp	r1, #4
@   0x0802bf32: d001        beq.n	0x2bf38
@   0x0802bf34: 290b        cmp	r1, #11
@   0x0802bf36: d103        bne.n	0x2bf40
@   0x0802bf38: 2180        movs	r1, #128	@ 0x80
@   0x0802bf3a: 00c9        lsls	r1, r1, #3
@   0x0802bf3c: f7da        fe24 	bl	0x6b88
@   0x0802bf40: bc30        pop	{r4, r5}
@   0x0802bf42: bc01        pop	{r0}
@   0x0802bf44: 4700        bx	r0
@   0x0802bf46: 0000        movs	r0, r0
@   0x0802bf48: 5330        strh	r0, [r6, r4]
@   0x0802bf4a: 0300        lsls	r0, r0, #12
@   0x0802bf4c: 3720        adds	r7, #32
@   0x0802bf4e: 0300        lsls	r0, r0, #12
@   0x0802bf50: 0af2        lsrs	r2, r6, #11
@   0x0802bf52: 0000        movs	r0, r0
@   0x0802bf54: 35e0        adds	r5, #224	@ 0xe0
@   0x0802bf56: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0802BDBC
sub_0802BDBC: @ 0x0802bdbc
        .incbin "frog_us_baserom.gba", 0x2bdbc, 0x19c
        thumb_func_end sub_0802BDBC
