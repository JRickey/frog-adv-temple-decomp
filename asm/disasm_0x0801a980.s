@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801a980, 0x0801aa60)  (224 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801a980 --end 0x801aa60 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801a980: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801a982: 4657        mov	r7, sl
@   0x0801a984: 464e        mov	r6, r9
@   0x0801a986: 4645        mov	r5, r8
@   0x0801a988: b4e0        push	{r5, r6, r7}
@   0x0801a98a: b081        sub	sp, #4
@   0x0801a98c: 0600        lsls	r0, r0, #24
@   0x0801a98e: 0e00        lsrs	r0, r0, #24
@   0x0801a990: 9000        str	r0, [sp, #0]
@   0x0801a992: 0609        lsls	r1, r1, #24
@   0x0801a994: 0e0c        lsrs	r4, r1, #24
@   0x0801a996: 2068        movs	r0, #104	@ 0x68
@   0x0801a998: 4680        mov	r8, r0
@   0x0801a99a: 2038        movs	r0, #56	@ 0x38
@   0x0801a99c: 1c21        adds	r1, r4, #0
@   0x0801a99e: f019        f9b9 	bl	0x33d14
@   0x0801a9a2: 0600        lsls	r0, r0, #24
@   0x0801a9a4: 0e05        lsrs	r5, r0, #24
@   0x0801a9a6: 2638        movs	r6, #56	@ 0x38
@   0x0801a9a8: 46a9        mov	r9, r5
@   0x0801a9aa: 1c60        adds	r0, r4, #1
@   0x0801a9ac: 0600        lsls	r0, r0, #24
@   0x0801a9ae: 0e04        lsrs	r4, r0, #24
@   0x0801a9b0: 2c00        cmp	r4, #0
@   0x0801a9b2: d01e        beq.n	0x1a9f2
@   0x0801a9b4: 27f0        movs	r7, #240	@ 0xf0
@   0x0801a9b6: 4924        ldr	r1, [pc, #144]	@ (0x1aa48)
@   0x0801a9b8: 468a        mov	sl, r1
@   0x0801a9ba: 4824        ldr	r0, [pc, #144]	@ (0x1aa4c)
@   0x0801a9bc: 8007        strh	r7, [r0, #0]
@   0x0801a9be: 4641        mov	r1, r8
@   0x0801a9c0: 0208        lsls	r0, r1, #8
@   0x0801a9c2: 21a0        movs	r1, #160	@ 0xa0
@   0x0801a9c4: 4308        orrs	r0, r1
@   0x0801a9c6: 4651        mov	r1, sl
@   0x0801a9c8: 8008        strh	r0, [r1, #0]
@   0x0801a9ca: 4821        ldr	r0, [pc, #132]	@ (0x1aa50)
@   0x0801a9cc: 8007        strh	r7, [r0, #0]
@   0x0801a9ce: 3004        adds	r0, #4
@   0x0801a9d0: 8006        strh	r6, [r0, #0]
@   0x0801a9d2: f7e5        ff83 	bl	0x8dc
@   0x0801a9d6: 4641        mov	r1, r8
@   0x0801a9d8: 1948        adds	r0, r1, r5
@   0x0801a9da: 0600        lsls	r0, r0, #24
@   0x0801a9dc: 0e00        lsrs	r0, r0, #24
@   0x0801a9de: 4680        mov	r8, r0
@   0x0801a9e0: 4649        mov	r1, r9
@   0x0801a9e2: 1a70        subs	r0, r6, r1
@   0x0801a9e4: 0600        lsls	r0, r0, #24
@   0x0801a9e6: 0e06        lsrs	r6, r0, #24
@   0x0801a9e8: 1e60        subs	r0, r4, #1
@   0x0801a9ea: 0600        lsls	r0, r0, #24
@   0x0801a9ec: 0e04        lsrs	r4, r0, #24
@   0x0801a9ee: 2c00        cmp	r4, #0
@   0x0801a9f0: d1e3        bne.n	0x1a9ba
@   0x0801a9f2: 4816        ldr	r0, [pc, #88]	@ (0x1aa4c)
@   0x0801a9f4: 22f0        movs	r2, #240	@ 0xf0
@   0x0801a9f6: 8002        strh	r2, [r0, #0]
@   0x0801a9f8: 4913        ldr	r1, [pc, #76]	@ (0x1aa48)
@   0x0801a9fa: 20a0        movs	r0, #160	@ 0xa0
@   0x0801a9fc: 8008        strh	r0, [r1, #0]
@   0x0801a9fe: 4814        ldr	r0, [pc, #80]	@ (0x1aa50)
@   0x0801aa00: 8002        strh	r2, [r0, #0]
@   0x0801aa02: 3102        adds	r1, #2
@   0x0801aa04: 2000        movs	r0, #0
@   0x0801aa06: 8008        strh	r0, [r1, #0]
@   0x0801aa08: 2280        movs	r2, #128	@ 0x80
@   0x0801aa0a: 04d2        lsls	r2, r2, #19
@   0x0801aa0c: 8811        ldrh	r1, [r2, #0]
@   0x0801aa0e: 4811        ldr	r0, [pc, #68]	@ (0x1aa54)
@   0x0801aa10: 4008        ands	r0, r1
@   0x0801aa12: 8010        strh	r0, [r2, #0]
@   0x0801aa14: 2001        movs	r0, #1
@   0x0801aa16: 9900        ldr	r1, [sp, #0]
@   0x0801aa18: 4008        ands	r0, r1
@   0x0801aa1a: 2800        cmp	r0, #0
@   0x0801aa1c: d003        beq.n	0x1aa26
@   0x0801aa1e: 8811        ldrh	r1, [r2, #0]
@   0x0801aa20: 480d        ldr	r0, [pc, #52]	@ (0x1aa58)
@   0x0801aa22: 4008        ands	r0, r1
@   0x0801aa24: 8010        strh	r0, [r2, #0]
@   0x0801aa26: 2002        movs	r0, #2
@   0x0801aa28: 9900        ldr	r1, [sp, #0]
@   0x0801aa2a: 4008        ands	r0, r1
@   0x0801aa2c: 2800        cmp	r0, #0
@   0x0801aa2e: d003        beq.n	0x1aa38
@   0x0801aa30: 8811        ldrh	r1, [r2, #0]
@   0x0801aa32: 480a        ldr	r0, [pc, #40]	@ (0x1aa5c)
@   0x0801aa34: 4008        ands	r0, r1
@   0x0801aa36: 8010        strh	r0, [r2, #0]
@   0x0801aa38: b001        add	sp, #4
@   0x0801aa3a: bc38        pop	{r3, r4, r5}
@   0x0801aa3c: 4698        mov	r8, r3
@   0x0801aa3e: 46a1        mov	r9, r4
@   0x0801aa40: 46aa        mov	sl, r5
@   0x0801aa42: bcf0        pop	{r4, r5, r6, r7}
@   0x0801aa44: bc01        pop	{r0}
@   0x0801aa46: 4700        bx	r0
@   0x0801aa48: 0044        lsls	r4, r0, #1
@   0x0801aa4a: 0400        lsls	r0, r0, #16
@   0x0801aa4c: 0040        lsls	r0, r0, #1
@   0x0801aa4e: 0400        lsls	r0, r0, #16
@   0x0801aa50: 0042        lsls	r2, r0, #1
@   0x0801aa52: 0400        lsls	r0, r0, #16
@   0x0801aa54: f7ff        0000 			@ <UNDEFINED> instruction: 0xf7ff0000
@   0x0801aa58: dfff        svc	255	@ 0xff
@   0x0801aa5a: 0000        movs	r0, r0
@   0x0801aa5c: bfff        itttt	<und>

        thumb_func_start sub_0801A980
sub_0801A980: @ 0x0801a980
        .incbin "frog_us_baserom.gba", 0x1a980, 0xe0
        thumb_func_end sub_0801A980
