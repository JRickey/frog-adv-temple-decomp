@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802bc94, 0x0802bdbc)  (296 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802bc94 --end 0x802bdbc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802bc94: b530        push	{r4, r5, lr}
@   0x0802bc96: 4d10        ldr	r5, [pc, #64]	@ (0x2bcd8)
@   0x0802bc98: 1c28        adds	r0, r5, #0
@   0x0802bc9a: 302b        adds	r0, #43	@ 0x2b
@   0x0802bc9c: 7804        ldrb	r4, [r0, #0]
@   0x0802bc9e: 2c00        cmp	r4, #0
@   0x0802bca0: d000        beq.n	0x2bca4
@   0x0802bca2: e080        b.n	0x2bda6
@   0x0802bca4: 1c28        adds	r0, r5, #0
@   0x0802bca6: 2103        movs	r1, #3
@   0x0802bca8: 2205        movs	r2, #5
@   0x0802bcaa: f7da        fd77 	bl	0x679c
@   0x0802bcae: 0600        lsls	r0, r0, #24
@   0x0802bcb0: 2800        cmp	r0, #0
@   0x0802bcb2: d019        beq.n	0x2bce8
@   0x0802bcb4: f7ea        f83c 	bl	0x15d30
@   0x0802bcb8: 4808        ldr	r0, [pc, #32]	@ (0x2bcdc)
@   0x0802bcba: 4a09        ldr	r2, [pc, #36]	@ (0x2bce0)
@   0x0802bcbc: 1881        adds	r1, r0, r2
@   0x0802bcbe: 700c        strb	r4, [r1, #0]
@   0x0802bcc0: 4c08        ldr	r4, [pc, #32]	@ (0x2bce4)
@   0x0802bcc2: 1900        adds	r0, r0, r4
@   0x0802bcc4: 2102        movs	r1, #2
@   0x0802bcc6: 8802        ldrh	r2, [r0, #0]
@   0x0802bcc8: 4311        orrs	r1, r2
@   0x0802bcca: 8001        strh	r1, [r0, #0]
@   0x0802bccc: 1c28        adds	r0, r5, #0
@   0x0802bcce: 2103        movs	r1, #3
@   0x0802bcd0: 2205        movs	r2, #5
@   0x0802bcd2: f7da        fcf7 	bl	0x66c4
@   0x0802bcd6: e066        b.n	0x2bda6
@   0x0802bcd8: 6110        str	r0, [r2, #16]
@   0x0802bcda: 0300        lsls	r0, r0, #12
@   0x0802bcdc: 3720        adds	r7, #32
@   0x0802bcde: 0300        lsls	r0, r0, #12
@   0x0802bce0: 04ea        lsls	r2, r5, #19
@   0x0802bce2: 0000        movs	r0, r0
@   0x0802bce4: 0504        lsls	r4, r0, #20
@   0x0802bce6: 0000        movs	r0, r0
@   0x0802bce8: 4908        ldr	r1, [pc, #32]	@ (0x2bd0c)
@   0x0802bcea: 4809        ldr	r0, [pc, #36]	@ (0x2bd10)
@   0x0802bcec: 8ec9        ldrh	r1, [r1, #54]	@ 0x36
@   0x0802bcee: 8880        ldrh	r0, [r0, #4]
@   0x0802bcf0: 1a08        subs	r0, r1, r0
@   0x0802bcf2: 0400        lsls	r0, r0, #16
@   0x0802bcf4: 1400        asrs	r0, r0, #16
@   0x0802bcf6: 2800        cmp	r0, #0
@   0x0802bcf8: da00        bge.n	0x2bcfc
@   0x0802bcfa: 4240        negs	r0, r0
@   0x0802bcfc: 0400        lsls	r0, r0, #16
@   0x0802bcfe: 1400        asrs	r0, r0, #16
@   0x0802bd00: 2847        cmp	r0, #71	@ 0x47
@   0x0802bd02: dc07        bgt.n	0x2bd14
@   0x0802bd04: 2002        movs	r0, #2
@   0x0802bd06: f7f5        f85d 	bl	0x20dc4
@   0x0802bd0a: e006        b.n	0x2bd1a
@   0x0802bd0c: 6540        str	r0, [r0, #84]	@ 0x54
@   0x0802bd0e: 0300        lsls	r0, r0, #12
@   0x0802bd10: 3720        adds	r7, #32
@   0x0802bd12: 0300        lsls	r0, r0, #12
@   0x0802bd14: 2002        movs	r0, #2
@   0x0802bd16: f7f5        f8b1 	bl	0x20e7c
@   0x0802bd1a: f7e8        fadb 	bl	0x142d4
@   0x0802bd1e: 0600        lsls	r0, r0, #24
@   0x0802bd20: 2800        cmp	r0, #0
@   0x0802bd22: d01a        beq.n	0x2bd5a
@   0x0802bd24: 2002        movs	r0, #2
@   0x0802bd26: f7f5        f8a9 	bl	0x20e7c
@   0x0802bd2a: 4a08        ldr	r2, [pc, #32]	@ (0x2bd4c)
@   0x0802bd2c: 1c11        adds	r1, r2, #0
@   0x0802bd2e: 312b        adds	r1, #43	@ 0x2b
@   0x0802bd30: 7808        ldrb	r0, [r1, #0]
@   0x0802bd32: 3001        adds	r0, #1
@   0x0802bd34: 7008        strb	r0, [r1, #0]
@   0x0802bd36: 0600        lsls	r0, r0, #24
@   0x0802bd38: 0e00        lsrs	r0, r0, #24
@   0x0802bd3a: 2801        cmp	r0, #1
@   0x0802bd3c: d108        bne.n	0x2bd50
@   0x0802bd3e: 1c10        adds	r0, r2, #0
@   0x0802bd40: 2103        movs	r1, #3
@   0x0802bd42: 2206        movs	r2, #6
@   0x0802bd44: f7da        fc5c 	bl	0x6600
@   0x0802bd48: e007        b.n	0x2bd5a
@   0x0802bd4a: 0000        movs	r0, r0
@   0x0802bd4c: 6110        str	r0, [r2, #16]
@   0x0802bd4e: 0300        lsls	r0, r0, #12
@   0x0802bd50: 1c10        adds	r0, r2, #0
@   0x0802bd52: 2103        movs	r1, #3
@   0x0802bd54: 2205        movs	r2, #5
@   0x0802bd56: f7da        fc53 	bl	0x6600
@   0x0802bd5a: 4914        ldr	r1, [pc, #80]	@ (0x2bdac)
@   0x0802bd5c: 2001        movs	r0, #1
@   0x0802bd5e: 7c09        ldrb	r1, [r1, #16]
@   0x0802bd60: 4008        ands	r0, r1
@   0x0802bd62: 2800        cmp	r0, #0
@   0x0802bd64: d11f        bne.n	0x2bda6
@   0x0802bd66: 4b12        ldr	r3, [pc, #72]	@ (0x2bdb0)
@   0x0802bd68: 2004        movs	r0, #4
@   0x0802bd6a: 8e9c        ldrh	r4, [r3, #52]	@ 0x34
@   0x0802bd6c: 4020        ands	r0, r4
@   0x0802bd6e: 2800        cmp	r0, #0
@   0x0802bd70: d119        bne.n	0x2bda6
@   0x0802bd72: 2004        movs	r0, #4
@   0x0802bd74: 5e1a        ldrsh	r2, [r3, r0]
@   0x0802bd76: 480f        ldr	r0, [pc, #60]	@ (0x2bdb4)
@   0x0802bd78: 2436        movs	r4, #54	@ 0x36
@   0x0802bd7a: 5f01        ldrsh	r1, [r0, r4]
@   0x0802bd7c: 1c08        adds	r0, r1, #0
@   0x0802bd7e: 3816        subs	r0, #22
@   0x0802bd80: 4282        cmp	r2, r0
@   0x0802bd82: dd10        ble.n	0x2bda6
@   0x0802bd84: 300c        adds	r0, #12
@   0x0802bd86: 4282        cmp	r2, r0
@   0x0802bd88: da0d        bge.n	0x2bda6
@   0x0802bd8a: 7e98        ldrb	r0, [r3, #26]
@   0x0802bd8c: 3808        subs	r0, #8
@   0x0802bd8e: 0600        lsls	r0, r0, #24
@   0x0802bd90: 0e00        lsrs	r0, r0, #24
@   0x0802bd92: 2803        cmp	r0, #3
@   0x0802bd94: d907        bls.n	0x2bda6
@   0x0802bd96: 205b        movs	r0, #91	@ 0x5b
@   0x0802bd98: f7f4        ff6e 	bl	0x20c78
@   0x0802bd9c: 4806        ldr	r0, [pc, #24]	@ (0x2bdb8)
@   0x0802bd9e: 2180        movs	r1, #128	@ 0x80
@   0x0802bda0: 01c9        lsls	r1, r1, #7
@   0x0802bda2: f7da        fef1 	bl	0x6b88
@   0x0802bda6: bc30        pop	{r4, r5}
@   0x0802bda8: bc01        pop	{r0}
@   0x0802bdaa: 4700        bx	r0
@   0x0802bdac: 5330        strh	r0, [r6, r4]
@   0x0802bdae: 0300        lsls	r0, r0, #12
@   0x0802bdb0: 3720        adds	r7, #32
@   0x0802bdb2: 0300        lsls	r0, r0, #12
@   0x0802bdb4: 6540        str	r0, [r0, #84]	@ 0x54
@   0x0802bdb6: 0300        lsls	r0, r0, #12
@   0x0802bdb8: 35e0        adds	r5, #224	@ 0xe0
@   0x0802bdba: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0802BC94
sub_0802BC94: @ 0x0802bc94
        .incbin "frog_us_baserom.gba", 0x2bc94, 0x128
        thumb_func_end sub_0802BC94
