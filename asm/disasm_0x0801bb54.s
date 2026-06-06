@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801bb54, 0x0801be7c)  (808 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801bb54 --end 0x801be7c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801bb54: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801bb56: 464f        mov	r7, r9
@   0x0801bb58: 4646        mov	r6, r8
@   0x0801bb5a: b4c0        push	{r6, r7}
@   0x0801bb5c: b088        sub	sp, #32
@   0x0801bb5e: 0600        lsls	r0, r0, #24
@   0x0801bb60: 0e04        lsrs	r4, r0, #24
@   0x0801bb62: a903        add	r1, sp, #12
@   0x0801bb64: 480c        ldr	r0, [pc, #48]	@ (0x1bb98)
@   0x0801bb66: c82c        ldmia	r0!, {r2, r3, r5}
@   0x0801bb68: c12c        stmia	r1!, {r2, r3, r5}
@   0x0801bb6a: c80c        ldmia	r0!, {r2, r3}
@   0x0801bb6c: c10c        stmia	r1!, {r2, r3}
@   0x0801bb6e: f7f2        fdfd 	bl	0xe76c
@   0x0801bb72: 480a        ldr	r0, [pc, #40]	@ (0x1bb9c)
@   0x0801bb74: 8800        ldrh	r0, [r0, #0]
@   0x0801bb76: 4681        mov	r9, r0
@   0x0801bb78: 250a        movs	r5, #10
@   0x0801bb7a: 46a8        mov	r8, r5
@   0x0801bb7c: 4808        ldr	r0, [pc, #32]	@ (0x1bba0)
@   0x0801bb7e: 7a85        ldrb	r5, [r0, #10]
@   0x0801bb80: 2d0f        cmp	r5, #15
@   0x0801bb82: d100        bne.n	0x1bb86
@   0x0801bb84: e16d        b.n	0x1be62
@   0x0801bb86: 2c04        cmp	r4, #4
@   0x0801bb88: d900        bls.n	0x1bb8c
@   0x0801bb8a: e157        b.n	0x1be3c
@   0x0801bb8c: 00a0        lsls	r0, r4, #2
@   0x0801bb8e: 4905        ldr	r1, [pc, #20]	@ (0x1bba4)
@   0x0801bb90: 1840        adds	r0, r0, r1
@   0x0801bb92: 6800        ldr	r0, [r0, #0]
@   0x0801bb94: 4687        mov	pc, r0
@   0x0801bb96: 0000        movs	r0, r0
@   0x0801bb98: dff4        svc	244	@ 0xf4
@   0x0801bb9a: 081b        lsrs	r3, r3, #32
@   0x0801bb9c: 01da        lsls	r2, r3, #7
@   0x0801bb9e: 0500        lsls	r0, r0, #20
@   0x0801bba0: 5330        strh	r0, [r6, r4]
@   0x0801bba2: 0300        lsls	r0, r0, #12
@   0x0801bba4: bba8        cbnz	r0, 0x1bc12
@   0x0801bba6: 0801        lsrs	r1, r0, #32
@   0x0801bba8: be3c        bkpt	0x003c
@   0x0801bbaa: 0801        lsrs	r1, r0, #32
@   0x0801bbac: bbbc        cbnz	r4, 0x1bc1e
@   0x0801bbae: 0801        lsrs	r1, r0, #32
@   0x0801bbb0: bc90        pop	{r4, r7}
@   0x0801bbb2: 0801        lsrs	r1, r0, #32
@   0x0801bbb4: bdac        pop	{r2, r3, r5, r7, pc}
@   0x0801bbb6: 0801        lsrs	r1, r0, #32
@   0x0801bbb8: bdf8        pop	{r3, r4, r5, r6, r7, pc}
@   0x0801bbba: 0801        lsrs	r1, r0, #32
@   0x0801bbbc: 4808        ldr	r0, [pc, #32]	@ (0x1bbe0)
@   0x0801bbbe: 6801        ldr	r1, [r0, #0]
@   0x0801bbc0: 0089        lsls	r1, r1, #2
@   0x0801bbc2: 4469        add	r1, sp
@   0x0801bbc4: 310c        adds	r1, #12
@   0x0801bbc6: 680c        ldr	r4, [r1, #0]
@   0x0801bbc8: 2600        movs	r6, #0
@   0x0801bbca: 2100        movs	r1, #0
@   0x0801bbcc: 1c07        adds	r7, r0, #0
@   0x0801bbce: 7820        ldrb	r0, [r4, #0]
@   0x0801bbd0: 287c        cmp	r0, #124	@ 0x7c
@   0x0801bbd2: d011        beq.n	0x1bbf8
@   0x0801bbd4: 1860        adds	r0, r4, r1
@   0x0801bbd6: 7800        ldrb	r0, [r0, #0]
@   0x0801bbd8: 285b        cmp	r0, #91	@ 0x5b
@   0x0801bbda: d103        bne.n	0x1bbe4
@   0x0801bbdc: 1d08        adds	r0, r1, #4
@   0x0801bbde: e002        b.n	0x1bbe6
@   0x0801bbe0: 34b0        adds	r4, #176	@ 0xb0
@   0x0801bbe2: 0300        lsls	r0, r0, #12
@   0x0801bbe4: 1c48        adds	r0, r1, #1
@   0x0801bbe6: 0600        lsls	r0, r0, #24
@   0x0801bbe8: 0e01        lsrs	r1, r0, #24
@   0x0801bbea: 1c70        adds	r0, r6, #1
@   0x0801bbec: 0600        lsls	r0, r0, #24
@   0x0801bbee: 0e06        lsrs	r6, r0, #24
@   0x0801bbf0: 1860        adds	r0, r4, r1
@   0x0801bbf2: 7800        ldrb	r0, [r0, #0]
@   0x0801bbf4: 287c        cmp	r0, #124	@ 0x7c
@   0x0801bbf6: d1ed        bne.n	0x1bbd4
@   0x0801bbf8: 201e        movs	r0, #30
@   0x0801bbfa: 1b80        subs	r0, r0, r6
@   0x0801bbfc: 0fc1        lsrs	r1, r0, #31
@   0x0801bbfe: 1840        adds	r0, r0, r1
@   0x0801bc00: 1040        asrs	r0, r0, #1
@   0x0801bc02: 0600        lsls	r0, r0, #24
@   0x0801bc04: 0e02        lsrs	r2, r0, #24
@   0x0801bc06: 6838        ldr	r0, [r7, #0]
@   0x0801bc08: 0080        lsls	r0, r0, #2
@   0x0801bc0a: 4468        add	r0, sp
@   0x0801bc0c: 300c        adds	r0, #12
@   0x0801bc0e: 6800        ldr	r0, [r0, #0]
@   0x0801bc10: 218b        movs	r1, #139	@ 0x8b
@   0x0801bc12: 0049        lsls	r1, r1, #1
@   0x0801bc14: 9100        str	r1, [sp, #0]
@   0x0801bc16: 210e        movs	r1, #14
@   0x0801bc18: 9101        str	r1, [sp, #4]
@   0x0801bc1a: 2103        movs	r1, #3
@   0x0801bc1c: 9102        str	r1, [sp, #8]
@   0x0801bc1e: 1c31        adds	r1, r6, #0
@   0x0801bc20: 4643        mov	r3, r8
@   0x0801bc22: f000        f92b 	bl	0x1be7c
@   0x0801bc26: 4802        ldr	r0, [pc, #8]	@ (0x1bc30)
@   0x0801bc28: 7800        ldrb	r0, [r0, #0]
@   0x0801bc2a: 2800        cmp	r0, #0
@   0x0801bc2c: d014        beq.n	0x1bc58
@   0x0801bc2e: e006        b.n	0x1bc3e
@   0x0801bc30: 34b4        adds	r4, #180	@ 0xb4
@   0x0801bc32: 0300        lsls	r0, r0, #12
@   0x0801bc34: f7fb        f9e4 	bl	0x17000
@   0x0801bc38: f7e4        fc44 	bl	0x4c4
@   0x0801bc3c: 8020        strh	r0, [r4, #0]
@   0x0801bc3e: f016        fa83 	bl	0x32148
@   0x0801bc42: 2800        cmp	r0, #0
@   0x0801bc44: d100        bne.n	0x1bc48
@   0x0801bc46: e0a4        b.n	0x1bd92
@   0x0801bc48: 4c02        ldr	r4, [pc, #8]	@ (0x1bc54)
@   0x0801bc4a: 8820        ldrh	r0, [r4, #0]
@   0x0801bc4c: 2800        cmp	r0, #0
@   0x0801bc4e: d0f1        beq.n	0x1bc34
@   0x0801bc50: e09f        b.n	0x1bd92
@   0x0801bc52: 0000        movs	r0, r0
@   0x0801bc54: 5398        strh	r0, [r3, r6]
@   0x0801bc56: 0300        lsls	r0, r0, #12
@   0x0801bc58: f7e4        fe52 	bl	0x900
@   0x0801bc5c: 1c05        adds	r5, r0, #0
@   0x0801bc5e: 490b        ldr	r1, [pc, #44]	@ (0x1bc8c)
@   0x0801bc60: 8808        ldrh	r0, [r1, #0]
@   0x0801bc62: 2800        cmp	r0, #0
@   0x0801bc64: d000        beq.n	0x1bc68
@   0x0801bc66: e094        b.n	0x1bd92
@   0x0801bc68: 1c0c        adds	r4, r1, #0
@   0x0801bc6a: f7e4        fc2b 	bl	0x4c4
@   0x0801bc6e: 8020        strh	r0, [r4, #0]
@   0x0801bc70: f7fb        f9c6 	bl	0x17000
@   0x0801bc74: f7e4        fe44 	bl	0x900
@   0x0801bc78: 1b40        subs	r0, r0, r5
@   0x0801bc7a: 2878        cmp	r0, #120	@ 0x78
@   0x0801bc7c: d901        bls.n	0x1bc82
@   0x0801bc7e: 2010        movs	r0, #16
@   0x0801bc80: 8020        strh	r0, [r4, #0]
@   0x0801bc82: 8820        ldrh	r0, [r4, #0]
@   0x0801bc84: 2800        cmp	r0, #0
@   0x0801bc86: d0f0        beq.n	0x1bc6a
@   0x0801bc88: e083        b.n	0x1bd92
@   0x0801bc8a: 0000        movs	r0, r0
@   0x0801bc8c: 5398        strh	r0, [r3, r6]
@   0x0801bc8e: 0300        lsls	r0, r0, #12
@   0x0801bc90: 1c28        adds	r0, r5, #0
@   0x0801bc92: 2103        movs	r1, #3
@   0x0801bc94: f018        f962 	bl	0x33f5c
@   0x0801bc98: 0600        lsls	r0, r0, #24
@   0x0801bc9a: 2800        cmp	r0, #0
@   0x0801bc9c: d101        bne.n	0x1bca2
@   0x0801bc9e: 2d00        cmp	r5, #0
@   0x0801bca0: d101        bne.n	0x1bca6
@   0x0801bca2: 2d10        cmp	r5, #16
@   0x0801bca4: d175        bne.n	0x1bd92
@   0x0801bca6: 1c28        adds	r0, r5, #0
@   0x0801bca8: 2103        movs	r1, #3
@   0x0801bcaa: f018        f91b 	bl	0x33ee4
@   0x0801bcae: 0600        lsls	r0, r0, #24
@   0x0801bcb0: 23ff        movs	r3, #255	@ 0xff
@   0x0801bcb2: 061b        lsls	r3, r3, #24
@   0x0801bcb4: 18c0        adds	r0, r0, r3
@   0x0801bcb6: 0e05        lsrs	r5, r0, #24
@   0x0801bcb8: 4b0a        ldr	r3, [pc, #40]	@ (0x1bce4)
@   0x0801bcba: 4a0b        ldr	r2, [pc, #44]	@ (0x1bce8)
@   0x0801bcbc: 6810        ldr	r0, [r2, #0]
@   0x0801bcbe: 0080        lsls	r0, r0, #2
@   0x0801bcc0: 18c0        adds	r0, r0, r3
@   0x0801bcc2: 6801        ldr	r1, [r0, #0]
@   0x0801bcc4: 00a8        lsls	r0, r5, #2
@   0x0801bcc6: 1840        adds	r0, r0, r1
@   0x0801bcc8: 6804        ldr	r4, [r0, #0]
@   0x0801bcca: 2600        movs	r6, #0
@   0x0801bccc: 2100        movs	r1, #0
@   0x0801bcce: 1c17        adds	r7, r2, #0
@   0x0801bcd0: 7820        ldrb	r0, [r4, #0]
@   0x0801bcd2: 287c        cmp	r0, #124	@ 0x7c
@   0x0801bcd4: d014        beq.n	0x1bd00
@   0x0801bcd6: 1860        adds	r0, r4, r1
@   0x0801bcd8: 7800        ldrb	r0, [r0, #0]
@   0x0801bcda: 285b        cmp	r0, #91	@ 0x5b
@   0x0801bcdc: d106        bne.n	0x1bcec
@   0x0801bcde: 1d08        adds	r0, r1, #4
@   0x0801bce0: e005        b.n	0x1bcee
@   0x0801bce2: 0000        movs	r0, r0
@   0x0801bce4: 87b4        strh	r4, [r6, #60]	@ 0x3c
@   0x0801bce6: 0830        lsrs	r0, r6, #32
@   0x0801bce8: 34b0        adds	r4, #176	@ 0xb0
@   0x0801bcea: 0300        lsls	r0, r0, #12
@   0x0801bcec: 1c48        adds	r0, r1, #1
@   0x0801bcee: 0600        lsls	r0, r0, #24
@   0x0801bcf0: 0e01        lsrs	r1, r0, #24
@   0x0801bcf2: 1c70        adds	r0, r6, #1
@   0x0801bcf4: 0600        lsls	r0, r0, #24
@   0x0801bcf6: 0e06        lsrs	r6, r0, #24
@   0x0801bcf8: 1860        adds	r0, r4, r1
@   0x0801bcfa: 7800        ldrb	r0, [r0, #0]
@   0x0801bcfc: 287c        cmp	r0, #124	@ 0x7c
@   0x0801bcfe: d1ea        bne.n	0x1bcd6
@   0x0801bd00: 201e        movs	r0, #30
@   0x0801bd02: 1b80        subs	r0, r0, r6
@   0x0801bd04: 0fc1        lsrs	r1, r0, #31
@   0x0801bd06: 1840        adds	r0, r0, r1
@   0x0801bd08: 1040        asrs	r0, r0, #1
@   0x0801bd0a: 0600        lsls	r0, r0, #24
@   0x0801bd0c: 0e02        lsrs	r2, r0, #24
@   0x0801bd0e: 6838        ldr	r0, [r7, #0]
@   0x0801bd10: 0080        lsls	r0, r0, #2
@   0x0801bd12: 18c0        adds	r0, r0, r3
@   0x0801bd14: 6801        ldr	r1, [r0, #0]
@   0x0801bd16: 00a8        lsls	r0, r5, #2
@   0x0801bd18: 1840        adds	r0, r0, r1
@   0x0801bd1a: 6800        ldr	r0, [r0, #0]
@   0x0801bd1c: 218b        movs	r1, #139	@ 0x8b
@   0x0801bd1e: 0049        lsls	r1, r1, #1
@   0x0801bd20: 9100        str	r1, [sp, #0]
@   0x0801bd22: 210e        movs	r1, #14
@   0x0801bd24: 9101        str	r1, [sp, #4]
@   0x0801bd26: 2103        movs	r1, #3
@   0x0801bd28: 9102        str	r1, [sp, #8]
@   0x0801bd2a: 1c31        adds	r1, r6, #0
@   0x0801bd2c: 4643        mov	r3, r8
@   0x0801bd2e: f000        f8a5 	bl	0x1be7c
@   0x0801bd32: f7e4        fde5 	bl	0x900
@   0x0801bd36: 4802        ldr	r0, [pc, #8]	@ (0x1bd40)
@   0x0801bd38: 7800        ldrb	r0, [r0, #0]
@   0x0801bd3a: 2800        cmp	r0, #0
@   0x0801bd3c: d012        beq.n	0x1bd64
@   0x0801bd3e: e006        b.n	0x1bd4e
@   0x0801bd40: 34b4        adds	r4, #180	@ 0xb4
@   0x0801bd42: 0300        lsls	r0, r0, #12
@   0x0801bd44: f7e4        fbbe 	bl	0x4c4
@   0x0801bd48: 8020        strh	r0, [r4, #0]
@   0x0801bd4a: f7fb        f959 	bl	0x17000
@   0x0801bd4e: f016        f9fb 	bl	0x32148
@   0x0801bd52: 2800        cmp	r0, #0
@   0x0801bd54: d01d        beq.n	0x1bd92
@   0x0801bd56: 4c02        ldr	r4, [pc, #8]	@ (0x1bd60)
@   0x0801bd58: 8820        ldrh	r0, [r4, #0]
@   0x0801bd5a: 2800        cmp	r0, #0
@   0x0801bd5c: d0f2        beq.n	0x1bd44
@   0x0801bd5e: e018        b.n	0x1bd92
@   0x0801bd60: 5398        strh	r0, [r3, r6]
@   0x0801bd62: 0300        lsls	r0, r0, #12
@   0x0801bd64: f7e4        fdcc 	bl	0x900
@   0x0801bd68: 1c05        adds	r5, r0, #0
@   0x0801bd6a: 490e        ldr	r1, [pc, #56]	@ (0x1bda4)
@   0x0801bd6c: 8808        ldrh	r0, [r1, #0]
@   0x0801bd6e: 2800        cmp	r0, #0
@   0x0801bd70: d10f        bne.n	0x1bd92
@   0x0801bd72: 1c0c        adds	r4, r1, #0
@   0x0801bd74: f7e4        fba6 	bl	0x4c4
@   0x0801bd78: 8020        strh	r0, [r4, #0]
@   0x0801bd7a: f7fb        f941 	bl	0x17000
@   0x0801bd7e: f7e4        fdbf 	bl	0x900
@   0x0801bd82: 1b40        subs	r0, r0, r5
@   0x0801bd84: 2878        cmp	r0, #120	@ 0x78
@   0x0801bd86: d901        bls.n	0x1bd8c
@   0x0801bd88: 2010        movs	r0, #16
@   0x0801bd8a: 8020        strh	r0, [r4, #0]
@   0x0801bd8c: 8820        ldrh	r0, [r4, #0]
@   0x0801bd8e: 2800        cmp	r0, #0
@   0x0801bd90: d0f0        beq.n	0x1bd74
@   0x0801bd92: f004        ff0b 	bl	0x20bac
@   0x0801bd96: 4804        ldr	r0, [pc, #16]	@ (0x1bda8)
@   0x0801bd98: 2102        movs	r1, #2
@   0x0801bd9a: 7802        ldrb	r2, [r0, #0]
@   0x0801bd9c: 4311        orrs	r1, r2
@   0x0801bd9e: 7001        strb	r1, [r0, #0]
@   0x0801bda0: e04c        b.n	0x1be3c
@   0x0801bda2: 0000        movs	r0, r0
@   0x0801bda4: 5398        strh	r0, [r3, r6]
@   0x0801bda6: 0300        lsls	r0, r0, #12
@   0x0801bda8: 3570        adds	r5, #112	@ 0x70
@   0x0801bdaa: 0300        lsls	r0, r0, #12
@   0x0801bdac: 4808        ldr	r0, [pc, #32]	@ (0x1bdd0)
@   0x0801bdae: 218b        movs	r1, #139	@ 0x8b
@   0x0801bdb0: 0049        lsls	r1, r1, #1
@   0x0801bdb2: 9100        str	r1, [sp, #0]
@   0x0801bdb4: 210e        movs	r1, #14
@   0x0801bdb6: 9101        str	r1, [sp, #4]
@   0x0801bdb8: 2103        movs	r1, #3
@   0x0801bdba: 9102        str	r1, [sp, #8]
@   0x0801bdbc: 2107        movs	r1, #7
@   0x0801bdbe: 220b        movs	r2, #11
@   0x0801bdc0: 4643        mov	r3, r8
@   0x0801bdc2: f000        f85b 	bl	0x1be7c
@   0x0801bdc6: f7e4        fd9b 	bl	0x900
@   0x0801bdca: 1c05        adds	r5, r0, #0
@   0x0801bdcc: e007        b.n	0x1bdde
@   0x0801bdce: 0000        movs	r0, r0
@   0x0801bdd0: e008        b.n	0x1bde4
@   0x0801bdd2: 081b        lsrs	r3, r3, #32
@   0x0801bdd4: f7fb        f914 	bl	0x17000
@   0x0801bdd8: f7e4        fb74 	bl	0x4c4
@   0x0801bddc: 8020        strh	r0, [r4, #0]
@   0x0801bdde: f7e4        fd8f 	bl	0x900
@   0x0801bde2: 1b40        subs	r0, r0, r5
@   0x0801bde4: 28b3        cmp	r0, #179	@ 0xb3
@   0x0801bde6: d829        bhi.n	0x1be3c
@   0x0801bde8: 4c02        ldr	r4, [pc, #8]	@ (0x1bdf4)
@   0x0801bdea: 8820        ldrh	r0, [r4, #0]
@   0x0801bdec: 2800        cmp	r0, #0
@   0x0801bdee: d0f1        beq.n	0x1bdd4
@   0x0801bdf0: e024        b.n	0x1be3c
@   0x0801bdf2: 0000        movs	r0, r0
@   0x0801bdf4: 5398        strh	r0, [r3, r6]
@   0x0801bdf6: 0300        lsls	r0, r0, #12
@   0x0801bdf8: 4808        ldr	r0, [pc, #32]	@ (0x1be1c)
@   0x0801bdfa: 218b        movs	r1, #139	@ 0x8b
@   0x0801bdfc: 0049        lsls	r1, r1, #1
@   0x0801bdfe: 9100        str	r1, [sp, #0]
@   0x0801be00: 210e        movs	r1, #14
@   0x0801be02: 9101        str	r1, [sp, #4]
@   0x0801be04: 2103        movs	r1, #3
@   0x0801be06: 9102        str	r1, [sp, #8]
@   0x0801be08: 2108        movs	r1, #8
@   0x0801be0a: 220b        movs	r2, #11
@   0x0801be0c: 4643        mov	r3, r8
@   0x0801be0e: f000        f835 	bl	0x1be7c
@   0x0801be12: f7e4        fd75 	bl	0x900
@   0x0801be16: 1c05        adds	r5, r0, #0
@   0x0801be18: e007        b.n	0x1be2a
@   0x0801be1a: 0000        movs	r0, r0
@   0x0801be1c: e010        b.n	0x1be40
@   0x0801be1e: 081b        lsrs	r3, r3, #32
@   0x0801be20: f7fb        f8ee 	bl	0x17000
@   0x0801be24: f7e4        fb4e 	bl	0x4c4
@   0x0801be28: 8020        strh	r0, [r4, #0]
@   0x0801be2a: f7e4        fd69 	bl	0x900
@   0x0801be2e: 1b40        subs	r0, r0, r5
@   0x0801be30: 28b3        cmp	r0, #179	@ 0xb3
@   0x0801be32: d803        bhi.n	0x1be3c
@   0x0801be34: 4c0e        ldr	r4, [pc, #56]	@ (0x1be70)
@   0x0801be36: 8820        ldrh	r0, [r4, #0]
@   0x0801be38: 2800        cmp	r0, #0
@   0x0801be3a: d0f1        beq.n	0x1be20
@   0x0801be3c: 490c        ldr	r1, [pc, #48]	@ (0x1be70)
@   0x0801be3e: 2000        movs	r0, #0
@   0x0801be40: 8008        strh	r0, [r1, #0]
@   0x0801be42: 480c        ldr	r0, [pc, #48]	@ (0x1be74)
@   0x0801be44: 464b        mov	r3, r9
@   0x0801be46: 8003        strh	r3, [r0, #0]
@   0x0801be48: 480b        ldr	r0, [pc, #44]	@ (0x1be78)
@   0x0801be4a: 218b        movs	r1, #139	@ 0x8b
@   0x0801be4c: 0049        lsls	r1, r1, #1
@   0x0801be4e: 9100        str	r1, [sp, #0]
@   0x0801be50: 210e        movs	r1, #14
@   0x0801be52: 9101        str	r1, [sp, #4]
@   0x0801be54: 2103        movs	r1, #3
@   0x0801be56: 9102        str	r1, [sp, #8]
@   0x0801be58: 211e        movs	r1, #30
@   0x0801be5a: 2200        movs	r2, #0
@   0x0801be5c: 4643        mov	r3, r8
@   0x0801be5e: f000        f80d 	bl	0x1be7c
@   0x0801be62: b008        add	sp, #32
@   0x0801be64: bc18        pop	{r3, r4}
@   0x0801be66: 4698        mov	r8, r3
@   0x0801be68: 46a1        mov	r9, r4
@   0x0801be6a: bcf0        pop	{r4, r5, r6, r7}
@   0x0801be6c: bc01        pop	{r0}
@   0x0801be6e: 4700        bx	r0
@   0x0801be70: 5398        strh	r0, [r3, r6]
@   0x0801be72: 0300        lsls	r0, r0, #12
@   0x0801be74: 01da        lsls	r2, r3, #7
@   0x0801be76: 0500        lsls	r0, r0, #20
@   0x0801be78: e01c        b.n	0x1beb4
@   0x0801be7a: 081b        lsrs	r3, r3, #32

        thumb_func_start ShowWinLoseMessage
ShowWinLoseMessage: @ 0x0801bb54
        .incbin "frog_us_baserom.gba", 0x1bb54, 0x328
        thumb_func_end ShowWinLoseMessage
