@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801be7c, 0x0801c078)  (508 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801be7c --end 0x801c078 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801be7c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801be7e: 4657        mov	r7, sl
@   0x0801be80: 464e        mov	r6, r9
@   0x0801be82: 4645        mov	r5, r8
@   0x0801be84: b4e0        push	{r5, r6, r7}
@   0x0801be86: b082        sub	sp, #8
@   0x0801be88: 9000        str	r0, [sp, #0]
@   0x0801be8a: 980a        ldr	r0, [sp, #40]	@ 0x28
@   0x0801be8c: 9d0b        ldr	r5, [sp, #44]	@ 0x2c
@   0x0801be8e: 9c0c        ldr	r4, [sp, #48]	@ 0x30
@   0x0801be90: 0609        lsls	r1, r1, #24
@   0x0801be92: 0e09        lsrs	r1, r1, #24
@   0x0801be94: 9101        str	r1, [sp, #4]
@   0x0801be96: 0612        lsls	r2, r2, #24
@   0x0801be98: 0e16        lsrs	r6, r2, #24
@   0x0801be9a: 061b        lsls	r3, r3, #24
@   0x0801be9c: 0e1f        lsrs	r7, r3, #24
@   0x0801be9e: 0400        lsls	r0, r0, #16
@   0x0801bea0: 0c00        lsrs	r0, r0, #16
@   0x0801bea2: 4681        mov	r9, r0
@   0x0801bea4: 0624        lsls	r4, r4, #24
@   0x0801bea6: 0e24        lsrs	r4, r4, #24
@   0x0801bea8: 1c20        adds	r0, r4, #0
@   0x0801beaa: 072d        lsls	r5, r5, #28
@   0x0801beac: 0c2d        lsrs	r5, r5, #16
@   0x0801beae: 2c01        cmp	r4, #1
@   0x0801beb0: d00e        beq.n	0x1bed0
@   0x0801beb2: 2c01        cmp	r4, #1
@   0x0801beb4: dc02        bgt.n	0x1bebc
@   0x0801beb6: 2c00        cmp	r4, #0
@   0x0801beb8: d005        beq.n	0x1bec6
@   0x0801beba: e017        b.n	0x1beec
@   0x0801bebc: 2802        cmp	r0, #2
@   0x0801bebe: d00d        beq.n	0x1bedc
@   0x0801bec0: 2803        cmp	r0, #3
@   0x0801bec2: d011        beq.n	0x1bee8
@   0x0801bec4: e012        b.n	0x1beec
@   0x0801bec6: 4801        ldr	r0, [pc, #4]	@ (0x1becc)
@   0x0801bec8: e00f        b.n	0x1beea
@   0x0801beca: 0000        movs	r0, r0
@   0x0801becc: e000        b.n	0x1bed0
@   0x0801bece: 0600        lsls	r0, r0, #24
@   0x0801bed0: 4a01        ldr	r2, [pc, #4]	@ (0x1bed8)
@   0x0801bed2: 4690        mov	r8, r2
@   0x0801bed4: e00a        b.n	0x1beec
@   0x0801bed6: 0000        movs	r0, r0
@   0x0801bed8: e800        0600 			@ <UNDEFINED> instruction: 0xe8000600
@   0x0801bedc: 4b01        ldr	r3, [pc, #4]	@ (0x1bee4)
@   0x0801bede: 4698        mov	r8, r3
@   0x0801bee0: e004        b.n	0x1beec
@   0x0801bee2: 0000        movs	r0, r0
@   0x0801bee4: f000        0600 	and.w	r6, r0, #0
@   0x0801bee8: 480b        ldr	r0, [pc, #44]	@ (0x1bf18)
@   0x0801beea: 4680        mov	r8, r0
@   0x0801beec: 2200        movs	r2, #0
@   0x0801beee: 4692        mov	sl, r2
@   0x0801bef0: 9b01        ldr	r3, [sp, #4]
@   0x0801bef2: 459a        cmp	sl, r3
@   0x0801bef4: d300        bcc.n	0x1bef8
@   0x0801bef6: e0b6        b.n	0x1c066
@   0x0801bef8: 0428        lsls	r0, r5, #16
@   0x0801befa: 1404        asrs	r4, r0, #16
@   0x0801befc: 9b00        ldr	r3, [sp, #0]
@   0x0801befe: 4453        add	r3, sl
@   0x0801bf00: 781a        ldrb	r2, [r3, #0]
@   0x0801bf02: 1c10        adds	r0, r2, #0
@   0x0801bf04: 3830        subs	r0, #48	@ 0x30
@   0x0801bf06: 0600        lsls	r0, r0, #24
@   0x0801bf08: 0e00        lsrs	r0, r0, #24
@   0x0801bf0a: 2809        cmp	r0, #9
@   0x0801bf0c: d817        bhi.n	0x1bf3e
@   0x0801bf0e: 2a30        cmp	r2, #48	@ 0x30
@   0x0801bf10: d104        bne.n	0x1bf1c
@   0x0801bf12: 2109        movs	r1, #9
@   0x0801bf14: e006        b.n	0x1bf24
@   0x0801bf16: 0000        movs	r0, r0
@   0x0801bf18: f800        0600 	strb.w	r0, [r0, <undefined>]
@   0x0801bf1c: 1c10        adds	r0, r2, #0
@   0x0801bf1e: 3831        subs	r0, #49	@ 0x31
@   0x0801bf20: 0400        lsls	r0, r0, #16
@   0x0801bf22: 0c01        lsrs	r1, r0, #16
@   0x0801bf24: 01ba        lsls	r2, r7, #6
@   0x0801bf26: 0070        lsls	r0, r6, #1
@   0x0801bf28: 4440        add	r0, r8
@   0x0801bf2a: 1812        adds	r2, r2, r0
@   0x0801bf2c: 0048        lsls	r0, r1, #1
@   0x0801bf2e: 4448        add	r0, r9
@   0x0801bf30: 1829        adds	r1, r5, r0
@   0x0801bf32: 8011        strh	r1, [r2, #0]
@   0x0801bf34: 3240        adds	r2, #64	@ 0x40
@   0x0801bf36: 3001        adds	r0, #1
@   0x0801bf38: 1820        adds	r0, r4, r0
@   0x0801bf3a: 8010        strh	r0, [r2, #0]
@   0x0801bf3c: e07a        b.n	0x1c034
@   0x0801bf3e: 1c11        adds	r1, r2, #0
@   0x0801bf40: 3941        subs	r1, #65	@ 0x41
@   0x0801bf42: 0608        lsls	r0, r1, #24
@   0x0801bf44: 0e00        lsrs	r0, r0, #24
@   0x0801bf46: 2819        cmp	r0, #25
@   0x0801bf48: d905        bls.n	0x1bf56
@   0x0801bf4a: 1c11        adds	r1, r2, #0
@   0x0801bf4c: 3961        subs	r1, #97	@ 0x61
@   0x0801bf4e: 0608        lsls	r0, r1, #24
@   0x0801bf50: 0e00        lsrs	r0, r0, #24
@   0x0801bf52: 2819        cmp	r0, #25
@   0x0801bf54: d810        bhi.n	0x1bf78
@   0x0801bf56: 0409        lsls	r1, r1, #16
@   0x0801bf58: 01ba        lsls	r2, r7, #6
@   0x0801bf5a: 0070        lsls	r0, r6, #1
@   0x0801bf5c: 4440        add	r0, r8
@   0x0801bf5e: 1812        adds	r2, r2, r0
@   0x0801bf60: 0bc9        lsrs	r1, r1, #15
@   0x0801bf62: 1c08        adds	r0, r1, #0
@   0x0801bf64: 3014        adds	r0, #20
@   0x0801bf66: 4448        add	r0, r9
@   0x0801bf68: 1828        adds	r0, r5, r0
@   0x0801bf6a: 8010        strh	r0, [r2, #0]
@   0x0801bf6c: 3240        adds	r2, #64	@ 0x40
@   0x0801bf6e: 4449        add	r1, r9
@   0x0801bf70: 3115        adds	r1, #21
@   0x0801bf72: 1861        adds	r1, r4, r1
@   0x0801bf74: 8011        strh	r1, [r2, #0]
@   0x0801bf76: e05d        b.n	0x1c034
@   0x0801bf78: 2a5b        cmp	r2, #91	@ 0x5b
@   0x0801bf7a: d131        bne.n	0x1bfe0
@   0x0801bf7c: 7918        ldrb	r0, [r3, #4]
@   0x0801bf7e: 285d        cmp	r0, #93	@ 0x5d
@   0x0801bf80: d12e        bne.n	0x1bfe0
@   0x0801bf82: 1c58        adds	r0, r3, #1
@   0x0801bf84: 2103        movs	r1, #3
@   0x0801bf86: f000        ff9b 	bl	0x1cec0
@   0x0801bf8a: 1c02        adds	r2, r0, #0
@   0x0801bf8c: 2a05        cmp	r2, #5
@   0x0801bf8e: d80a        bhi.n	0x1bfa6
@   0x0801bf90: 1e70        subs	r0, r6, #1
@   0x0801bf92: 0600        lsls	r0, r0, #24
@   0x0801bf94: 0e06        lsrs	r6, r0, #24
@   0x0801bf96: 01b9        lsls	r1, r7, #6
@   0x0801bf98: 0070        lsls	r0, r6, #1
@   0x0801bf9a: 4440        add	r0, r8
@   0x0801bf9c: 1809        adds	r1, r1, r0
@   0x0801bf9e: 3940        subs	r1, #64	@ 0x40
@   0x0801bfa0: 23c0        movs	r3, #192	@ 0xc0
@   0x0801bfa2: 005b        lsls	r3, r3, #1
@   0x0801bfa4: e00e        b.n	0x1bfc4
@   0x0801bfa6: 3a06        subs	r2, #6
@   0x0801bfa8: 2a06        cmp	r2, #6
@   0x0801bfaa: d80e        bhi.n	0x1bfca
@   0x0801bfac: 01b9        lsls	r1, r7, #6
@   0x0801bfae: 0070        lsls	r0, r6, #1
@   0x0801bfb0: 4440        add	r0, r8
@   0x0801bfb2: 1809        adds	r1, r1, r0
@   0x0801bfb4: 0052        lsls	r2, r2, #1
@   0x0801bfb6: 23c3        movs	r3, #195	@ 0xc3
@   0x0801bfb8: 005b        lsls	r3, r3, #1
@   0x0801bfba: 18d0        adds	r0, r2, r3
@   0x0801bfbc: 1820        adds	r0, r4, r0
@   0x0801bfbe: 8008        strh	r0, [r1, #0]
@   0x0801bfc0: 3140        adds	r1, #64	@ 0x40
@   0x0801bfc2: 3301        adds	r3, #1
@   0x0801bfc4: 18d0        adds	r0, r2, r3
@   0x0801bfc6: 1820        adds	r0, r4, r0
@   0x0801bfc8: 8008        strh	r0, [r1, #0]
@   0x0801bfca: 9801        ldr	r0, [sp, #4]
@   0x0801bfcc: 3004        adds	r0, #4
@   0x0801bfce: 0600        lsls	r0, r0, #24
@   0x0801bfd0: 0e00        lsrs	r0, r0, #24
@   0x0801bfd2: 9001        str	r0, [sp, #4]
@   0x0801bfd4: 4650        mov	r0, sl
@   0x0801bfd6: 3004        adds	r0, #4
@   0x0801bfd8: 0600        lsls	r0, r0, #24
@   0x0801bfda: 0e00        lsrs	r0, r0, #24
@   0x0801bfdc: 4682        mov	sl, r0
@   0x0801bfde: e029        b.n	0x1c034
@   0x0801bfe0: 2a20        cmp	r2, #32
@   0x0801bfe2: d108        bne.n	0x1bff6
@   0x0801bfe4: 01b8        lsls	r0, r7, #6
@   0x0801bfe6: 0071        lsls	r1, r6, #1
@   0x0801bfe8: 4441        add	r1, r8
@   0x0801bfea: 1840        adds	r0, r0, r1
@   0x0801bfec: 2100        movs	r1, #0
@   0x0801bfee: 8001        strh	r1, [r0, #0]
@   0x0801bff0: 3040        adds	r0, #64	@ 0x40
@   0x0801bff2: 8001        strh	r1, [r0, #0]
@   0x0801bff4: e01e        b.n	0x1c034
@   0x0801bff6: 2a2a        cmp	r2, #42	@ 0x2a
@   0x0801bff8: d10a        bne.n	0x1c010
@   0x0801bffa: 01b9        lsls	r1, r7, #6
@   0x0801bffc: 0070        lsls	r0, r6, #1
@   0x0801bffe: 4440        add	r0, r8
@   0x0801c000: 1809        adds	r1, r1, r0
@   0x0801c002: 1c28        adds	r0, r5, #0
@   0x0801c004: 3024        adds	r0, #36	@ 0x24
@   0x0801c006: 8008        strh	r0, [r1, #0]
@   0x0801c008: 3140        adds	r1, #64	@ 0x40
@   0x0801c00a: 381b        subs	r0, #27
@   0x0801c00c: 8008        strh	r0, [r1, #0]
@   0x0801c00e: e011        b.n	0x1c034
@   0x0801c010: 2a7e        cmp	r2, #126	@ 0x7e
@   0x0801c012: d109        bne.n	0x1c028
@   0x0801c014: 01b8        lsls	r0, r7, #6
@   0x0801c016: 0071        lsls	r1, r6, #1
@   0x0801c018: 4441        add	r1, r8
@   0x0801c01a: 1840        adds	r0, r0, r1
@   0x0801c01c: 22c9        movs	r2, #201	@ 0xc9
@   0x0801c01e: 0052        lsls	r2, r2, #1
@   0x0801c020: 1c11        adds	r1, r2, #0
@   0x0801c022: 1869        adds	r1, r5, r1
@   0x0801c024: 8001        strh	r1, [r0, #0]
@   0x0801c026: e005        b.n	0x1c034
@   0x0801c028: 2a0a        cmp	r2, #10
@   0x0801c02a: d103        bne.n	0x1c034
@   0x0801c02c: 2600        movs	r6, #0
@   0x0801c02e: 1cf8        adds	r0, r7, #3
@   0x0801c030: 0600        lsls	r0, r0, #24
@   0x0801c032: 0e07        lsrs	r7, r0, #24
@   0x0801c034: 2e1c        cmp	r6, #28
@   0x0801c036: d906        bls.n	0x1c046
@   0x0801c038: 2f13        cmp	r7, #19
@   0x0801c03a: d804        bhi.n	0x1c046
@   0x0801c03c: 2600        movs	r6, #0
@   0x0801c03e: 1c78        adds	r0, r7, #1
@   0x0801c040: 0600        lsls	r0, r0, #24
@   0x0801c042: 0e07        lsrs	r7, r0, #24
@   0x0801c044: e006        b.n	0x1c054
@   0x0801c046: 2e1e        cmp	r6, #30
@   0x0801c048: d901        bls.n	0x1c04e
@   0x0801c04a: 2f1e        cmp	r7, #30
@   0x0801c04c: d80b        bhi.n	0x1c066
@   0x0801c04e: 1c70        adds	r0, r6, #1
@   0x0801c050: 0600        lsls	r0, r0, #24
@   0x0801c052: 0e06        lsrs	r6, r0, #24
@   0x0801c054: 4650        mov	r0, sl
@   0x0801c056: 3001        adds	r0, #1
@   0x0801c058: 0600        lsls	r0, r0, #24
@   0x0801c05a: 0e00        lsrs	r0, r0, #24
@   0x0801c05c: 4682        mov	sl, r0
@   0x0801c05e: 9b01        ldr	r3, [sp, #4]
@   0x0801c060: 459a        cmp	sl, r3
@   0x0801c062: d200        bcs.n	0x1c066
@   0x0801c064: e74a        b.n	0x1befc
@   0x0801c066: b002        add	sp, #8
@   0x0801c068: bc38        pop	{r3, r4, r5}
@   0x0801c06a: 4698        mov	r8, r3
@   0x0801c06c: 46a1        mov	r9, r4
@   0x0801c06e: 46aa        mov	sl, r5
@   0x0801c070: bcf0        pop	{r4, r5, r6, r7}
@   0x0801c072: bc01        pop	{r0}
@   0x0801c074: 4700        bx	r0

        thumb_func_start sub_0801BE7C
sub_0801BE7C: @ 0x0801be7c
        .incbin "frog_us_baserom.gba", 0x1be7c, 0x1fc
        thumb_func_end sub_0801BE7C
