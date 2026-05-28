@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08008f98, 0x0800908c)  (244 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8008f98 --end 0x800908c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08008f98: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08008f9a: 4657        mov	r7, sl
@   0x08008f9c: 464e        mov	r6, r9
@   0x08008f9e: 4645        mov	r5, r8
@   0x08008fa0: b4e0        push	{r5, r6, r7}
@   0x08008fa2: b081        sub	sp, #4
@   0x08008fa4: 482c        ldr	r0, [pc, #176]	@ (0x9058)
@   0x08008fa6: 8841        ldrh	r1, [r0, #2]
@   0x08008fa8: 9100        str	r1, [sp, #0]
@   0x08008faa: 8882        ldrh	r2, [r0, #4]
@   0x08008fac: 4692        mov	sl, r2
@   0x08008fae: 2100        movs	r1, #0
@   0x08008fb0: 4a2a        ldr	r2, [pc, #168]	@ (0x905c)
@   0x08008fb2: 1c13        adds	r3, r2, #0
@   0x08008fb4: 3331        adds	r3, #49	@ 0x31
@   0x08008fb6: 4680        mov	r8, r0
@   0x08008fb8: 4691        mov	r9, r2
@   0x08008fba: 781b        ldrb	r3, [r3, #0]
@   0x08008fbc: 4299        cmp	r1, r3
@   0x08008fbe: da5d        bge.n	0x907c
@   0x08008fc0: 0609        lsls	r1, r1, #24
@   0x08008fc2: 1548        asrs	r0, r1, #21
@   0x08008fc4: 4c26        ldr	r4, [pc, #152]	@ (0x9060)
@   0x08008fc6: 1900        adds	r0, r0, r4
@   0x08008fc8: 7802        ldrb	r2, [r0, #0]
@   0x08008fca: 4694        mov	ip, r2
@   0x08008fcc: 2200        movs	r2, #0
@   0x08008fce: 5682        ldrsb	r2, [r0, r2]
@   0x08008fd0: 1c0f        adds	r7, r1, #0
@   0x08008fd2: 2a00        cmp	r2, #0
@   0x08008fd4: d048        beq.n	0x9068
@   0x08008fd6: 00d0        lsls	r0, r2, #3
@   0x08008fd8: 1a80        subs	r0, r0, r2
@   0x08008fda: 00c0        lsls	r0, r0, #3
@   0x08008fdc: 4c1e        ldr	r4, [pc, #120]	@ (0x9058)
@   0x08008fde: 1903        adds	r3, r0, r4
@   0x08008fe0: 2004        movs	r0, #4
@   0x08008fe2: 8e99        ldrh	r1, [r3, #52]	@ 0x34
@   0x08008fe4: 4008        ands	r0, r1
@   0x08008fe6: 2800        cmp	r0, #0
@   0x08008fe8: d13e        bne.n	0x9068
@   0x08008fea: 4642        mov	r2, r8
@   0x08008fec: 7992        ldrb	r2, [r2, #6]
@   0x08008fee: 799c        ldrb	r4, [r3, #6]
@   0x08008ff0: 42a2        cmp	r2, r4
@   0x08008ff2: d139        bne.n	0x9068
@   0x08008ff4: 8898        ldrh	r0, [r3, #4]
@   0x08008ff6: 8cda        ldrh	r2, [r3, #38]	@ 0x26
@   0x08008ff8: 1881        adds	r1, r0, r2
@   0x08008ffa: 1c18        adds	r0, r3, #0
@   0x08008ffc: 3029        adds	r0, #41	@ 0x29
@   0x08008ffe: 7800        ldrb	r0, [r0, #0]
@   0x08009000: 1a08        subs	r0, r1, r0
@   0x08009002: 0400        lsls	r0, r0, #16
@   0x08009004: 0c05        lsrs	r5, r0, #16
@   0x08009006: 0409        lsls	r1, r1, #16
@   0x08009008: 0c0e        lsrs	r6, r1, #16
@   0x0800900a: 885c        ldrh	r4, [r3, #2]
@   0x0800900c: 8c98        ldrh	r0, [r3, #36]	@ 0x24
@   0x0800900e: 1822        adds	r2, r4, r0
@   0x08009010: 1c18        adds	r0, r3, #0
@   0x08009012: 3028        adds	r0, #40	@ 0x28
@   0x08009014: 7800        ldrb	r0, [r0, #0]
@   0x08009016: 0840        lsrs	r0, r0, #1
@   0x08009018: 1a11        subs	r1, r2, r0
@   0x0800901a: 1880        adds	r0, r0, r2
@   0x0800901c: 0400        lsls	r0, r0, #16
@   0x0800901e: 0c02        lsrs	r2, r0, #16
@   0x08009020: 9c00        ldr	r4, [sp, #0]
@   0x08009022: 0420        lsls	r0, r4, #16
@   0x08009024: 0409        lsls	r1, r1, #16
@   0x08009026: 1404        asrs	r4, r0, #16
@   0x08009028: 4288        cmp	r0, r1
@   0x0800902a: db1d        blt.n	0x9068
@   0x0800902c: 0410        lsls	r0, r2, #16
@   0x0800902e: 1400        asrs	r0, r0, #16
@   0x08009030: 4284        cmp	r4, r0
@   0x08009032: dc19        bgt.n	0x9068
@   0x08009034: 4651        mov	r1, sl
@   0x08009036: 0408        lsls	r0, r1, #16
@   0x08009038: 0429        lsls	r1, r5, #16
@   0x0800903a: 1402        asrs	r2, r0, #16
@   0x0800903c: 4288        cmp	r0, r1
@   0x0800903e: db13        blt.n	0x9068
@   0x08009040: 0430        lsls	r0, r6, #16
@   0x08009042: 1400        asrs	r0, r0, #16
@   0x08009044: 4282        cmp	r2, r0
@   0x08009046: dc0f        bgt.n	0x9068
@   0x08009048: 785b        ldrb	r3, [r3, #1]
@   0x0800904a: 2b02        cmp	r3, #2
@   0x0800904c: d10c        bne.n	0x9068
@   0x0800904e: 4664        mov	r4, ip
@   0x08009050: 4a04        ldr	r2, [pc, #16]	@ (0x9064)
@   0x08009052: 7694        strb	r4, [r2, #26]
@   0x08009054: e012        b.n	0x907c
@   0x08009056: 0000        movs	r0, r0
@   0x08009058: 3720        adds	r7, #32
@   0x0800905a: 0300        lsls	r0, r0, #12
@   0x0800905c: 6110        str	r0, [r2, #16]
@   0x0800905e: 0300        lsls	r0, r0, #12
@   0x08009060: 6160        str	r0, [r4, #20]
@   0x08009062: 0300        lsls	r0, r0, #12
@   0x08009064: 35e0        adds	r5, #224	@ 0xe0
@   0x08009066: 0300        lsls	r0, r0, #12
@   0x08009068: 2180        movs	r1, #128	@ 0x80
@   0x0800906a: 0449        lsls	r1, r1, #17
@   0x0800906c: 1878        adds	r0, r7, r1
@   0x0800906e: 0e01        lsrs	r1, r0, #24
@   0x08009070: 1600        asrs	r0, r0, #24
@   0x08009072: 464a        mov	r2, r9
@   0x08009074: 3231        adds	r2, #49	@ 0x31
@   0x08009076: 7812        ldrb	r2, [r2, #0]
@   0x08009078: 4290        cmp	r0, r2
@   0x0800907a: dba1        blt.n	0x8fc0
@   0x0800907c: b001        add	sp, #4
@   0x0800907e: bc38        pop	{r3, r4, r5}
@   0x08009080: 4698        mov	r8, r3
@   0x08009082: 46a1        mov	r9, r4
@   0x08009084: 46aa        mov	sl, r5
@   0x08009086: bcf0        pop	{r4, r5, r6, r7}
@   0x08009088: bc01        pop	{r0}
@   0x0800908a: 4700        bx	r0

        thumb_func_start sub_08008F98
sub_08008F98: @ 0x08008f98
        .incbin "frog_us_baserom.gba", 0x8f98, 0xf4
        thumb_func_end sub_08008F98
